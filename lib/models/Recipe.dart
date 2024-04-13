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
    id = json['id'];
    recipeName = json['recipeName'];
    ingredients = json['ingredients'];
    instructions = json['instructions'];
    averageRatings = json['averageRatings'];
    numRatings = json['numRatings'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['recipeName'] = recipeName;
    data['ingredients'] = ingredients;
    data['instructions'] = instructions;
    data['averageRatings'] = averageRatings;
    data['numRatings'] = numRatings;
    data['saved'] = saved;
    return data;
  }
}

List<Recipe> parseRecipes(List<String> recipes) {
  final parsed = recipes.cast<Map<String, dynamic>>();

  return parsed.map<Recipe>((json) => Recipe.fromJson(json)).toList();
}
