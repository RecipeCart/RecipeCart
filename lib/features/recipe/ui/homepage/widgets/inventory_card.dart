import 'package:flutter/material.dart';
import 'package:recipe_cart/features/recipe/ui/homepage/inventory_page.dart';

class InventoryCard extends StatefulWidget {
  final String name; // Name of the inventory item
  String weight; // Initial weight of the item
  final TextEditingController weightController; // Controller for weight editing
  // final Function(String) onWeightChange; // Callback for weight updates
  // ... other properties
  InventoryCard({
    super.key,
    required this.name,
    required this.weight,
    required this.weightController,
    // required this.onWeightChange,  
  });
  @override
  State<InventoryCard> createState() => _InventoryCardState(name: name, weight: weight, weightController: weightController);
}
class _InventoryCardState extends State<InventoryCard> {
  final String name; // Name of the inventory item
  String weight; // Initial weight of the item
  final TextEditingController weightController; // Controller for weight editing

  _InventoryCardState({
    required this.name,
    required this.weight,
    required this.weightController,
  });

  @override
  Widget build(BuildContext context) {
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
        child: Column( // Use Column for vertical stacking
          children: [
            Row( // Use Row for horizontal name & weight
              children: [
                Expanded( // Ensure name takes most space
                  child: Text(name),
                ),
                const SizedBox(width: 10.0), // Spacing between name & weight
                Flexible( // Wrap weight text to prevent overflow
                  child: Text('Weight: $weight'),
                ), // Consider removing padding here
              ],
            ),
            // ... other child widgets, e.g., TextField
            Row( // Separate Row for edit icon at the end
              mainAxisAlignment: MainAxisAlignment.end, // Align right
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => showModal(context, weight, updateWeight),
                ),
              ],
            ),
          ],
        ),
      ),

    );
  }
  void updateWeight(String newWeight) {
    setState(() {
      weight = newWeight;
    });
  }
  void showModal(BuildContext context, String initialText, Function(String) onTextUpdate) {
    final TextEditingController textController = TextEditingController(text: initialText);

    showDialog<void>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Enter Value'), // Add a title
        content: TextField(
          controller: textController,
          decoration: const InputDecoration(hintText: 'Enter value to update'),
          autofocus: true, // Automatically focus on the field when opened
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              onTextUpdate(textController.text); // Update text value
              Navigator.pop(context); // Close dialog
            },
            child: const Text('OK'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context), // Close dialog on Cancel
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

}