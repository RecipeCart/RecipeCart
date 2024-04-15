import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:recipe_cart/common/ui/homepage/widgets/search_bar.dart';
import 'package:recipe_cart/common/ui/homepage/widgets/recipe_element.dart';
import 'package:recipe_cart/features/recipe/service/recipe_api_service.dart';
import 'package:recipe_cart/features/settings/data/settings_api_data.dart';
import 'package:recipe_cart/features/settings/service/settings_api_service.dart';
import 'package:recipe_cart/models/ModelProvider.dart';
import 'package:recipe_cart/models/Recipe.dart';


class SearchRecipePage extends StatefulWidget {
  const SearchRecipePage({super.key});

  @override
    State<SearchRecipePage> createState() => _SearchRecipeBuild();
  
}

class _SearchRecipeBuild extends State<SearchRecipePage>{
  @override
  void initState(){
    super.initState();
  }
  RecipeAPIService recipeAPIService = RecipeAPIService();
  SettingsAPIService settingsAPIService = SettingsAPIService();
  String searchValue = "";
  

  @override
  Widget build (BuildContext context) {
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
                  onSubmitted: (value) {searchValue = value; print(searchValue);},
                  cursorColor: Colors.grey,
                  style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none
                    ),
                    hintText: 'Search',
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                      fontSize: 20
                    ),
                    prefixIcon: const Icon(Icons.search, color: Colors.black,),
                  ),
                ),
              const Divider(
                thickness : 0.6,
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
              listRecipe("pad thai", [[""]].cast<List<String>>(), ["peanuts"].cast<Ingredient>(), "all"),
              // RecipeCard(name: 'Big Man Chilling in Ice', list: ['watermelon','wintermelon','melonmelon','bananamelon'], instructions: 'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?'),
              // RecipeCard(name: 'dfnkfnwk', list: ['qwe','rer','qwefd','asas'], instructions: 'haha'),
              // RecipeCard(name: 'WLDKDVDS', list: ['qwe','rer','qwefd','asas'], instructions: 'haha'),
              // RecipeCard(name: 'dlkkldkwlkd', list: ['qwe','rer','qwefd','asas'], instructions: 'haha'),
              // RecipeCard(name: 'new maen :3', list: ['qwe','rer','qwefd','asas'], instructions: 'haha'),
            ],
          ),
        ),
      

      ),
    );
  }
  Widget listRecipe(searchEntry, allRelatedNames, ingredientAvoidances, dietType){
    ScrollController scrollController = ScrollController();
    print("passed init typecheck");
    return FutureBuilder(
      future: recipeAPIService.searchRecipes(searchEntry, allRelatedNames, ingredientAvoidances, dietType),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        List<Widget> children;
        if (snapshot.hasData){
          final List<Recipe> recipes = snapshot.data!.cast<Recipe>();
          children = <Widget>[
            ListView.builder(
                padding: const EdgeInsetsDirectional.all(8),
                controller: scrollController,
                shrinkWrap: true,
                itemCount: recipes.length,
                itemBuilder: (context, index) {
                  return RecipeCard(
                      name: recipes[index].recipeName,
                      list: recipes[index].ingredients,
                      instructions: recipes[index].instructions
                    );
                  },
                  scrollDirection: Axis.vertical,
                ),
          ];
          print(recipes.length);

        } else if (snapshot.hasError) {
            children = <Widget>[
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Error: ${snapshot.error}'),
              ),
            ];
          } else {
            children = const <Widget>[
              SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text('Searching...'),
              ),
            ];
          }
        return Center(
        //   child: SingleChildScrollView(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            //mainAxisSize: MainAxisSize.min,
            children: children,
            ),
          // )
        );
      }
      );
  }
}

  