import 'package:recipe_cart/features/recipe/service/recipe_api_service.dart';
import 'package:recipe_cart/features/settings/service/settings_api_service.dart';
import 'package:recipe_cart/features/settings/data/settings_api_data.dart';
import 'package:recipe_cart/models/Recipe.dart';
import 'package:recipe_cart/models/ModelProvider.dart';
import 'package:test/test.dart';

import 'package:amplify_flutter/amplify_flutter.dart';

void main() async {
  RecipeAPIService recipeAPIService = RecipeAPIService();
  SettingsAPIService settingsAPIService = SettingsAPIService();

  test("Testing searchRecipes", () async {
    //SettingsController settingsController = SettingsController();
    const searchEntry = "mac";
    const allRelatedNames = [
      ["cheese", "milk", "skimmed milk"],
      ["spaghetti", "pasta", "macaroni"]
    ];
    final avoidances = settingsAPIService.getAvoidances();
    final dietType = DietType.all.name;

    final recipes = await recipeAPIService.searchRecipes(
        searchEntry, allRelatedNames, avoidances, dietType);

    safePrint(recipes.length);
  });

  test("testing saveRecipe", () async {
    const reverse = false;
    const recipeID = "476d49a2-5dd2-4d4a-9d9b-d91d8249827d";
    Settings settings = await settingsAPIService.getUserSettings();
    recipeAPIService.saveRecipe(reverse, recipeID, settings);
  });

  test('test rate recipe', () async {
    const String recipeID = "476d49a2-5dd2-4d4a-9d9b-d91d8249827d";
    Recipe recipe = Recipe(
        id: recipeID,
        recipeName: "fdas",
        ingredients: ["mem", "mam"],
        instructions: "do dab",
        averageRatings: 3.3,
        numRatings: 1);
    Settings settings = await settingsAPIService.getUserSettings();
    recipeAPIService.rateRecipe(4, recipe, settings.id);
  });
}
