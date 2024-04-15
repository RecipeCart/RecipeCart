import 'dart:async';
import 'package:recipe_cart/features/settings/data/settings_repository.dart';
import 'package:recipe_cart/models/ModelProvider.dart';
import 'package:recipe_cart/models/Recipe.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'settings_controller.g.dart';

@riverpod
class SettingsController extends _$SettingsController {
  Future<Settings> _getUserSettings() async {
    final settingsRepository = ref.read(settingsRepositoryProvider);
    final settings = await settingsRepository.getUserSettings();
    return settings;
  }

  @override
  FutureOr<Settings> build() async {
    return _getUserSettings();
  }

  Future<void> updateSettings(
      {required String settingsID,
      required List<String> avoidances,
      required int dietType,
      required bool notificationStatus,
      required int language}) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      final settingsRepository = ref.read(settingsRepositoryProvider);
      await settingsRepository.updateUserSettings(settingsID, avoidances, dietType, notificationStatus, language);
      return _getUserSettings();
    });
  }

  List<Ingredient> getAvoidances() {
    final settingsRepository = ref.read(settingsRepositoryProvider);
    return settingsRepository.getAvoidances();
  }

  List<Recipe> getSavedRecipes() {
    final settingsRepository = ref.read(settingsRepositoryProvider);
    return settingsRepository.getSavedRecipes();
  }
}
