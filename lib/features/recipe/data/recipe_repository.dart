import 'package:recipe_cart/features/recipe/service/recipe_api_service.dart';
import 'package:recipe_cart/models/Recipe.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final recipeRepositoryProvider = Provider<RecipeRepository>((ref) {
  final recipeAPIService = ref.read(recipeAPIServiceProvider);

  return RecipeRepository(recipeAPIService);
});

class RecipeRepository {
  RecipeRepository(this.recipeAPIService);

  final RecipeAPIService recipeAPIService;

  Future<List<Recipe?>> searchRecipes(final searchEntry, final allRelatedNames,
      final ingredientAvoidances, final dietType) {
    return recipeAPIService.searchRecipes(
        searchEntry, allRelatedNames, ingredientAvoidances, dietType);
  }

  Future<void> saveRecipe(final reverse, final recipeID, final settings) {
    return recipeAPIService.saveRecipe(reverse, recipeID, settings);
  }

  Future<Recipe> rateRecipe(final rating, final recipe, final settingsID) {
    return recipeAPIService.rateRecipe(rating, recipe, settingsID);
  }

  void resetOffset() {
    return recipeAPIService.resetOffset();
  }
}
