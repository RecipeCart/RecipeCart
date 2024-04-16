import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_cart/features/recipe/controller/recipe_controller.dart';
import 'package:recipe_cart/features/settings/controller/settings_controller.dart';
import 'package:recipe_cart/models/Recipe.dart';
import 'package:recipe_cart/models/Settings.dart';

class RecipeCard extends ConsumerStatefulWidget {
  final String name;
  var list;
  final String instructions;
  double rating;
  int ratingCount;
  final String id;
  final AsyncValue<Settings> userSettings;

  RecipeCard({
    super.key,
    required this.name,
    required this.list,
    required this.instructions,
    required this.rating,
    required this.ratingCount,
    required this.id,
    required this.userSettings
  });
  @override 
  ConsumerState <RecipeCard> createState() => _RecipeCardState();
}

class _RecipeCardState extends ConsumerState<RecipeCard> {
  String ingredients = '';
  bool isSaved = false;

  @override
  initState() {
    super.initState();
    ref.read(recipeControllerProvider);
    savedRecipes = ref.read(settingsControllerProvider.notifier).getSavedRecipes().map((e) => e.id).toSet();
    if (savedRecipes.contains(widget.id)){
      isSaved = true;
    }
  }
  Set<String> savedRecipes = {};

  late var savedRecipeProvider = FutureProvider((ref) async {
    final savedRecipe = await ref.read(settingsControllerProvider.notifier).getSavedRecipes();
    return savedRecipe;
  });

  @override
  Widget build(BuildContext context) {
    // int ingreLen = ingredients.length;
    final savedRecipesSetting = ref.watch(savedRecipeProvider);

    savedRecipesSetting.when(data: (data) {
      setState(() {
        savedRecipes = data.map((e) => e.id).toSet();
          if (savedRecipes.contains(widget.id)){
      isSaved = true;
    }
      });
      
      }, error: (e, s) {print("$e and $s");}, loading: () => {});
    
    ingredients = widget.list.join(',\n');
    return GestureDetector(
      onTap: () => showCard(context, widget.name, ingredients, widget.instructions),
      child: Card(
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: Colors.white,
            width: 0.3,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        margin: const EdgeInsets.only(top: 10.0, right: 5.0, left: 5.0),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(widget.name),
                  ),
                  IconButton(icon: const Icon(
                    Icons.bookmark_add_outlined,
                    color: Colors.white), selectedIcon: const Icon(Icons.bookmark_add, color: Colors.purple), isSelected: isSaved, onPressed: () async { 
                      widget.userSettings.whenOrNull(data: (data) {setState(() {
                        if(!isSaved) {ref.read(recipeControllerProvider.notifier).saveRecipe(recipeID: widget.id, settings: data);}
                        else {ref.read(recipeControllerProvider.notifier).unsaveRecipe(recipeID: widget.id, settings: data);}
                        savedRecipeProvider = FutureProvider((ref) async {
    final savedRecipe = await ref.read(settingsControllerProvider.notifier).getSavedRecipes();
    return savedRecipe;
  });
                      });
                        
                        });

                      isSaved = !isSaved; //
                      //insert command to save/unsave
                      }
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Ingredients: $ingredients',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

      ),
    );
  }
  void showCard(BuildContext context, String name, String ingredients, String instructions) {
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        var screenSize = MediaQuery.of(context).size;
        return Dialog(
          child: SizedBox(
            width: screenSize.width, 
            height: screenSize.height * 0.9, 
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(13),
              child: Column(
                children: <Widget> [
                  Padding(
                    padding: const EdgeInsetsDirectional.only(top: 40, start: 10, end: 10),
                    child: Text(
                      name,
                      style: const TextStyle(fontSize: 30),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  RatingBar.builder(
                    initialRating: widget.rating,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    ignoreGestures: true,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  ),
                  const Divider(
                    indent: 20,
                    endIndent: 20,
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(top: 7, start: 10, end: 10),
                    child: Text(
                      'Ingredients: $ingredients',
                      style: const TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const Divider(
                    indent: 20,
                    endIndent: 20,
                  ),
                  Text(
                    instructions
                  ),
                  const Divider(
                    indent: 20,
                    endIndent: 20,
                  ),
                  const Text('Your Ratings'),
                  RatingBar.builder(
                    initialRating: 3,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    ignoreGestures: false,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {Navigator.pop(context);},
                  ),
                ],
                
              ),
            ),

          ),
        );
      },
    );
  }
}