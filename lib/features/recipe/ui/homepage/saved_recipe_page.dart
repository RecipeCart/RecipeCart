// import 'package:amplify_api/amplify_api.dart';

import 'package:flutter/material.dart';
import 'package:recipe_cart/features/recipe/ui/homepage/widgets/camera_screen.dart';

// import 'package:recipe_cart/features/recipe/ui/camera_module.dart';
// import 'package:recipe_cart/models/ModelProvider.dart';
// import 'package:recipe_cart/features/recipe/ui/inventory_card.dart';

class SavedRecipePage extends StatefulWidget {
  const SavedRecipePage({super.key});
  
  @override
    State<SavedRecipePage> createState() => _SavedRecipeBuild();


}

class _SavedRecipeBuild extends State<SavedRecipePage>{
  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // return ElevatedButton(
    //   // onPressed: () => Navigator.pushNamed('/camera'),
    //   child: const Text('Open Camera'),
    // );
    return const MaterialApp();
    // return const CameraScreen();
  }

}

