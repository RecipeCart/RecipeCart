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

  // // return a list of ingredients in pages of 20
  // Future<List<Ingredient?>> getIngredientsInventory() async {
  //   try {
  //     final currentUser = await Amplify.Auth.getCurrentUser();
  //     final String cognitoID = currentUser.userId;

  //     final firstRequest = ModelQueries.list(Ingredient.classType,
  //         limit: pageLimit, where: Ingredient.USERID.contains(cognitoID));
  //     final firstResponse =
  //         await Amplify.API.query(request: firstRequest).response;
  //     final ingredientsPage1 = firstResponse.data;

  //     if (ingredientsPage1 == null) {
  //       safePrint('getIngredientsInventory errors: ${firstResponse.errors}');
  //       return const [];
  //     }

  //     if (ingredientsPage1.hasNextResult) {
  //       final secondRequest = ingredientsPage1.requestForNextResult;
  //       final secondResponse =
  //           await Amplify.API.query(request: secondRequest!).response;
  //       return secondResponse.data?.items ?? <Ingredient?>[];
  //     } else {
  //       return ingredientsPage1.items;
  //     }
  //   } on Exception catch (error) {
  //     safePrint('getIngredientsInventory failed: $error');
  //     return const [];
  //   }
  // }

  Future<List<Ingredient?>> searchIngredients(
      {String? searchEntry = ""}) async {
    // if no searchEntry, return all ingredient in user inventory
    final String? searchFilterEntry = searchEntry == ""
        ? searchEntry
        : "ingredientName: {contains: $searchEntry},";

    const operationName = "listIngredients";
    final graphQLDocument =
        '''query SearchIngredients(\$searchEntry: String!, \$cognitoID: String!) {
          $operationName(filter: {$searchFilterEntry userID: {contains: \$cognitoID}, removed: {equals: false}}, limit: $pageLimit) {
            items {
              id
              ingredientName
              quantity
              relatedNames
              unit
            }
          }
        }''';

    try {
      final currentUser = await Amplify.Auth.getCurrentUser();
      final String cognitoID = currentUser.userId;

      // SearchIngredients is a custom GraphQL request
      final searchIngredientsRequest =
          GraphQLRequest<PaginatedResult<Ingredient>>(
        document: graphQLDocument,
        modelType: const PaginatedModelType(Ingredient.classType),
        variables: <String, String>{'cognitoID': cognitoID},
        decodePath: operationName,
      );

      // get results paginated
      final firstResponse =
          await Amplify.API.query(request: searchIngredientsRequest).response;
      final ingredientsPage1 = firstResponse.data;
      if (ingredientsPage1 == null) {
        safePrint('getIngredientsInventory errors: ${firstResponse.errors}');
        return const [];
      }

      if (ingredientsPage1.hasNextResult) {
        final secondRequest = ingredientsPage1.requestForNextResult;
        final secondResponse =
            await Amplify.API.query(request: secondRequest!).response;
        return secondResponse.data?.items ?? <Ingredient?>[];
      } else {
        return ingredientsPage1.items;
      }
    } on Exception catch (error) {
      safePrint('getIngredientsInventory failed: $error');
      return const [];
    }
  }

  Future<void> addIngredient(Ingredient newIngredient) async {
    try {
      final request = ModelMutations.create(newIngredient);
      final response = await Amplify.API.mutate(request: request).response;
      final createdIngredient = response.data;
      if (createdIngredient == null) {
        safePrint('addIngredient errors: ${response.errors}');
        return;
      }
    } on Exception catch (e) {
      safePrint("addIngredient failed:$e");
    }
  }

  Future<void> updateIngredientQuantity(final id, final quantity) async {
    const operationName = "updateIngredient";
    const graphQLDocument =
        '''mutation UpdateIngredientQuantity(\$id: ID!, \$quantity: Float!) {
      $operationName(input: {id: \$id, quantity: \$quantity}) {
        id
        ingredientName
        quantity
        relatedNames
        unit
      }
    }''';
    try {
      // updateWeight is a custom GraphQL request
      final updateQuantityRequest = GraphQLRequest<Ingredient>(
        document: graphQLDocument,
        modelType: Ingredient.classType,
        variables: <String, String>{'id': id, 'quantity': quantity},
        decodePath: operationName,
      );

      final response = await Amplify.API
          .mutate(
            request: updateQuantityRequest,
          )
          .response;

      safePrint(response);
    } on Exception catch (error) {
      safePrint('updateIngredientQuantity failed: $error');
    }
  }

  Future<void> removeIngredient(final id) async {
    const operationName = "updateIngredient";
    const graphQLDocument = '''mutation RemoveIngredient(\$id: ID!) {
      $operationName(input: {id: \$id, removed: true}) {
        id
        ingredientName
        quantity
        relatedNames
        unit
      }
    }''';
    try {
      // removeIngredient is a custom GraphQL request
      final removeIngredientRequest = GraphQLRequest<Ingredient>(
        document: graphQLDocument,
        modelType: Ingredient.classType,
        variables: <String, String>{'id': id},
        decodePath: operationName,
      );

      final response = await Amplify.API
          .mutate(
            request: removeIngredientRequest,
          )
          .response;

      safePrint(response);
    } on Exception catch (error) {
      safePrint('removeIngredient failed: $error');
    }
  }
}
