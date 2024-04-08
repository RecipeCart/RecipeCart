import 'package:recipe_cart/features/recipe/service/recipe_api_service.dart';
import 'package:recipe_cart/models/Recipe.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final recipeRepositoryProvider = Provider<RecipeRepository> ((ref) {
  final recipeAPIService = ref.read(recipeAPIServiceProvider);

  return RecipeRepository(recipeAPIService);
});

class RecipeRepository {
  RecipeRepository(this.recipeAPIService);

  final RecipeAPIService recipeAPIService;

  Future<List<Recipe?>> getRecipeList() {
    return recipeAPIService.getRecipeListPaginated();
  }
}