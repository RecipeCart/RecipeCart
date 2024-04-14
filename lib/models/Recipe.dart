class Recipe {
  late String id;
  late String recipeName;
  late List<String> ingredients;
  late String instructions;
  late double averageRatings;
  late int numRatings;
  bool saved = false;

  Recipe(
      {required this.id,
      required this.recipeName,
      required this.ingredients,
      required this.instructions,
      required this.averageRatings,
      required this.numRatings});

  // expected to receive Recipe as JSON without 'saved' field
  Recipe.fromJson(Map<String, dynamic> json) {
    id = json['recipeID'];
    recipeName = json['recipeName'];
    ingredients = json['ingredients'].cast<String>();
    instructions = json['instructions'];
    averageRatings = json['averageRatings'];
    numRatings = json['numRatings'];
  }

  Recipe.fromWeaviate(Map<String, dynamic> weaviateJson) {
    List<int> castedRatings = weaviateJson['rating'].cast<int>();

    id = weaviateJson['_additional']['id'];
    recipeName = weaviateJson['title'];
    ingredients = weaviateJson['ingredients_sliced'].cast<String>();
    instructions = weaviateJson['instructions'];
    averageRatings = getAverageRatingsFromWeaviate(castedRatings);
    numRatings = castedRatings.reduce((a, b) => a + b);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['recipeID'] = id;
    data['recipeName'] = recipeName;
    data['ingredients'] = ingredients;
    data['instructions'] = instructions;
    data['averageRatings'] = averageRatings;
    data['numRatings'] = numRatings;
    data['saved'] = saved;
    return data;
  }

  double getAverageRatingsFromWeaviate(List<int> rating) {
    double averageRatings = 0;

    for (var i = 0; i < rating.length; i++) {
      averageRatings += rating[i] * (i + 1);
    }

    return averageRatings / rating.reduce((a, b) => a + b);
  }
}

List<Recipe> parseRecipes(List<dynamic> recipes) {
  return recipes.map<Recipe>((element) => Recipe.fromJson(element)).toList();

  // return parsed.map<Recipe>((json) => Recipe.fromJson(json)).toList();
}

List<Recipe> parseFromWeaviate(final List<dynamic> weaviateRecipes) {
  return weaviateRecipes
      .map<Recipe>(
          (element) => Recipe.fromWeaviate(element['data']['Get']['Recipe'][0]))
      .toList();
}
