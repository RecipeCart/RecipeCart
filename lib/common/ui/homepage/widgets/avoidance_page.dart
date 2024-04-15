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
    // print(listIngredients.toString())
;    return Scaffold(
      appBar: AppBar(title: const Text('Avoidances List')),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
            children: <Widget>[
              const SearchBar(),

              listIngredients.isNotEmpty ? ListView.builder(
                itemCount: listIngredients.length,
                itemBuilder: (context, index) {
                  final ingredientNode = listIngredients[index];
                  return ingredientCard(context, ingredientNode.ingredientName);
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