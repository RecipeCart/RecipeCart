import 'dart:async';
import 'dart:convert';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:recipe_cart/models/ModelProvider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final settingsAPIServiceProvider = Provider<SettingsAPIService>((ref) {
  final service = SettingsAPIService();
  return service;
});

class SettingsAPIService {
  SettingsAPIService();

  // get Settings for current user
  Future<Settings> getUserSettings() async {
    final currentUser = await Amplify.Auth.getCurrentUser();
    final String cognitoID = currentUser.userId;

    const operationName = "settingsByOwner";
    const graphQLDocument = '''query getUserSettings(\$user: String!) {
      $operationName(owner: \$user) {
        avoidances
        dietType
        email
        id
        ratedRecipes
        savedRecipes
        linkedDevices
        language
        notifications
        owner
      }
    }''';
    try {
      // getUserSettings is a custom GraphQL request
      final getUserSettingsRequest = GraphQLRequest<Settings>(
        document: graphQLDocument,
        modelType: Settings.classType,
        variables: <String, String>{'user': "$cognitoID::$cognitoID"},
        decodePath: operationName,
      );

      final response = await Amplify.API
          .query(
            request: getUserSettingsRequest,
          )
          .response;

      safePrint(response);
      final settings = response.data!;
      return settings;
    } on Exception catch (error) {
      safePrint('getSettings failed: $error');
      rethrow;
    }
  }

  // update Settings
  Future<void> updateUserSettings(Settings updatedSettings) async {
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
          'id': updatedSettings.id,
          'avoidances': jsonEncode(updatedSettings.avoidances),
          'dietType': updatedSettings.dietType.toString(),
          'language': updatedSettings.language.toString(),
          'notificationStatus': updatedSettings.notifications.toString()
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
