import 'package:flutter/material.dart';

class PreferencePage extends StatefulWidget {
  const PreferencePage({super.key});

  @override
    State<PreferencePage> createState() => _PreferencePageBuild();
  
}

enum DietTypes {
  none,
  vegan,
  vegetarian,
  pescatarian,
  dairyfree,
  keto
}

class _PreferencePageBuild extends State<PreferencePage> {
  @override
  void initState(){
    super.initState();
  }

  DietTypes type = DietTypes.none;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Preference Options')),
      body: Column(
            children: [
              optionItem(context, DietTypes.none, 'None'),
              optionItem(context, DietTypes.vegan, 'Vegan'),
              optionItem(context, DietTypes.vegetarian, 'Vegetarian'),
              optionItem(context, DietTypes.pescatarian, 'Pescatarian'),
              optionItem(context, DietTypes.dairyfree, 'Dairy-free'),
              optionItem(context, DietTypes.keto, 'Keto'),
              
            ],
          ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {Navigator.pop(context);},
        child: const Icon(Icons.check),
      ),

    );
    
  }
  Widget optionItem(BuildContext context, DietTypes value, String stwing) {
    return ListTile(
          title: Text(stwing),
          leading: Radio<DietTypes>(
            value: value,
            groupValue: type,
            onChanged: (DietTypes? value) {
              setState(() {
                type = value!;
                print(type);
              });
              
            },
          ),
    );
  }
  
}