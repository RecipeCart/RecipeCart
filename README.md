# recipe_cart

A Senior Design II Project from the College of Engineering and Computer Science for Spring 2024 at the University of Central Florida

## About

The RecipeCart encompasses a modern solution to consumerism habits, providing users with alternatives to their food leftover dilemmas. Recipes are recommended to users based on the ingredients available to them, which directly reflects the user’s physical inventory. Ingredients are dynamically identified through computer vision algorithms using a mini computer, and server-side logistics are handled through cloud-based services. This paper discusses the project’s goals and constraints, the principal hardware and software components, the designs and methodologies employed, and system testing procedures and results.

## Resources

RecipeCart is hosted on AWS amplify.

It performs content-based filtering and approximate knn classification with [Weaviate Vector Database](https://weaviate.io/developers/weaviate). For more information, refer to README.MD in aws_components/ec2.

Ingredient images are encoded using [Meta's DinoV2](https://dinov2.metademolab.com).

Barcode data is fetched from [World Open Food Facts](https://world.openfoodfacts.org).

Recipes can be fetched from Recipe1M or [RecipeNLG](https://recipenlg.cs.put.poznan.pl) (though much data cleaning will be needed).
