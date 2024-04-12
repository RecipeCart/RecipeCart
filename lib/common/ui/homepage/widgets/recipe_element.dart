import 'package:flutter/material.dart';

class RecipeCard extends StatefulWidget {
  final String name;
  var list;
  final String instructions;

  RecipeCard({
    super.key,
    required this.name,
    required this.list,
    required this.instructions,
  });
  @override 
  State <RecipeCard> createState() => _RecipeCardState(name: name, list: list, instructions: instructions);
}

class _RecipeCardState extends State<RecipeCard> {
  final String name;
  var list;
  final String instructions;
  String ingredients = '';

  _RecipeCardState ({
    required this.name,
    required this.list,
    required this.instructions,
  });  

  @override
  Widget build(BuildContext context) {
    // int ingreLen = ingredients.length;
    
    ingredients = list.join(',');
    return Card(
      shape: RoundedRectangleBorder(
        side: const BorderSide(
          color: Colors.white,
          width: 0.3,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      margin: const EdgeInsets.only(top: 10.0, right: 5.0, left: 5.0),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Row(
              children: [
                Text(name),
                const SizedBox(width: 20.0),
                IconButton(
                  icon: const Icon(Icons.bookmark),
                  onPressed: () => showCard(context, name, ingredients, instructions),
                ),
              ],
            ),
            Row(
              children: [
                Text('indgredients: $ingredients'),
              ],
            ),            
          ]
        ),
      ),
    );
  }
  void showCard(BuildContext context, String name, String ingredients, String instructions) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(name), // Add a title
        content: Card(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Divider(
                  thickness : 0.6,
                  indent: 32,
                  endIndent: 32,
                  color: Colors.white,
                ),

                const Padding(
                  padding: EdgeInsets.only(top: 5.0, left: 5, bottom: 5),
                  child: Text('Ingredients', style: TextStyle(fontSize: 25),),
                ),
                Text(
                  ': $ingredients'
                ),
              ],
            )
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}