import 'package:flutter/material.dart';
import 'package:recipe_cart/features/recipe/ui/homepage/widgets/search_bar.dart';
import 'package:recipe_cart/features/recipe/ui/homepage/widgets/recipe_element.dart';

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
              const SearchBarWidget(),
              const Divider(
                thickness : 0.6,
                indent: 32,
                endIndent: 32,
                color: Colors.white,
              ),
              const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 16.0, left: 20, bottom: 10),
                      child: Text('Discover', style: TextStyle(fontSize: 25),),
                    ),
                  ],
              ),
              RecipeCard(name: 'Big Man Chilling in Ice', list: ['watermelon','wintermelon','melonmelon','bananamelon'], instructions: 'haha'),
              RecipeCard(name: 'dfnkfnwk', list: ['qwe','rer','qwefd','asas'], instructions: 'haha'),
              RecipeCard(name: 'WLDKDVDS', list: ['qwe','rer','qwefd','asas'], instructions: 'haha'),
              RecipeCard(name: 'dlkkldkwlkd', list: ['qwe','rer','qwefd','asas'], instructions: 'haha'),
              RecipeCard(name: 'new maen :3', list: ['qwe','rer','qwefd','asas'], instructions: 'haha'),
            ],
          ),
        ),
      

      ),
    );
  }
}