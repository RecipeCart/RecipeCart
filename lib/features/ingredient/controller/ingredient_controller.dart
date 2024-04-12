import 'dart:async';
import 'package:recipe_cart/features/ingredient/data/ingredient_repository.dart';
import 'package:recipe_cart/models/ModelProvider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ingredient_controller.g.dart';

@riverpod
class IngredientListController extends _$IngredientListController {
  Future<List<Ingredient?>> _getIngredientInventory() async {
    final ingredientRepository = ref.read(ingredientRepositoryProvider);
    final ingredients = await ingredientRepository.searchIngredients();
    return ingredients;
  }

  @override
  FutureOr<List<Ingredient?>> build() async {
    return _getIngredientInventory();
  }

  Future<void> addIngredient({
    required String ingredientName,
    required List<String> relatedNames,
    String? barcode,
    double? quantity,
    String? unit,
    double? standardQuantity,
  }) async {
    final ingredient = Ingredient(
        ingredientName: ingredientName,
        relatedNames: relatedNames,
        barcode: barcode,
        quantity: quantity,
        unit: unit,
        standardQuantity: standardQuantity,
        removed: false);

    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      final ingredientRepository = ref.read(ingredientRepositoryProvider);
      await ingredientRepository.addIngredient(ingredient);
      return _getIngredientInventory();
    });
  }

  Future<void> removeIngredient({required String id}) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      final ingredientRepository = ref.read(ingredientRepositoryProvider);
      await ingredientRepository.removeIngredient(id);
      return _getIngredientInventory();
    });
  }

  // Future<void> updateIngredient(
  //     {required String id, required double quantity}) async {
  //   state = const AsyncValue.loading();

  //   state = await AsyncValue.guard(() async {
  //     final ingredientRepository = ref.read(ingredientRepositoryProvider);
  //     await ingredientRepository.updateIngredientQuantity(id, quantity);
  //     return _getIngredientInventory();
  //   });
  // }
}
