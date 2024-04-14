import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_cart/features/settings/service/settings_api_service.dart';
import 'package:recipe_cart/models/ModelProvider.dart';

import 'package:amplify_flutter/amplify_flutter.dart';

void main() async {
  SettingsAPIService settingsAPIService = SettingsAPIService();

  test('test get user settings', () async {
    final Settings userSettings = await settingsAPIService.getUserSettings();

    safePrint(jsonEncode(userSettings.toJson()));
  });

  test('test update user settings', () async {
    const String settingsID = "49514985-1544-4b65-a090-4c68520cc45f";
    const avoidances = ['peanut', 'cashew', 'pistachio', 'walnut'];
    const dietType = 0;
    const notificationStatus = false;
    const language = 0;

    await settingsAPIService.updateUserSettings(
        settingsID, avoidances, dietType, notificationStatus, language);
  });
}
