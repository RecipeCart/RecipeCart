import 'package:flutter/material.dart';
import 'package:recipe_cart/features/recipe/ui/homepage/widgets/search_bar.dart';

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
        child: const SingleChildScrollView(
          child: Column(
            children: [
              SearchBarWidget(),
            ],
          ),
        ),
      

      ),
    );
  }
}