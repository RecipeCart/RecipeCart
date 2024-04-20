import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_cart/features/ingredient/controller/ingredient_controller.dart';
import 'package:recipe_cart/features/settings/controller/settings_controller.dart';
import 'package:recipe_cart/models/ModelProvider.dart';

class AvoidancePage extends ConsumerStatefulWidget {
  const AvoidancePage({super.key});

  @override
  ConsumerState<AvoidancePage> createState() => _AvoidancePageState();
}

class _AvoidancePageState extends ConsumerState<AvoidancePage> {
  List<Ingredient> displayedIngredients = [];
  List<Ingredient> listAvoidances = [];
  late Future<List<Ingredient?>> allIngredients;

  @override
  void initState() {
    super.initState();

    listAvoidances =
        ref.read(settingsControllerProvider.notifier).getAvoidances();
    displayedIngredients = List.from(listAvoidances);

    allIngredients = ref
        .read(ingredientListControllerProvider.notifier)
        .searchAllIngredients(searchEntry: "");
  }

  @override
  Widget build(BuildContext context) {
    // List<Ingredient> listAvoidances =
    //     ref.read(settingsControllerProvider.notifier).getAvoidances();

    final currentSettings = ref.watch(settingsControllerProvider);
    // listAvoidances =
    //     ref.watch(settingsControllerProvider.notifier).getAvoidances();
    // displayedIngredients = List.from(listAvoidances);

    switch (currentSettings) {
      case AsyncValue(:final value):
        return Scaffold(
          appBar: AppBar(
            title: const Text('Avoidances List'),
          ),
          body: SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: Column(
              children: <Widget>[
                displayedIngredients.isNotEmpty
                    ? ListView.builder(
                        itemCount: displayedIngredients.length,
                        itemBuilder: (context, index) {
                          final ingredient = displayedIngredients[index];
                          return Dismissible(
                            key: ValueKey(ingredient.ingredientName),
                            background: _buildDismissBackground(context),
                            onDismissed: (direction) {
                              setState(() {
                                listAvoidances.removeAt(index);
                                displayedIngredients.removeAt(index);
                              });
                            },
                            direction: DismissDirection.endToStart,
                            child: ingredientCard(
                                context, ingredient.ingredientName),
                          );
                        },
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                      )
                    : const Text("haha no sick"),
              ],
            ),
          ),
          floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FloatingActionButton(
                heroTag: "addButton",
                onPressed: () async {
                  showModal(context, addAvoidance);
                  setState(() {});
                },
                child: const Icon(Icons.add),
              ),
              FloatingActionButton(
                heroTag: "submitButton",
                onPressed: () async {
                  await ref
                      .read(settingsControllerProvider.notifier)
                      .updateSettings(
                        settingsID: value!.id,
                        avoidances: displayedIngredients
                            .map((e) => e.ingredientName)
                            .toList(),
                        dietType: value.dietType!,
                        notificationStatus: value.notifications!,
                        language: value.language!,
                      );

                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                },
                child: const Icon(Icons.check),
              ),
            ],
          ),
        );
    }
  }

  void addAvoidance(String newItem) async {
    // parse newWeight to get unit

    final updatedIngredient = newItem;
    final Ingredient newIngredient = Ingredient(
        ingredientName: updatedIngredient, relatedNames: [], removed: false);

    // add avoidance to list of avoidances
    // listAvoidances.add(newIngredient);
    displayedIngredients.add(newIngredient);
  }

  void showModal(BuildContext context, Function(String) onTextUpdate) {
    final TextEditingController textController =
        TextEditingController(text: '');

    showDialog<void>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Add an avoidance'), // Add a title
        content: TextField(
          controller: textController,
          decoration: const InputDecoration(hintText: 'Enter a new item'),
          autofocus: true, // Automatically focus on the field when opened
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () async {
              onTextUpdate(textController.text); // Update text value
              setState(() {});
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

  void rebuildAllChildren(BuildContext context) {
    void rebuild(Element el) {
      el.markNeedsBuild();
      el.visitChildren(rebuild);
    }

    (context as Element).visitChildren(rebuild);
  }

  Widget _buildDismissBackground(BuildContext context) {
    // Extract card shape from your ingredientCard
    final cardShape = RoundedRectangleBorder(
      side: const BorderSide(color: Colors.white, width: 0.3),
      borderRadius: BorderRadius.circular(15),
    );

    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent, // Background color for swipe
        borderRadius: cardShape.borderRadius, // Apply card border radius
      ),
      child:
          const Icon(Icons.delete, color: Colors.white), // Optional delete icon
    );
  }

  Widget ingredientCard(BuildContext context, String content) {
    return Card(
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: Colors.white,
            width: 0.3,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        margin: const EdgeInsets.only(top: 10.0, right: 10.0, left: 10.0),
        child: Padding(
          padding: const EdgeInsets.only(
              right: 15.0, left: 15.0, top: 23, bottom: 23),
          child: Row(
            children: [
              Expanded(
                child: Text(content),
              ),
              // IconButton(
              //   icon: const Icon(Icons.close),
              //   // onPressed: (){Navigator.pop(context);},
              // ),
              const Icon(Icons.close),
            ],
          ),
        ));
  }
}
