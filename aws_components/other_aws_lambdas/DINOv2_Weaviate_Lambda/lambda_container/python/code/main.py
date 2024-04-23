import io
import os
import time
import boto3
import base64
from io import BytesIO
import requests
import torch
from PIL import Image
from torchvision import transforms
import weaviate
client = weaviate.Client(url = 'http://ab6845c69ed694da6a45490012c4a093-1084787436.us-east-2.elb.amazonaws.com')
s3_resource = boto3.resource('s3')
#copy from /var/task/torch to /tmp/torch
os.system("cp -r /var/task/torch /tmp")
torch.hub.set_dir('/tmp/torch/hub')
model = torch.hub.load('facebookresearch/dinov2', 'dinov2_vits14')

def get_associated(name, k, where = {}):
  response = (
      client.query
      .get("IngredientType", ["name", "primary_category", "secondary_category", "allergens"])
#      .with_where(
#        {
#          'path': ['primary_category'],
#          'operator': 'Equal',
#          'valueText':"unknown"
#        }
#      )
      .with_hybrid(
          query = name,
          alpha = 0.30
      )
      .with_limit(k)
      .with_additional(['id'])
      .do()
  )
  if response['data']['Get']['IngredientType'] == None:
    print("gave:",name, k, "got:", response)
    return set([])
  return [i['name'] for i in response['data']['Get']['IngredientType']]

def make_transform() -> transforms.Compose:
  return transforms.Compose([transforms.ToTensor()])

def download_image(url):
    try:
        r = requests.get(url)
        if r.status_code == 200:
            f = io.BytesIO(r.content)
            img = Image.open(f).convert('RGB')
            return img
        else:
            return None
    except:
        return None

def img2vec(image: Image) -> list:
  transform = make_transform()
  rescaled_image = image.resize(((image.width //14)*14, (image.height //14)*14))
  transformed_image = transform(rescaled_image)
  batch = transformed_image.unsqueeze(0)#.cuda()
  with torch.inference_mode():
    return model.forward(batch).tolist()[0]

def lambda_handler(event, context):
    # connect client
    print("Connecting to Client:")
    try:
        client = weaviate.Client(url='http://ab6845c69ed694da6a45490012c4a093-1084787436.us-east-2.elb.amazonaws.com')
    except requests.exceptions.ConnectionError:
        return {
                'statusCode': 69,
                'error': "Connection refused."
            }
    # download model
    print("Downloading PyTorch model:")
    model = torch.hub.load('facebookresearch/dinov2', 'dinov2_vits14')
    # download image
    print("Loading image:")
    #img = download_image(event['url'])
    im_bytes = base64.b64decode(event['body']['img'])   # im_bytes is a binary image
    im_file = BytesIO(im_bytes)
    img = Image.open(im_file)
    # classify image
    print("Classifying image:")
    if img:
        #process image
        response = (
                    client.query
                    .get("ingredient", ["ingredient_name"])
                    .with_near_vector({
                            "vector": img2vec(img)
                        })
                    .with_limit(2)
                    .do()
                )


        return {
            'statusCode': 200,
            'class': response,
            'ingredientName': response['data']['Get']['Ingredient'][0]['ingredient_name'],
            'relatedNames': get_associated(response['data']['Get']['Ingredient'][0]['ingredient_name'].lower(), 3)
        }
    else:
        return {
            'statusCode': 404,
            'class': None
        }
