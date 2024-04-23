import json
import os
import weaviate
import boto3
import requests

def lambda_handler(event, context):
    # validate user setting
    """
    Mutate DynamoDB via GraphQL to put ingredients_labeled
    """
    # query ddb
    
    session = requests.Session()
    
    url = os.environ['API_RECIPECART_GRAPHQLAPIENDPOINTOUTPUT']
    apikey = os.environ['API_RECIPECART_GRAPHQLAPIKEYOUTPUT']
    headers = {'X-API-KEY': apikey, 'Content-Type': 'application/json'}
    
    body = """ 
        query MyQuery {
            getSettings(id: \""""+ event['body']['settingsID'] +"""\")
            {
                id
                ratedRecipes
            }
        }
    """
    query = {'query':body}
    #print(query)
    
    # put item via graphQL request
    response = session.request(
        url = url,
        method='POST',
        json = query,
        headers = headers
        )
        
    print(response.status_code)
    print(response.content.decode('utf-8'))
    
    user_data = json.loads(response.content.decode('utf-8'))
    recipeList = user_data['data']['getSettings']['ratedRecipes']
    if event['body']['recipeID'] in recipeList:
        return {
            'statusCode': 200,
            'body': {
                'message': "user already rated"
            }
        }
    
    # acquire recipe by id
    client = weaviate.Client(url = os.environ["WEAVIATE_GRAPHQL_ENDPOINT"])
    
    result = client.data_object.get_by_id(
        event['body']['recipeID'],
        class_name= 'Recipe'
    )
    
    
    
    rating_count = result["properties"]["rating"]
    
    if event['body']['rating'] not in [1, 2, 3, 4, 5]:
        return {
            'statusCode': 200,
            'body': {
                'message': "invalid rating"
            }
        }
    
    rating_count[event['body']['rating'] - 1] += 1
    
    client.data_object.update(
        uuid=event['body']['recipeID'],
        class_name="Recipe",
        data_object={
            "rating": rating_count,
        },
    )
    
    # mark user as having already rated in user setting
    body = """ 
        mutation MyMutation {
            updateSettings(input:
            {
                id: \"""" + event['body']['settingsID'] + """\",
                ratedRecipes: """ + json.dumps(recipeList + [event['body']['recipeID']]) + """
            })
            {
                id
            }
        }
    """
    query = {'query':body}
    #print(query)
    
    # put item via graphQL request
    response = session.request(
        url = url,
        method='POST',
        json = query,
        headers = headers
        )
    
    return {
        'statusCode': 200,
        'body': {
            'message': "Successfully added rating",
            'recipeID': result['id'],
            'averageRatings': getRating(rating_count),
            'numRatings': sum(rating_count)
        }
    }

def getRating(ratingCounts: list) -> float:
    return sum([(i+1)*ratingCounts[i] for i in range(len(ratingCounts))])/sum(ratingCounts) if sum(ratingCounts) > 0 else 0.0

    