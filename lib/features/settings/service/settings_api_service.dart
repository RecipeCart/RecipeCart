import 'dart:async';
import 'dart:convert';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:recipe_cart/models/ModelProvider.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final settingsAPIServiceProvider = Provider<SettingsAPIService>((ref) {
  final service = SettingsAPIService();
  return service;
});

class SettingsAPIService {
  SettingsAPIService();

  List<Ingredient> ingredientAvoidances = [];

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
        decodePath: "$operationName",
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
      if (settings.avoidances!.isNotEmpty) {
        _populateIngredientAvoidances(settings.avoidances!);
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
        variables: <String, String>{
          'id': settingsID,
          'avoidances': jsonEncode(avoidances),
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
    } on Exception catch (error) {
      safePrint('updateUserSettings failed: $error');
    }
  }

  Future<void> _populateIngredientAvoidances(
      final List<String> avoidances) async {
    for (final String avoidance in avoidances) {
      try {
        final request = ModelQueries.get(
            Ingredient.classType, IngredientModelIdentifier(id: avoidance));
        final response = await Amplify.API.query(request: request).response;
        final ingredient = response.data;
        if (ingredient == null) {
          safePrint('populateAvoidances errors: ${response.errors}');
          return;
        }
        safePrint(
            "Successfully retrieved ingredient avoidance ${ingredient.ingredientName}");

        // add to ingredient avoidance list
        ingredientAvoidances.add(ingredient);
      } on Exception catch (e) {
        safePrint("populateAvoidances failed: $e");
      }
    }

    if (avoidances.length == ingredientAvoidances.length) {
      safePrint("Successfully retrieved all avoidances as ingredients");
    } else {
      safePrint("Avoidance ingredients list incompleted");
    }
  }
}
