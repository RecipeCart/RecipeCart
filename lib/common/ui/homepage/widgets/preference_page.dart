import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_cart/features/settings/controller/settings_controller.dart';
import 'package:recipe_cart/models/ModelProvider.dart';

class PreferencePage extends ConsumerStatefulWidget {
  const PreferencePage({super.key});

  @override
    ConsumerState<PreferencePage> createState() => _PreferencePageBuild();
  
}

enum DietTypes {
  none,
  vegan,
  vegetarian,
  pescatarian,
  dairyfree,
  keto
}

class _PreferencePageBuild extends ConsumerState<PreferencePage> {
  @override
  void initState(){
    super.initState();
    // ref.read(settingsControllerProvider);
    final currentSettings = ref.read(settingsControllerProvider);
    switch(currentSettings){
      case AsyncValue(:final value):
        current = DietTypes.values[value!.dietType!];
      }
  }
  DietTypes current = DietTypes.none;
  @override
  Widget build(BuildContext context) {
  print("value of before current is $current");
  final currentSettings = ref.watch(settingsControllerProvider);
  switch(currentSettings){
    case AsyncValue(:final value):
      // current = DietTypes.values[value!.dietType!];
      print("value of after current is $current");
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
          onPressed: () {
            int index = current.index;
            print(index);
            ref.read(settingsControllerProvider.notifier).updateSettings(settingsID: value!.id, avoidances: value.avoidances!, dietType: index, notificationStatus: value.notifications!, language: value.language!);
            Navigator.pop(context);
          },
          child: const Icon(Icons.check),
        ),

      );
    }  
  }
  Widget optionItem(BuildContext context, DietTypes value, String stwing) {
    return ListTile(
          title: Text(stwing),
          leading: Radio<DietTypes>(
            value: value,
            groupValue: current,
            onChanged: (DietTypes? value) {
              setState(() {
                current = value!;
                print("tried to change $value from $current");
              });
              
            },
          ),
    );
  }
  
}