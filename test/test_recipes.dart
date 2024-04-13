import 'package:recipe_cart/features/recipe/service/recipe_api_service.dart';
import 'package:recipe_cart/features/settings/data/settings_api_data.dart';
import 'package:recipe_cart/models/Recipe.dart';
import 'package:recipe_cart/models/ModelProvider.dart';
import 'package:test/test.dart';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:http/http.dart';
import 'package:recipe_cart/features/recipe/service/search_recipe_lambda_invoker.dart';
import 'package:recipe_cart/features/settings/service/settings_api_service.dart';

void main() async {
  RecipeAPIService recipeAPIService = RecipeAPIService();
  test("Testing searchRecipes", () {
    const searchEntry = "mac";
    const allRelatedNames = [
      ["cheese", "milk", "skimmed milk"],
      ["spaghetti", "pasta", "macaroni"]
    ];
    final dietType = DietType.all.name;

    final recipes = recipeAPIService.searchRecipes(
        searchEntry, allRelatedNames, allRelatedNames, dietType);
  });
}
