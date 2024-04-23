import json
import weaviate
import boto3
import os

def lambda_handler(event, context):
    # Grab diet type constraints from s3
    s3 = boto3.resource('s3')
    content_object = s3.Object('kaggle-test-1', 'diet_type_blacklist.json')
    file_content = content_object.get()['Body'].read().decode('utf-8')
    json_content = json.loads(file_content)
    
    #key fetches scores from inventory and recipe and will be used to sort list of recipes
    key = lambda inventory, alpha = 0.7, beta = 0.2: (lambda recipe: getScore(recipe, inventory, alpha = alpha))
    filter_avoidance = (
        lambda blacklist: (
           lambda recipe: all([(entry['name'] not in blacklist) for entry in recipe['hasIngredientType']])
        )
    )
    
    #event['body']['allRelatedNames'], event['body']['dietType'], event['body']['avoidances'], event['body']['searchEntry'], event['body']['offset']
    inventory = set.union(*[set(entry) for entry in event['body']['allRelatedNames']]) if event['body']['allRelatedNames'] else set()
    blacklist = (
            (
            set.union(*[set(entry) for entry in event['body']['avoidances']]) | set(json_content[event['body']['dietType']])
            if event['body']['dietType'] in json_content
            else set.union(*[set(entry) for entry in event['body']['avoidances']])
        ) if event['body']['avoidances']
        else set(json_content[event['body']['dietType']])
        if event['body']['dietType'] in json_content
        else set()
    )
    
    # get list of recipes
    recipes = getRecipes(
        event['body']['searchEntry'],
        offset = event['body']['offset']
        if event['body']['offset']
        else None,
        relatedNames = list(inventory)
    )
    offset = len(recipes) + event['body']['offset']
    filtered_recipes = filter(filter_avoidance(blacklist), recipes)
    results = sorted(filtered_recipes, key=key(inventory))
    print("filtered sorted results",results)
    
    return {
        'statusCode': 200,
        'body': {
            'recipes': [
                {
                    "recipeID": result["_additional"]["id"],
                    "recipeName": result["title"],
                    "ingredients": result["ingredients_sliced"],
                    "instructions": result["instructions"],
                    "averageRatings": getRating(result["rating"]),
                    "numRatings": sum(result["rating"])
                }
                for result in results
            ],
            "offset": offset
        }
    }

def getRating(ratingCounts: list) -> float:
    return sum([(i+1)*ratingCounts[i] for i in range(len(ratingCounts))])/sum(ratingCounts) if sum(ratingCounts) > 0 else 0.0


def getRecipes(query: str, alpha = 0.3, limit = 20, offset = None, relatedNames = [], force = 1.0) -> list:
    """
    Query Weaviate database to check for related names associated with product name
    """
    client = weaviate.Client(url = os.environ['WEAVIATE_GRAPHQL_ENDPOINT'])
    
    
    # initial query
    get = (
        client.query
        .get("Recipe", ["title", "instructions", "ingredients_sliced", "rating", "hasIngredientType{... on IngredientType{name}}"])
    )
    
    # if search text is not empty
    if query:
        get = (get.with_hybrid(
            query = query,
            alpha = alpha
        ).with_limit(limit)
        .with_additional(['id']))
    elif relatedNames:
        get = get.with_limit(limit).with_near_text({
                "concepts": relatedNames,
                "moveTo": {
                    "concepts": relatedNames,
                    "force": force
                }
            }).with_additional(['id'])
    else:
        get = get.with_limit(limit).with_additional(['id'])
    
    
    if offset is not None:
        results = get.with_offset(offset).do()
    else:
        results = get.do()
    
    
    return results['data']['Get']['Recipe']
    
def getScore(recipe: dict, inventory: set, alpha:float = 0.7, beta:float = 0.2) -> float:
    """
    generate scores for recipe soft ranking by ingredients
    """
    if not recipe: return 0.0;
    recipe_set = set([entry['name'] for entry in recipe['hasIngredientType']])
    if recipe_set:
        return (
            (alpha**(beta*sum(recipe['rating'])))*(len(recipe_set & inventory)/len(recipe_set))
            + (1-(beta*sum(recipe['rating'])))*getRating(recipe['rating'])/5
        )
    else:
        return 0.0
    