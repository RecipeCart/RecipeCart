import 'package:amplify_api/amplify_api.dart';
import 'package:flutter/material.dart';
import 'package:recipe_cart/features/recipe/ui/api.dart';
import 'package:recipe_cart/models/ModelProvider.dart';
import 'package:recipe_cart/features/recipe/ui/inventory_card.dart';

class GenerateRecipePage extends StatefulWidget {
  const GenerateRecipePage({super.key});
  
  @override
    State<GenerateRecipePage> createState() => _GenerateRecipeBuild();


}

class _GenerateRecipeBuild extends State<GenerateRecipePage>{
  @override
  void initState() {
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Generate Recipe'),
      ),
      body: Center(
        child: ElevatedButton.icon(
          onPressed: onPressed,
          icon: const Icon(Icons.lightbulb_outline),
          label: const Text('Generate Recipe'),
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(200, 100), // Set button dimensions
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0), // Rounded corners
            ),
            backgroundColor: const Color.fromARGB(255, 234, 7, 255),
            foregroundColor: const Color.fromARGB(255, 78, 19, 83),
          ),
        ),
      ),
    );
  }


  void onPressed() {
  }
}