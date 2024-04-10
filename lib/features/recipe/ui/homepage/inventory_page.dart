import 'package:amplify_api/amplify_api.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe_cart/features/recipe/ui/api.dart';
import 'package:recipe_cart/models/ModelProvider.dart';
import 'package:recipe_cart/features/recipe/ui/homepage/widgets/inventory_card.dart';

class InventoryPage extends StatefulWidget {
  const InventoryPage({super.key});
  
  @override
    State<InventoryPage> createState() => _InventoryBuild();


}


class _InventoryBuild extends State<InventoryPage> {
  String weight = "0"; // Initial weight
  final TextEditingController weightController = TextEditingController();
  // const api = new api();
  // final Ingredient test = queryItem('raisins') as Ingredient; 
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventory Page'),
      ),
      body: Card(
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: Colors.transparent,
            width: 0.3,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        margin: const EdgeInsets.only(top: 10.0),
        child: SingleChildScrollView(
          child: Column( // Use Row for horizontal layout
            children: [
              InventoryCard(
                name: 'Watermelon', // Set the name
                weight: weight, // Provide initial weight
                weightController: weightController, // Share the controller
              ),
            InventoryCard(
                name: 'a', // Set the name
                weight: weight, // Provide initial weight
                weightController: weightController, // Share the controller
              ),
            InventoryCard(
                name: 'dakhsdsasskldmsa', // Set the name
                weight: weight, // Provide initial weight
                weightController: weightController, // Share the controller
              ),
            ],
          ),
        ),

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/camera'),
        child: const Icon(Icons.camera_alt_outlined),
      ),
    );
  }
}
