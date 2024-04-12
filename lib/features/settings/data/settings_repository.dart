import 'package:recipe_cart/models/Settings.dart';
import 'package:recipe_cart/features/settings/service/settings_api_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final settingsRepositoryProvider = Provider((ref) {
  final settingsAPIService = ref.read(settingsAPIServiceProvider);
  return settingsAPIService;
});

class SettingsRepository {
  SettingsRepository(this.settingsAPIService);

  final SettingsAPIService settingsAPIService;

  Future<void> updateUserSettings(Settings updatedSettings) async {
    return settingsAPIService.updateUserSettings(updatedSettings);
  }

  Future<Settings> getSettings() async {
    return settingsAPIService.getUserSettings();
  }
}
