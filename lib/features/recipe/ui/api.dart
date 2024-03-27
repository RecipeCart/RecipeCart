// import 'package:recipe_cart/models/ModelProvider.dart';
// import 'package:amplify_api/amplify_api.dart';
// import 'package:amplify_flutter/amplify_flutter.dart';

// // ignore: camel_case_types
// class api {
//   api();

//   Future<Ingredient?> queryItem(String qIngredient) async {
//     try {
//       final request = ModelQueries.get(
//         Ingredient.classType,
//         qIngredient.modelIdentifier,
//       );

//       final response = await Amplify.API.query(request: request).response;

//       final todo = response.data;

//       if (todo == null) {

//         safePrint('errors: ${response.errors}');

//       }

//       return todo;

//     } on ApiException catch (e) {

//       safePrint('Query failed: $e');

//       return null;

//     }

//   }
// }