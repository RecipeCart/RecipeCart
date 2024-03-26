import 'package:flutter/material.dart';
import 'package:recipe_cart/features/recipe/ui/inventory_card.dart';

class InventoryPage extends StatefulWidget {
  const InventoryPage({super.key});


  
  @override
    State<InventoryPage> createState() => _InventoryBuild();
}


class _InventoryBuild extends State<InventoryPage> {
  String weight = "0"; // Initial weight
  final TextEditingController weightController = TextEditingController();

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
          name: 'Watermelon', // Set the name
          weight: weight, // Provide initial weight
          weightController: weightController, // Share the controller
        ),
      InventoryCard(
          name: 'Watermelon', // Set the name
          weight: weight, // Provide initial weight
          weightController: weightController, // Share the controller
        ),
      InventoryCard(
          name: 'Watermelon', // Set the name
          weight: weight, // Provide initial weight
          weightController: weightController, // Share the controller
        ),
      InventoryCard(
          name: 'Watermelon', // Set the name
          weight: weight, // Provide initial weight
          weightController: weightController, // Share the controller
        ),
      InventoryCard(
          name: 'Watermelon', // Set the name
          weight: weight, // Provide initial weight
          weightController: weightController, // Share the controller
        ),
      InventoryCard(
          name: 'Watermelon', // Set the name
          weight: weight, // Provide initial weight
          weightController: weightController, // Share the controller
        ),
      InventoryCard(
          name: 'Watermelon', // Set the name
          weight: weight, // Provide initial weight
          weightController: weightController, // Share the controller
        ),
      InventoryCard(
          name: 'Watermelon', // Set the name
          weight: weight, // Provide initial weight
          weightController: weightController, // Share the controller
        ),
      InventoryCard(
          name: 'Watermelon', // Set the name
          weight: weight, // Provide initial weight
          weightController: weightController, // Share the controller
        ),
      InventoryCard(
          name: 'Watermelon', // Set the name
          weight: '34343', // Provide initial weight
          weightController: weightController, // Share the controller
        ),
      ],
    ),
  ),

),
    );
  }
}

          // Add more InventoryCard widgets for other items
        //       Expanded( // Ensures title takes most space
        //         child: ListTile(
        //           title: const Text('Watermelon'),
        //           subtitle: Row( // Row for weight and edit icon
        //             children: [
        //               Text('Weight: $weight'),
        //               // Editable text field for weight
        //               Expanded(
        //                 child: TextField(
        //                     controller: weightController, // Use controller
        //                     keyboardType: TextInputType.number,
        //                     decoration: const InputDecoration(
        //                     border: InputBorder.none,// Remove default border
        //                   ),
        //                 ),
        //               ),
        //             ],
        //           ),
        //         ),
        //       ),
        //       // Icon trailing the content
        //       IconButton(
        //         icon: const Icon(Icons.edit), // Use Icons.edit for writing icon
        //         onPressed: () {
        //           weight = weightController.text;
        //         },
        //       ),