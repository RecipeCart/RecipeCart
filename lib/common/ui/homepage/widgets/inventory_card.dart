import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_cart/common/ui/homepage/inventory_page.dart';
import 'package:recipe_cart/features/ingredient/controller/ingredient_controller.dart';
import 'package:recipe_cart/models/ModelProvider.dart';

class InventoryCard extends ConsumerStatefulWidget {
  // final TextEditingController weightController; // Controller for weight editing
  // final Function(String) onWeightChange; // Callback for weight updates
  // ... other properties
  const InventoryCard({
    super.key,
    required this.ingredient,
    // required this.weightController,
    // required this.onWeightChange,
  });
  @override
  InventoryCardState createState() => InventoryCardState();

  final Ingredient ingredient;
}

class InventoryCardState extends ConsumerState<InventoryCard> {
  final TextEditingController weightController =
      TextEditingController(); // Controller for weight editing
  String name = "";

  @override
  void initState() {
    super.initState();
    name = widget.ingredient.ingredientName;
    weightController.text = widget.ingredient.quantity.toString();
  }

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
        child: Column(
          // Use Column for vertical stacking
          children: [
            Row(
              // Use Row for horizontal name & weight
              children: [
                Expanded(
                  // Ensure name takes most space
                  child: Text(name),
                ),
                const SizedBox(width: 10.0), // Spacing between name & weight
                Flexible(
                  // Wrap weight text to prevent overflow
                  child: Text('Weight: ${weightController.text}'),
                ), // Consider removing padding here
              ],
            ),
            // ... other child widgets, e.g., TextField
            Row(
              // Separate Row for edit icon at the end
              mainAxisAlignment: MainAxisAlignment.end, // Align right
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () async {
                    showModal(context, weightController.text, updateWeight);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> updateWeight(String newWeight) async {
    // parse newWeight to get unit

    final updatedIngredient =
        widget.ingredient.copyWith(quantity: double.parse(newWeight));

    await ref.watch(ingredientListControllerProvider.notifier).updateIngredient(
        id: updatedIngredient.id, quantity: updatedIngredient.quantity!);
  }

  void showModal(
      BuildContext context, String initialText, Function(String) onTextUpdate) {
    final TextEditingController textController =
        TextEditingController(text: initialText);

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
