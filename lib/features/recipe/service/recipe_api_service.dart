import 'dart:async';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:recipe_cart/models/ModelProvider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


const pageLimit = 20;

final recipeAPIServiceProvider = Provider<RecipeAPIService>((ref) {
  final service = RecipeAPIService();
  return service;
});

class RecipeAPIService {
  RecipeAPIService();

  Future<List<Recipe?>> getRecipeListPaginated() async {
    try {
      final firstRequest = ModelQueries.list(Recipe.classType, limit: pageLimit);
      final firstResponse = await Amplify.API.query(request: firstRequest).response;
      final recipePage1 = firstResponse.data;

      if (recipePage1 == null) {
        safePrint('getIngredients errors: ${firstResponse.errors}');
        return const [];
      }
      
      if (recipePage1?.hasNextResult ?? false) {
        final secondRequest = recipePage1.requestForNextResult;
        final secondResponse = await Amplify.API.query(request: secondRequest!).response;
        
        return secondResponse.data?.items ?? <Recipe?>[];
      } 
      else {
        return recipePage1.items;
      }


    } on Exception catch (error) {
      safePrint('getRecipeList failed: $error');
      return const [];
    }
  }
}