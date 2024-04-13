import 'package:recipe_cart/models/Ingredient.dart';
import 'package:recipe_cart/features/ingredient/service/ingredient_api_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final ingredientRepositoryProvider = Provider((ref) {
  final ingredientAPIService = ref.read(ingredientAPIServiceProvider);
  return ingredientAPIService;
});

class IngredientRepository {
  IngredientRepository(this.ingredientAPIService);

  final IngredientAPIService ingredientAPIService;

  // Future<List<Ingredient?>> getIngredientsInventory() async {
  //   return ingredientAPIService.getIngredientsInventory();
  // }

  Future<List<Ingredient?>> searchInventory(String? searchEntry) async {
    return ingredientAPIService.searchInventory(searchEntry: searchEntry);
  }

  Future<List<Ingredient?>> searchAllIngredients(String? searchEntry) async {
    return ingredientAPIService.searchAllIngredients(searchEntry: searchEntry);
  }

  Future<void> addIngredient(Ingredient newIngredient) async {
    return ingredientAPIService.addIngredient(newIngredient);
  }

  Future<void> updateIngredient(final String id, final double quantity) async {
    return ingredientAPIService.updateIngredientQuantity(id, quantity);
  }

  Future<void> removeIngredient(final String id) async {
    return ingredientAPIService.removeIngredient(id);
  }
}
