import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_cart/features/settings/controller/settings_controller.dart';
import 'package:recipe_cart/models/ModelProvider.dart';

class AvoidancePage extends ConsumerStatefulWidget {
  const AvoidancePage({
    super.key
    });

  @override
    ConsumerState<AvoidancePage> createState() => _AvoidancePageBuild();
  
}

class _AvoidancePageBuild extends ConsumerState<AvoidancePage> {
  List<Ingredient> displayedIngredients = []; 
  List<Ingredient> listIngredients = [];

  @override
  void initState(){
    super.initState();
    final listIngredients = ref.read(settingsControllerProvider.notifier).getAvoidances();
    displayedIngredients = listIngredients;
  }

  @override
  Widget build(BuildContext context) {
    List<Ingredient> listIngredients = ref.read(settingsControllerProvider.notifier).getAvoidances();
    
    final currentSettings = ref.watch(settingsControllerProvider);

    print(listIngredients.length);

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
                                listIngredients.removeAt(listIngredients.indexOf(ingredient));
                                displayedIngredients.removeAt(index);
                              });
                            },
                            direction: DismissDirection.endToStart,
                            child: ingredientCard(context, ingredient.ingredientName),
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
            children:[
              FloatingActionButton(
                onPressed: () async {
                  showModal(context, newItem);
                },
                child: const Icon(Icons.add),
              ),
              FloatingActionButton(
                onPressed: () async {
                  await ref.read(settingsControllerProvider.notifier).updateSettings(
                    settingsID: value!.id,
                    avoidances: listIngredients.map((e) => e.ingredientName).toList(),
                    dietType: value.dietType!,
                    notificationStatus: value.notifications!,
                    language: value.language!,
                  );

                  if(context.mounted) {
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

  void newItem(String newItem) {
    // parse newWeight to get unit

    final updatedIngredient = newItem;
    final Ingredient newIngredient = Ingredient(ingredientName: updatedIngredient, relatedNames: [], removed: false);
    listIngredients.add(newIngredient);

    // await ref.read(settingsControllerProvider.notifier).updateSettings(
    //   settingsID: value!.id,
    //   avoidances: listIngredients.map((e) => e.ingredientName).toList(),
    //   dietType: value.dietType!,
    //   notificationStatus: value.notifications!,
    //   language: value.language!,
    // );
  }

  void showModal(
      BuildContext context, Function(String) onTextUpdate) {
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
      child: const Icon(Icons.delete, color: Colors.white), // Optional delete icon
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
      margin: const EdgeInsets.only(top: 10.0, right: 10.0, left: 10.0),
      child: Padding(
        padding: const EdgeInsets.only(right: 15.0, left: 15.0, top: 23, bottom: 23),
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
      ) 
      
    );
  }
  
}