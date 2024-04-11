import 'package:flutter/material.dart';

class PreferencePage extends StatefulWidget {
  const PreferencePage({super.key});

  @override
    State<PreferencePage> createState() => _PreferencePageBuild();
  
}

class _PreferencePageBuild extends State<PreferencePage> {
  @override
  void initState(){
    super.initState();
  }

  Map<String, bool> values = {
    'vegan': false,
    'vegetarian': false,
    'carnivore': false,
    'pescatarian': false,
    'dairy-free': false,
    'keto': false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Preferencecheckbox')),
      body: Column(
            children: values.keys.map((String key) {
              return CheckboxListTile(
                title: Text(key),
                value: values[key],
                onChanged: (value) {
                  setState(() {
                    values[key] = value!;
                  });
                },
              );
            }).toList(),

          ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {Navigator.pop(context);},
        child: const Icon(Icons.check),
      ),

    );
    
  }
  
}