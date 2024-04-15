import 'dart:async';

import 'package:recipe_cart/features/recipe/data/recipe_repository.dart';
import 'package:recipe_cart/models/ModelProvider.dart';
import 'package:recipe_cart/models/Recipe.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'recipe_controller.g.dart';

@riverpod
class RecipeController extends _$RecipeController {
  Future<List<Recipe?>> searchRecipes(final searchEntry, final allRelatedNames,
      final ingredientAvoidances, final dietType) async {
    final recipeRepository = ref.read(recipeRepositoryProvider);
    final recipes = await recipeRepository.searchRecipes(
        searchEntry, allRelatedNames, ingredientAvoidances, dietType);
    return recipes;
  }

  @override
  FutureOr<List<Recipe?>> build() async {
    return [];
  }

  Future<void> unsaveRecipe(
      {required String recipeID, required Settings settings}) async {
    final recipeRepository = ref.read(recipeRepositoryProvider);
    return await recipeRepository.saveRecipe(true, recipeID, settings);
  }

  Future<void> saveRecipe(
      {required String recipeID, required Settings settings}) async {
    final recipeRepository = ref.read(recipeRepositoryProvider);
    return await recipeRepository.saveRecipe(false, recipeID, settings);
  }

  Future<Recipe> rateRecipe(
      {required int rating,
      required Recipe recipe,
      required String settingsID}) async {
    final recipeRepository = ref.read(recipeRepositoryProvider);
    return await recipeRepository.rateRecipe(rating, recipe, settingsID);
  }
}
