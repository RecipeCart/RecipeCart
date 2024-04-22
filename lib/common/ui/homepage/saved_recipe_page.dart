import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_cart/common/ui/homepage/widgets/recipe_element.dart';
import 'package:recipe_cart/features/recipe/controller/recipe_controller.dart';
import 'package:recipe_cart/features/settings/controller/settings_controller.dart';
import 'package:recipe_cart/models/Recipe.dart';

class SavedRecipePage extends ConsumerStatefulWidget {
  const SavedRecipePage({super.key});
  @override
  ConsumerState<SavedRecipePage> createState() => _SavedRecipeBuild();
}

class _SavedRecipeBuild extends ConsumerState<SavedRecipePage> {
  List<Recipe> savedRecipes = [];

  @override
  void initState() {
    super.initState();
    ref.read(settingsControllerProvider);
    savedRecipes =
        ref.read(settingsControllerProvider.notifier).getSavedRecipes();
  }

  @override
  Widget build(BuildContext context) {
    final userSettings = ref.watch(settingsControllerProvider);
    savedRecipes =
        ref.read(settingsControllerProvider.notifier).getSavedRecipes();

    print(savedRecipes.length);

    ScrollController scrollController = ScrollController();

    // return ElevatedButton(
    //   // onPressed: () => Navigator.pushNamed('/camera'),
    //   child: const Text('Open Camera'),
    // );
    return Scaffold(
        appBar: AppBar(
          title: const Text('Saved Recipes'),
        ),
        body: RefreshIndicator(
            onRefresh: () async {
              savedRecipes = ref
                  .watch(settingsControllerProvider.notifier)
                  .getSavedRecipes();
              setState(() {});
              print(savedRecipes.length);
            },
            child: Card(
                shape: const RoundedRectangleBorder(
                    side: BorderSide(
                  color: Colors.transparent,
                  width: 0.3,
                )),
                child: SingleChildScrollView(
                  child: userSettings.when(
                    data: (settings) {
                      safePrint("status is $settings");
                      setState(() {
                        savedRecipes = ref
                            .read(settingsControllerProvider.notifier)
                            .getSavedRecipes();
                      });

                      return ListView.builder(
                        controller: scrollController,
                        shrinkWrap: true,
                        itemCount: savedRecipes.length,
                        itemBuilder: (context, index) {
                          return RecipeCard(
                              name: savedRecipes[index].recipeName,
                              list: savedRecipes[index].ingredients,
                              instructions: savedRecipes[index].instructions,
                              rating: savedRecipes[index].averageRatings,
                              ratingCount: savedRecipes[index].numRatings,
                              id: savedRecipes[index].id,
                              userSettings: userSettings);
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
                            child: Text('Error: $e, Stack $s'),
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
                    ),
                  ),
                ))));
  }
}
