import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_cart/models/ModelProvider.dart';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:recipe_cart/features/ingredient/service/ingredient_api_service.dart';

void main() async {
  IngredientAPIService ingredientAPIService = IngredientAPIService();
  // test("Testing searchInventory", () async {
  //   await Amplify.configure(amplifyconfig);
  //   const searchEntry = "rai";

  //   final ingredients =
  //       await ingredientAPIService.searchInventory(searchEntry: searchEntry);

  //   print(ingredients.toString());
  // });

  test('test search inventory', () async {
    const searchEntry = "tu";

    final ingredients =
        await ingredientAPIService.searchInventory(searchEntry: searchEntry);

    safePrint(ingredients.toString());
  });

  test('test search ingredients', () async {
    const searchEntry = "tu";

    final ingredients = await ingredientAPIService.searchAllIngredients(
        searchEntry: searchEntry);

    safePrint(ingredients.toString());
  });

  test('test add ingredient', () async {
    final ing = Ingredient(
        ingredientName: "strawberries",
        relatedNames: ["strawberry", "berry", "raspberry", "strawberry jam"],
        barcode: "665290001429",
        quantity: 2,
        unit: "lb",
        standardQuantity: 907,
        removed: false);
    IngredientAPIService ingredientAPIService = IngredientAPIService();
    await ingredientAPIService.addIngredient(ing);
  });

  test('remove ingredient', () async {
    const ing = "a9658e47-cc77-47cf-9433-9ceca527bb34";
    IngredientAPIService ingredientAPIService = IngredientAPIService();
    await ingredientAPIService.removeIngredient(ing);
  });

  test('update ingredient quantity', () async {
    IngredientAPIService ingredientAPIService = IngredientAPIService();
    const id = "305bc7e8-7c34-4532-b87a-16bc90c31ceb";
    final qu = Random(2).nextDouble();

    await ingredientAPIService.updateIngredientQuantity(id, qu);
  });
}
