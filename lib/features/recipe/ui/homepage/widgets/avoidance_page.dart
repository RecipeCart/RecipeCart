import 'package:flutter/material.dart';
import 'package:recipe_cart/features/recipe/ui/homepage/search_recipe_page.dart';

class AvoidancePage extends StatefulWidget {
  const AvoidancePage({super.key});

  @override
    State<AvoidancePage> createState() => _AvoidancePageBuild();
  
}

class _AvoidancePageBuild extends State<AvoidancePage> {
  @override
  void initState(){
    super.initState();
  }

  Map<String, bool> values = {
    'vegan': false,
    'vegetarian': false,
    'carnivore': false,
    'pescatarian': false,
    'dairy-free': false,
    'keto': false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Preferencecheckbox')),
      body: Column(
            children: [
              SearchBar(),
              ingredientCard(context, 'watermetion'),
              ingredientCard(context, 'eggs'),
            ],
          ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {Navigator.pop(context);},
        child: const Icon(Icons.check),
      ),

    );
    
  }

  Widget ingredientCard(BuildContext context, String content)
  {
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
        child: Row(
          children: [
            Expanded(
            child: Text(content),
            ),
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: (){Navigator.pop(context);},
            ),
          ],
        ),
      ) 
      
    );
  }
  
}