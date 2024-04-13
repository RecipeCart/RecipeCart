import 'dart:async';
import 'dart:convert';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:http/http.dart';
import 'package:recipe_cart/features/recipe/service/search_recipe_lambda_invoker.dart';
import 'package:recipe_cart/models/Recipe.dart';
import 'package:recipe_cart/models/ModelProvider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final recipeAPIServiceProvider = Provider<RecipeAPIService>((ref) {
  final service = RecipeAPIService();
  return service;
});

class RecipeAPIService {
  RecipeAPIService();

  late List<Ingredient> ingredientAvoidances;

  final SearchRecipeLambdaInvoker searchRecipeLambdaInvoker =
      SearchRecipeLambdaInvoker();

  int offset = 0;

  Future<List<Recipe?>> searchRecipes(
      String searchEntry,
      List<List<String>> allRelatedNames,
      Settings settings) async {

    // convert avoidances to allRelatedAvoidances
    List<List<String>> allRelatedAvoidances = [];



    try {
      final response = await searchRecipeLambdaInvoker.searchRecipes(
          searchEntry, allRelatedNames, dietType, avoidances, offset);

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

  Future<List<Recipe?>>getSavedRecipes(Settings settings) async  {
    List<String> queries = [];

    for (final saved in settings.savedRecipes!) {
      queries.add("""
        Recipe(id: $saved) {
          id,
          title,
          ingredients_sliced,
          instructions,
          ratings
        }
      """);
    }

    try {
      // Weaviate URL
      String? url = dotenv.env['WEAVIATE_GRAPHQL_ENDPOINT'];
      Response response = await post(
        Uri.parse("${url!}/v1/graphql/batch"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(queries)
      );

      final jsonResponse = jsonDecode(response.body);
      if (jsonResponse['data']['Get']['Recipe'] != null) {
        List<Recipe> savedRecipes = parseRecipes(jsonResponse['data']['Get']['Recipe']);

        for (int i = 0; i < savedRecipes.length; i++) {
          savedRecipes[i].saved = true;
        }

        return savedRecipes;
      }
      else {
        safePrint("getSavedRecipes returned empty");
        return const[];
      }

    } on Exception catch (error) {
      safePrint("getSavedRecipes error: $error");
      return const [];
    }
  }

  Future<void> saveRecipe(bool reverse, String recipeID, String settingsID, List<String> savedRecipes) async {
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

    savedRecipes.add(recipeID);

    try {
      // updateUserSettings is a custom GraphQL request
      final saveRecipeRequest = GraphQLRequest<Settings>(
        document: graphQLDocument,
        modelType: Settings.classType,
        variables: <String, String>{
          'id': settingsID,
          'savedRecipes': jsonEncode(savedRecipes)
        },
        decodePath: operationName,
      );

      final response = await Amplify.API
          .mutate(
            request: updateUserSettingsRequest,
          )
          .response;

      safePrint(response);
    } on Exception catch (error) {
      safePrint('updateUserSettings failed: $error');
    }
  }

  }

  Future<Recipe> rateRecipe() async {
    
  }
}
