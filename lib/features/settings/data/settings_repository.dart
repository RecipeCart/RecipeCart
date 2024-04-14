import 'package:recipe_cart/models/ModelProvider.dart';
import 'package:recipe_cart/models/Recipe.dart';
import 'package:recipe_cart/features/settings/service/settings_api_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final settingsRepositoryProvider = Provider((ref) {
  final settingsAPIService = ref.read(settingsAPIServiceProvider);
  return settingsAPIService;
});

class SettingsRepository {
  SettingsRepository(this.settingsAPIService);

  final SettingsAPIService settingsAPIService;

  Future<void> updateUserSettings(String settingsID, List<String> avoidances,
      int dietType, bool notificationStatus, int language) async {
    return settingsAPIService.updateUserSettings(
        settingsID, avoidances, dietType, notificationStatus, language);
  }

  Future<Settings> getUserSettings() async {
    return settingsAPIService.getUserSettings();
  }

  List<Ingredient> getAvoidances() {
    return settingsAPIService.getAvoidances();
  }

  List<Recipe> getSavedRecipes() {
    return settingsAPIService.getSavedRecipes();
  }
}
