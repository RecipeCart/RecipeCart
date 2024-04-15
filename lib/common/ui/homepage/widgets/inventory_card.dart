import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_cart/features/ingredient/controller/ingredient_controller.dart';
import 'package:recipe_cart/models/ModelProvider.dart';

class InventoryCard extends ConsumerStatefulWidget {
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
  bool _validated = false;

  @override
  void initState() {
    super.initState();
    name = widget.ingredient.ingredientName;
    weightController.text =
        "${widget.ingredient.quantity.toString()} ${widget.ingredient.unit}";
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
                  child: Text('Quantity: ${weightController.text}'),
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
    // parse newWeight to get quantity and unit
    final splitted = newWeight.split(' ');
    final double quantity = double.parse(splitted[0]);
    final String unit;
    if (splitted.length > 1) {
      unit = splitted[1];
    } else {
      unit = "g";
    }

    setState(() {
      _validated = quantity > 0 ? true : false;
    });

    if (!_validated) return;

    final updatedIngredient =
        widget.ingredient.copyWith(quantity: quantity, unit: unit);

    await ref
        .watch(ingredientListControllerProvider(searchEntry: "").notifier)
        .updateIngredient(
            id: updatedIngredient.id, quantity: updatedIngredient.quantity!);
  }

  void showModal(
      BuildContext context, String initialText, Function(String) onTextUpdate) {
    final TextEditingController textController =
        TextEditingController(text: initialText);

    showDialog<void>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Enter the ingredient quantity'), // Add a title
        content: TextField(
          controller: textController,
          decoration: InputDecoration(
              hintText: 'Enter value and unit here',
              errorText: _validated ? "Quantity value cannot be empty!" : null),
          autofocus: true, // Automatically focus on the field when opened
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              if (textController.text == "") {
                setState(() {
                  _validated = false;
                });
                return;
              }
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
