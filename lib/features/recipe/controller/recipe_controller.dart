import 'dart:async';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:recipe_cart/features/recipe/data/recipe_repository.dart';
import 'package:recipe_cart/models/ModelProvider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'recipe_controller.g.dart';

@riverpod
class RecipeController extends _$RecipeController {
  Future<List<Recipe?>> _fetchRecipes() async {
    final recipeRepository = ref.read(recipeRepositoryProvider);
    final recipes = await recipeRepository.getRecipeList();
    return recipes;
  }

  @override
  FutureOr<List<Recipe?>> build() async {
    return _fetchRecipes();
  }

  
}

