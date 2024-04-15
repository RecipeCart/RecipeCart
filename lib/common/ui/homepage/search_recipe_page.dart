import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_cart/common/ui/homepage/widgets/recipe_element.dart';
import 'package:recipe_cart/features/ingredient/controller/ingredient_controller.dart';
import 'package:recipe_cart/features/recipe/controller/recipe_controller.dart';
import 'package:recipe_cart/features/settings/controller/settings_controller.dart';
import 'package:recipe_cart/features/settings/data/settings_api_data.dart';
import 'package:recipe_cart/models/ModelProvider.dart';
import 'package:recipe_cart/models/Recipe.dart';

class SearchRecipePage extends ConsumerStatefulWidget {
  const SearchRecipePage(
      {super.key, required this.userSettings, required this.inventory});
  final AsyncValue<Settings> userSettings;
  final AsyncValue<List<Ingredient?>> inventory;
  @override
  SearchRecipeState createState() => SearchRecipeState();
}

class SearchRecipeState extends ConsumerState<SearchRecipePage> {
  @override
  void initState() {
    super.initState();
    avoidances = ref.read(settingsControllerProvider.notifier).getAvoidances();
    switch (widget.inventory) {
      case AsyncData(:final value):
        ingredientList = value.isEmpty ? [] : value;
    }
    switch (widget.userSettings) {
      case AsyncData(:final value):
        dietType = DietType.values[value.dietType!].name;
    }
    ref.read(recipeControllerProvider);
  }

  // RecipeAPIService recipeAPIService = RecipeAPIService();

  // List<Recipe> recipeResults = [];
  String searchValue = "";
  List<Ingredient> avoidances = [];
  List<Ingredient?> ingredientList = [];
  String dietType = '';

  late var recipeSearchProvider = FutureProvider<List<Recipe?>>((ref) async {
    final recipeResults = await ref
        .read(recipeControllerProvider.notifier)
        .searchRecipes(
            searchValue,
            ingredientList.map((e) => e!.relatedNames).toList(),
            avoidances,
            dietType);
    return recipeResults;
  });

  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    print(ingredientList.toString());
    ref.listen(settingsControllerProvider, (prev, next) async {
      avoidances =
          ref.read(settingsControllerProvider.notifier).getAvoidances();
      print("reloaded avoidances: $avoidances\n\n\n");
      switch (widget.userSettings) {
        case AsyncData(:final value):
          dietType = DietType.values[value.dietType!].name;
      }
      print("reloaded diet type: $dietType");
    });
    ref.listen(ingredientListControllerProvider, (prev, next) async {
      switch (widget.inventory) {
        case AsyncData(:final value):
          ingredientList = value.isEmpty ? [] : value;
      }
      print("reloaded inventory: $ingredientList");
    });

    // watch changes in recipe search results
    final recipeResults = ref.watch(recipeSearchProvider);
    print("KANCHO!\n\n\n\n");
    return Scaffold(
        appBar: AppBar(
          title: const Text('Explore Recipes'),
        ),
        body: Card(
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              color: Colors.transparent,
              width: 0.3,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  onSubmitted: (value) async {
                    setState(() {
                      searchValue = value;
                      print(searchValue);
                      recipeSearchProvider =
                          FutureProvider<List<Recipe?>>((ref) async {
                        ref
                            .read(recipeControllerProvider.notifier)
                            .resetOffset();
                        final recipeResults = await ref
                            .read(recipeControllerProvider.notifier)
                            .searchRecipes(
                                searchValue,
                                ingredientList
                                    .map((e) => e!.relatedNames)
                                    .toList(),
                                avoidances,
                                dietType);
                        return recipeResults;
                      });
                    });
                  },
                  cursorColor: Colors.grey,
                  style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none),
                    hintText: 'Search',
                    hintStyle:
                        const TextStyle(color: Colors.grey, fontSize: 20),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                  ),
                ),
                const Divider(
                  thickness: 0.6,
                  indent: 32,
                  endIndent: 32,
                  color: Colors.white,
                ),
                // const Row(
                //     children: [
                //       Padding(
                //         padding: EdgeInsets.only(top: 16.0, left: 20, bottom: 10),
                //         child: Text('Discover', style: TextStyle(fontSize: 25),),
                //       ),
                //     ],
                // ),
                // get list of recipes for listview builder
                recipeResults.when(
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
                              userSettings: widget.userSettings,);
                             
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
                              child: Text('Searching...'),
                            ),
                          ],
                        ))
              ],
            ),
          ),
        ));
  }

}
