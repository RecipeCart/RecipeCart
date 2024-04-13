import 'dart:async';
import 'dart:convert';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:recipe_cart/features/recipe/service/search_recipe_lambda_invoker.dart';
import 'package:recipe_cart/models/Recipe.dart';
import 'package:recipe_cart/models/ModelProvider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:recipe_cart/features/settings/service/settings_api_service.dart';

final recipeAPIServiceProvider = Provider<RecipeAPIService>((ref) {
  final service = RecipeAPIService();
  return service;
});

class RecipeAPIService {
  RecipeAPIService();

  final SettingsAPIService settingsAPIService = SettingsAPIService();
  final SearchRecipeLambdaInvoker searchRecipeLambdaInvoker =
      SearchRecipeLambdaInvoker();

  int offset = 0;

  Future<List<Recipe?>> searchRecipes(
      String searchEntry,
      List<List<String>> allRelatedNames,
      List<List<String>> allRelatedAvoidances,
      String dietType) async {
    // convert avoidances to allRelatedAvoidances
    List<Ingredient> ingredientAvoidances =
        settingsAPIService.ingredientAvoidances;
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

    if (settings.savedRecipes!.isEmpty) {
      return <String>[].add(recipeID);
    }
    settings.savedRecipes!.add(recipeID);

    try {
      // updateUserSettings is a custom GraphQL request
      final saveRecipeRequest = GraphQLRequest<Settings>(
        document: graphQLDocument,
        modelType: Settings.classType,
        variables: <String, String>{
          'id': settings.id,
          'savedRecipes': jsonEncode(settings.savedRecipes)
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
      safePrint('updateUserSettings failed: $error');
    }
  }

  Future<Recipe> rateRecipe() async {
    // call bryan's lambda
  }
}
