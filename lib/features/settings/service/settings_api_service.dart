import 'dart:async';
import 'dart:convert';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:collection/collection.dart';
import 'package:recipe_cart/models/ModelProvider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_cart/models/Recipe.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';

final settingsAPIServiceProvider = Provider<SettingsAPIService>((ref) {
  final service = SettingsAPIService();
  return service;
});

class SettingsAPIService {
  SettingsAPIService();

  List<Ingredient> ingredientAvoidances = <Ingredient>[];
  List<Recipe> savedRecipes = <Recipe>[];

  // get Settings for current user
  Future<Settings> getUserSettings() async {
    final currentUser = await Amplify.Auth.getCurrentUser();
    final String cognitoID = currentUser.userId;

    const operationName = "settingsByOwner";
    final graphQLDocument = '''query getUserSettings {
      $operationName(owner: "$cognitoID::$cognitoID") {
        items {
              owner
              email
              avoidances
              createdAt
              dietType
              id
              language
              linkedDevices
              notifications
              ratedRecipes
              savedRecipes
              updatedAt
            }
      }
    }''';
    try {
      // getUserSettings is a custom GraphQL request
      final getUserSettingsRequest = GraphQLRequest<PaginatedResult<Settings>>(
        document: graphQLDocument,
        modelType: const PaginatedModelType(Settings.classType),
        // variables: <String, String>{'value': "$cognitoID::$cognitoID"},
        decodePath: operationName,
      );

      final response = await Amplify.API
          .query(
            request: getUserSettingsRequest,
          )
          .response;

      if (response.data == null) {
        safePrint("User settings not found. Force sign out.");
        Amplify.Auth.signOut();
      }

      final Settings settings = response.data!.items[0]!;

      safePrint("User settings retrieved: $settings");

      // re-fetch the avoidances as ingredients
      if (settings.avoidances!.length != ingredientAvoidances.length) {
        ingredientAvoidances = [];
        await _populateIngredientAvoidances(settings.avoidances!);
      }
      // re-fetch savedRecipes
      if (settings.savedRecipes!.length != savedRecipes.length) {
        savedRecipes = [];
        savedRecipes = await _getSavedRecipes(settings);
      }

      return settings;
    } on Exception catch (error) {
      safePrint('getSettings failed: $error');
      rethrow;
    }
  }

  // update Settings
  Future<void> updateUserSettings(String settingsID, List<String> avoidances,
      int dietType, bool notificationStatus, int language) async {
    const operationName = "updateSettings";
    const graphQLDocument =
        '''mutation UpdateUserSettings(\$id: ID!, \$avoidances: [String]!, \$dietType: Int!, \$notificationStatus: Boolean!, \$language: Int!) {
      $operationName(
        input: {id: \$id,
        avoidances: \$avoidances,
        dietType: \$dietType,
        notifications: \$notificationStatus,
        language: \$language
        }) {
          id
          avoidances
          dietType
          notifications
          language
      }
    }''';

    try {
      // updateUserSettings is a custom GraphQL request
      final updateUserSettingsRequest = GraphQLRequest<Settings>(
        document: graphQLDocument,
        modelType: Settings.classType,
        variables: <String, dynamic>{
          'id': settingsID,
          'avoidances': avoidances,
          'dietType': dietType.toString(),
          'language': language.toString(),
          'notificationStatus': notificationStatus.toString()
        },
        decodePath: operationName,
      );

      final response = await Amplify.API
          .mutate(
            request: updateUserSettingsRequest,
          )
          .response;

      safePrint(response);

      safePrint("Updated settings");

      // re-fetch the avoidances as ingredients
      if (!const DeepCollectionEquality.unordered().equals(
          ingredientAvoidances.map((e) => e.ingredientName).toList(),
          response.data!.avoidances)) {
        ingredientAvoidances = [];
        safePrint("\n\n\ngot in here\n\n");
        await _populateIngredientAvoidances(response.data!.avoidances!);
      }

      safePrint("\n\n\nAvoidance length after update: " +
          getAvoidances().length.toString());
      // re-fetch savedRecipes
      if (!const DeepCollectionEquality.unordered()
          .equals(savedRecipes.map((e) => e.id), response.data!.savedRecipes)) {
        safePrint("\n\n\ngot in here\n\n");

        savedRecipes = [];
        savedRecipes = await _getSavedRecipes(response.data!);
      }
      safePrint("\n\n\nAvoidance length after update: " +
          getSavedRecipes().length.toString());
    } on Exception catch (error) {
      safePrint('updateUserSettings failed: $error');
    }
  }

  List<Ingredient> getAvoidances() {
    return ingredientAvoidances;
  }

  List<Recipe> getSavedRecipes() {
    return savedRecipes;
  }

  Future<void> _populateIngredientAvoidances(
      final List<String> avoidances) async {
    const operationName = "ingredientByName";

    for (final String avoidance in avoidances) {
      final graphQLDocument = '''query getAvoidance {
          $operationName(ingredientName: "$avoidance", filter: {userID: {attributeExists: false}}) {
            items {
              id
              ingredientName
              relatedNames
              removed
            }
          }
        }''';
      try {
        // getUserSettings is a custom GraphQL request
        final getAvoidanceRequest = GraphQLRequest<PaginatedResult<Ingredient>>(
          document: graphQLDocument,
          modelType: const PaginatedModelType(Ingredient.classType),
          decodePath: operationName,
        );

        final response = await Amplify.API
            .query(
              request: getAvoidanceRequest,
            )
            .response;

        if (response.data!.items.isEmpty) {
          safePrint("Unable to fetch ingredient avoidance: $avoidance");
          continue;
        }

        final avoided = response.data!.items[0]!;

        safePrint(
            "Successfully retrieved ingredient avoidance: ${avoided.ingredientName}");

        // add to ingredient avoidance list
        ingredientAvoidances.add(avoided);
      } on Exception catch (e) {
        safePrint("populateAvoidances failed: $e");
      }
    }

    if (avoidances.length == ingredientAvoidances.length) {
      safePrint("Successfully retrieved all avoidances as ingredients");
    } else if (avoidances.isEmpty) {
      safePrint("No avoidances specified");
    } else {
      safePrint("Avoidance ingredients list incompleted");
    }
  }

  Future<List<Recipe>> _getSavedRecipes(Settings settings) async {
    if (settings.savedRecipes == null || settings.savedRecipes!.isEmpty) {
      return const [];
    }

    List<dynamic> queries = [];

    for (final saved in settings.savedRecipes!) {
      queries.add({
        "query": """{
        Get {
          Recipe(where: {path: ["id"], operator: Equal, valueString: "$saved"}) {
            title
            ingredients_sliced
            instructions
            rating
            _additional {
                id
            }
          }
        }
      }
      """
      });
    }

    try {
      // Weaviate URL from environment
      String? url = dotenv.env['WEAVIATE_GRAPHQL_ENDPOINT'];
      Response response = await post(Uri.parse("${url!}/v1/graphql/batch"),
          headers: {'Content-Type': 'application/json; charset=UTF-8'},
          body: jsonEncode(queries));

      final List<dynamic> jsonResponse = jsonDecode(response.body);
      if (response.statusCode != 200) {
        safePrint("Response from weaviate: $jsonResponse");
        return const [];
      }

      if (jsonResponse.isNotEmpty) {
        List<Recipe> savedRecipes = parseFromWeaviate(jsonResponse);

        // mark these recipes as save on client side
        for (int i = 0; i < savedRecipes.length; i++) {
          savedRecipes[i].saved = true;
        }

        safePrint("Successfully retrieved savedRecipes");
        return savedRecipes;
      } else {
        safePrint("getSavedRecipes returned empty");
        return const [];
      }
    } on Exception catch (error) {
      safePrint("getSavedRecipes error: $error");
      return const [];
    }
  }
}
