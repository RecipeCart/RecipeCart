import 'package:flutter/material.dart';
import 'package:recipe_cart/common/ui/homepage/widgets/search_bar.dart';
import 'package:recipe_cart/common/ui/homepage/widgets/recipe_element.dart';

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
              RecipeCard(name: 'Big Man Chilling in Ice', list: ['watermelon','wintermelon','melonmelon','bananamelon'], instructions: 'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?'),
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