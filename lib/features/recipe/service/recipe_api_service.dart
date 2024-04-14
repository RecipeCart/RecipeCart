import 'dart:async';
import 'dart:convert';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:recipe_cart/features/recipe/service/rate_recipe_lambda.dart';
import 'package:recipe_cart/features/recipe/service/search_recipe_lambda_invoker.dart';
import 'package:recipe_cart/models/Recipe.dart';
import 'package:recipe_cart/models/ModelProvider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final recipeAPIServiceProvider = Provider<RecipeAPIService>((ref) {
  final service = RecipeAPIService();
  return service;
});

class RecipeAPIService {
  RecipeAPIService();

  final SearchRecipeLambdaInvoker searchRecipeLambdaInvoker =
      SearchRecipeLambdaInvoker();

  final RatingProcessor ratingProcessor = RatingProcessor();

  int offset = 0;

  Future<List<Recipe?>> searchRecipes(
      String searchEntry,
      List<List<String>> allRelatedNames,
      List<Ingredient> ingredientAvoidances,
      String dietType) async {
    // convert avoidances to allRelatedAvoidances
    List<List<String>> allRelatedAvoidances = [];

    if (ingredientAvoidances.isNotEmpty) {
      ingredientAvoidances.map((e) => allRelatedAvoidances.add(e.relatedNames));
    }

    try {
      final response = await searchRecipeLambdaInvoker.searchRecipes(
          searchEntry, allRelatedNames, dietType, allRelatedAvoidances, offset);

      // convert to json
      final data = jsonDecode(response);
      if (data['body']['recipes'] == null) {
        safePrint('searchRecipes returned no recipes');
        return const [];
      }

      // update offset value for next list fetch
      offset = data['body']['offset'];

      safePrint(data);

      // convert list of strings to list of recipes
      List<Recipe> recipes = parseRecipes(data['body']['recipes']);

      return recipes;
    } on Exception catch (error) {
      safePrint('getRecipeList failed: $error');
      return const [];
    }
  }

  Future<void> saveRecipe(
      bool reverse, String recipeID, Settings settings) async {
    const operationName = "updateSettings";
    const graphQLDocument =
        '''mutation SaveRecipe(\$id: ID!, \$savedRecipes: [String]) {
      $operationName(
        input: {id: \$id,
        savedRecipes: \$savedRecipes
        }) {
          id
          savedRecipes
      }
    }''';

    // check if recipe is already saved before removing
    if (reverse) {
      if (settings.savedRecipes!.contains(recipeID)) {
        settings.savedRecipes!.remove(recipeID);
      } else {
        safePrint(
            "Tried to unsave a recipe that has not been saved: $recipeID");
      }
    } // check if recipe is not saved before adding
    else {
      if (!settings.savedRecipes!.contains(recipeID)) {
        settings.savedRecipes!.add(recipeID);
      } else {
        safePrint("Tried to save a recipe that is already saved: $recipeID");
      }
    }

    try {
      // SaveRecipe is a custom GraphQL request
      final saveRecipeRequest = GraphQLRequest<Settings>(
        document: graphQLDocument,
        modelType: Settings.classType,
        variables: <String, dynamic>{
          'id': settings.id,
          'savedRecipes': settings.savedRecipes
        },
        decodePath: operationName,
      );

      final response = await Amplify.API
          .mutate(
            request: saveRecipeRequest,
          )
          .response;

      safePrint(response);
    } on Exception catch (error) {
      safePrint('SaveRecipe failed: $error');
    }
  }

  // rates recipe in Weaviate database and returns newly rated recipe
  Future<Recipe> rateRecipe(
      final int rating, Recipe recipe, final String settingsID) async {
    if (rating < 1 || rating > 5) {
      safePrint("Invalid Rating Input");
    } else {
      String response =
          await ratingProcessor.updateRating(rating, recipe.id, settingsID);

      final jsonResponse = jsonDecode(response);

      if (jsonResponse['body'].containsKey('recipeID')) {
        recipe.averageRatings = jsonResponse['body']['averageRatings'];
        recipe.numRatings = jsonResponse['body']['numRatings'];
      } else {
        safePrint(
            "Recipe rating did not change: ${jsonResponse['body']['message']}");
      }
    }

    return recipe;
  }
}
