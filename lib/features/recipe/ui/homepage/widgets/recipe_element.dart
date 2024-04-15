import 'package:flutter/material.dart';

class RecipeCard extends StatefulWidget {
  final String name;
  final list;
  final String instructions;

  RecipeCard({
    super.key,
    required this.name,
    required this.list,
    required this.instructions,
  });
  @override
  State<RecipeCard> createState() =>
      _RecipeCardState(name: name, list: list, instructions: instructions);
}

class _RecipeCardState extends State<RecipeCard> {
  final String name;
  var list;
  final String instructions;
  String ingredients = '';

  _RecipeCardState({
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
        child: Flexible(
          child: Container(
            padding: new EdgeInsets.only(
                top: 20, bottom: 10, left: 10.0, right: 13.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(name),
                    ),
                    const Icon(
                      Icons.save,
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
      ),
    );
  }

  void showCard(BuildContext context, String name, String ingredients,
      String instructions) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        var screenSize = MediaQuery.of(context).size;
        return Dialog(
          child: Container(
            width: screenSize.width * 0.9,
            height: screenSize.height * 0.7,
            // Container properties and child widgets
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                      top: 40, start: 10, end: 10),
                  child: Text(
                    name,
                    style: TextStyle(fontSize: 30),
                    textAlign: TextAlign.center,
                  ),
                ),
                const Divider(
                  indent: 20,
                  endIndent: 20,
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                      top: 7, start: 10, end: 10),
                  child: Text(
                    ingredients,
                    style: TextStyle(fontSize: 15),
                    textAlign: TextAlign.center,
                  ),
                ),
                const Divider(
                  indent: 20,
                  endIndent: 20,
                ),
                Text(instructions),
                const Divider(
                  indent: 20,
                  endIndent: 20,
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
