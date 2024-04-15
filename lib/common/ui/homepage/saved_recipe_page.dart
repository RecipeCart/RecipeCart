// import 'package:amplify_api/amplify_api.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_cart/common/ui/homepage/widgets/recipe_element.dart';
import 'package:recipe_cart/features/settings/controller/settings_controller.dart';
import 'package:recipe_cart/models/Recipe.dart';
import 'package:recipe_cart/models/Settings.dart';

// import 'package:recipe_cart/features/recipe/ui/camera_module.dart';
// import 'package:recipe_cart/models/ModelProvider.dart';
// import 'package:recipe_cart/features/recipe/ui/inventory_card.dart';

class SavedRecipePage extends ConsumerStatefulWidget {
  const SavedRecipePage({super.key, required this.userSettings});
  final AsyncValue<Settings> userSettings;
  @override
  ConsumerState<SavedRecipePage> createState() => _SavedRecipeBuild();
}

class _SavedRecipeBuild extends ConsumerState<SavedRecipePage> {
  @override
  void initState() {
    super.initState();
  }
  
   late var recipeSearchProvider = FutureProvider<List<Recipe?>>((ref) async {
    final recipeResults = await ref
        .read(settingsControllerProvider.notifier).getSavedRecipes();
    return recipeResults;
  });

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();
    final recipes = ref.watch(recipeSearchProvider);
    // return ElevatedButton(
    //   // onPressed: () => Navigator.pushNamed('/camera'),
    //   child: const Text('Open Camera'),
    // );
    return Scaffold(
        appBar: AppBar(
          title: const Text('Saved Recipes'),
        ),
        body: Card(
          shape: const RoundedRectangleBorder(
            side: BorderSide(
              color: Colors.transparent,
              width: 0.3,
            )
          ),
          child: SingleChildScrollView(
            child: 
                recipes.when(
                    data: (data) {
                      print("status is $data");
                      return ListView.builder(
                        controller: scrollController,
                        shrinkWrap: true,
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return RecipeCard(
                              name: data[index]!.recipeName,
                              list: data[index]!.ingredients,
                              instructions: data[index]!.instructions,
                              rating: data[index]!.averageRatings,
                              ratingCount: data[index]!.numRatings,
                              id: data[index]!.id,
                              userSettings: widget.userSettings);
                        },
                        scrollDirection: Axis.vertical,
                      );
                    },
                    error: (e, s) {
                      print("Error! $e, $s, \n\n\n\n\n\n");
                      return Column(
                        children: [
                          const Icon(
                            Icons.error_outline,
                            color: Colors.red,
                            size: 60,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: Text('Error: ${e}, Stack ${s}'),
                          ),
                        ],
                      );
                    },
                    loading: () => const Column(
                          children: [
                            SizedBox(
                              width: 60,
                              height: 60,
                              child: CircularProgressIndicator(),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 16),
                              child: Text('Loading...'),
                            ),
                          ],
                        ))
            ),
          ),
        );
    // return const CameraScreen();
  }
}
