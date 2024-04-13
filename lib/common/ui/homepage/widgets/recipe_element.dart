import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

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
    return GestureDetector(
      onTap: () => showCard(context, name, ingredients, instructions),
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
                    child: Text(name),
                  ),
                  const Icon(
                    Icons.bookmark_add,
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
                    initialRating: 3,
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