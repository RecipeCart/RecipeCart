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

  Future<List<Ingredient?>> searchIngredients(String? searchEntry) async {
    return ingredientAPIService.searchIngredients(searchEntry: searchEntry);
  }

  Future<void> addIngredient(Ingredient newIngredient) async {
    return ingredientAPIService.addIngredient(newIngredient);
  }

  Future<void> updateIngredient(final id, final quantity) async {
    return ingredientAPIService.updateIngredientQuantity(id, quantity);
  }

  Future<void> removeIngredient(final id) async {
    return ingredientAPIService.removeIngredient(id);
  }
}
