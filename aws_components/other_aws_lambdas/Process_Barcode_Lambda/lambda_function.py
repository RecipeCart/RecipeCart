import json
import os
import requests
import weaviate

def lambda_handler(event, context):
    
    # get barcode and cognitoID from event.body
    barcode = event['body']['barcode']
    cognitoID = event['body']['cognitoID']
    
    # category hierarchy specificity
    category_specificity = 4

    name = "Unknown"
    relatedNames = []
    standardQuantity = 0 # quantity standardized to gram
    quantity = '0'
    unit = 'g'
    error = ''
    
    # try fetching from DynamoDB
    try:
        response_item = fromDDB(barcode)
        if not response_item:
            # try fetching from WOFF instead
            prod_info = fromWOFF(barcode)
    
            #  if product not found in WOFF database
            if prod_info['status_verbose'] == 'product not found':
                error = "Product not found"
            else:
                # parse for standardized quantity
                if 'product_quantity' in prod_info['product'] and prod_info['product']['product_quantity']:
                    standardQuantity = prod_info['product']['product_quantity']
                else:
                    error += "Standard quantity not found\n"
                # parse for quantity in conventional units
                if 'quantity' in prod_info['product'] and prod_info['product']['quantity']:
                        l = prod_info['product']['quantity'].split()
                        quantity = l[0]
                        unit = l[1].lower()
                else:
                    error += "Quantity not found\n"
                
                # parse for product name
                language_supported = True
                if 'categories_hierarchy' in prod_info['product'] and len(prod_info['product']['categories_hierarchy']) > category_specificity:
                    # parse through categories hierarchy to find first english name
                    for category in reversed(prod_info['product']['categories_hierarchy']):
                        # grab language header
                        l = category.split(':')
                        # skip if not english
                        if l[0] != "en":
                            language_supported = False
                            continue
                        else:
                            # set name based on category_hierarchy
                            name = l[1]
                            # get list of other relatedNames from Weaviate
                            relatedNames = fromWeaviate(name)
                            
                            language_supported = True
                            break
                        
                    if language_supported is False:
                        error += "Language of product name is not supported\n"

                elif 'product_name_en' in prod_info['product'] and prod_info['product']['product_name_en']:
                    # set name as product label
                    name = prod_info['product']['product_name_en']
                    # get list of other relatedNames from Weaviate
                    relatedNames = fromWeaviate(name)
                else:
                    error += "Name not found\n"
        else:
            name = response_item['ingredientName']
            relatedNames = response_item['relatedNames']
            quantity = response_item['quantity']
            standardQuantity = response_item['standardQuantity']
            unit = response_item['unit']
    except Exception as e:
        error += str(e)

    
    return {
        'statusCode': 200,
        'body': {
            'ingredientName': name,
            'relatedNames': relatedNames,
            'barcode': barcode,
            'quantity': float(quantity),
            'standardQuantity': float(standardQuantity),
            'unit': unit,
            'cognitoID': cognitoID,
        },
        'error': error
    }


def fromDDB(barcode):
    """
    Query DynamoDB via GraphQL to see if it already exists in local database
    """
    # query ddb
    body = (""" 
    query MyQuery {
        ingredientByBarcode(barcode: \"""" + barcode + """\") {
            items {
              id
              ingredientName
              relatedNames
              quantity
              standardQuantity
              unit
            }
        }
    }
    """)
    
    session = requests.Session()
    
    url = os.environ['API_RECIPECART_GRAPHQLAPIENDPOINTOUTPUT']
    apikey = os.environ['API_RECIPECART_GRAPHQLAPIKEYOUTPUT']
    headers = {'X-API-KEY': apikey, 'Content-Type': 'application/json'}

    response = session.request(
        url = url,
        method='POST',
        json = {"query": body},
        headers = headers
        )

    if response.status_code == 200:
        response_json = json.loads(response.content.decode('utf-8'))
        itemsList = response_json['data']['ingredientByBarcode']['items']
        if itemsList:
            # grab the first returned item
            return itemsList[0]

    return ""



def fromWOFF(barcode):
    """
    Query a product with the barcode number using the World OpenFoodFacts API
    """
    
    # url is an environment variable
    addr = os.environ['WOFFURL'].format(barcode)
    
    try:
        r = requests.get(addr)
    except requests.exceptions.RequestException as e:
        print(e)
        print('Error connecting to barcode database {}'.format(addr))
        raise e
        
    return json.loads(r.text)

def fromWeaviate(name):
    """
    Query Weaviate database to check for related names associated with product name
    """
    client = weaviate.Client(url = os.environ['WEAVIATE_GRAPHQL_ENDPOINT'])
    response = (
        client.query
        .get("IngredientType", ["name", "primary_category", "secondary_category", "allergens"])
        .with_hybrid(
            query = name,
            alpha = 0.30
        )
        .with_limit(3)
        .with_additional(['id'])
        .do()
    )
    return [i['name'] for i in response['data']['Get']['IngredientType']]