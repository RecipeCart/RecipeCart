import 'dart:async';
import 'package:recipe_cart/features/settings/data/settings_repository.dart';
import 'package:recipe_cart/models/ModelProvider.dart';
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
}
