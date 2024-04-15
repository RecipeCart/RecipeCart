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
  @override
  void initState(){
    super.initState();
    ref.read(settingsControllerProvider);
  }

  @override
  Widget build(BuildContext context) {
    List<Ingredient> listIngredients = ref.read(settingsControllerProvider.notifier).getAvoidances();
    // List<Ingredient> searchResult = [];

    final currentSettings = ref.watch(settingsControllerProvider);

    print(listIngredients.length);

    switch(currentSettings){
      case AsyncValue(:final value):
        return Scaffold(
          appBar: AppBar(title: const Text('Avoidances List')),
          body: SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: Column(
                children: <Widget>[
                  // SearchBar(onChanged: (query)=>{
                  //   searchResult = listIngredients
                  //     .where((item) => item.toLowerCase().contains(query.toLowerCase()))
                  //     .toList();
                  //   },
                  // ),

                  listIngredients.isNotEmpty ? ListView.builder(
                    itemCount: listIngredients.length,
                    itemBuilder: (context, index) {
                      final ingredientNode = listIngredients[index];
                      return Dismissible
                        ( // Wrap the card with Dismissible
                          key: ValueKey(ingredientNode.ingredientName), // Unique key for each item
                          background: _buildDismissBackground(context),
                          
                          onDismissed: (direction) {
                            setState(() { // Update state to remove the item
                              listIngredients.removeAt(index);
                            });
                          },
                          direction: DismissDirection.endToStart,
                          child: ingredientCard(context, ingredientNode.ingredientName),
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
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              ref.read(settingsControllerProvider.notifier).updateSettings(settingsID: value!.id, avoidances: listIngredients.map((e) => e.ingredientName).toList(), dietType: value.dietType!, notificationStatus: value.notifications!, language: value.language!);
              Navigator.pop(context);
            },
            child: const Icon(Icons.check),
          ),

        );
    }

    
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