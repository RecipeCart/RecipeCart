import 'dart:async';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:recipe_cart/models/ModelProvider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const pageLimit = 20;

final ingredientAPIServiceProvider = Provider<IngredientAPIService>((ref) {
  final service = IngredientAPIService();
  return service;
});

class IngredientAPIService {
  IngredientAPIService();

  // return a list of ingredients in pages of 20
  Future<List<Ingredient?>> getIngredientListPaginated() async {
    try {
      final firstRequest = ModelQueries.list(Ingredient.classType, limit: pageLimit);
      final firstResponse = await Amplify.API.query(request: firstRequest).response;
      final ingredientsPage1 = firstResponse.data;

      if (ingredientsPage1 == null) {
        safePrint('getIngredients errors: ${firstResponse.errors}');
        return const [];
      }
      
      if (ingredientsPage1?.hasNextResult ?? false) {
        final secondRequest = ingredientsPage1.requestForNextResult;
        final secondResponse = await Amplify.API.query(request: secondRequest!).response;
        return secondResponse.data?.items ?? <Ingredient?>[];
      } 
      else {
        return ingredientsPage1.items;
      }


    } on Exception catch (error) {
      safePrint('getIngredients failed: $error');
      return const [];
    }
  }

  Future<void> addIngredientToInventory({required String id, required String name}) async {
    try {
      final Ingredient newIngredient = Ingredient(
        id: id,
        ingredientName: name,
        
      );
      final request = ModelMutations.create()
    }
  }
}