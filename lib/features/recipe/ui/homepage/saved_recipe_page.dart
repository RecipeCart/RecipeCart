// import 'package:amplify_api/amplify_api.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe_cart/main.dart';
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
    return const CameraScreen();
  }

}

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> with WidgetsBindingObserver{
  CameraController? controller;
  bool _isCameraInitialized = false;

   void onNewCameraSelected(CameraDescription cameraDescription) async {
      final previousCameraController = controller;
      // Instantiating the camera controller
      final CameraController cameraController = CameraController(
        cameraDescription,
        ResolutionPreset.high,
        imageFormatGroup: ImageFormatGroup.jpeg,
      );

      // Dispose the previous controller
      await previousCameraController?.dispose();

      // Replace with the new controller
      if (mounted) {
         setState(() {
           controller = cameraController;
        });
      }

      // Update UI if controller updated
      cameraController.addListener(() {
        if (mounted) setState(() {});
      });

      // Initialize controller
      try {
        await cameraController.initialize();
      } on CameraException catch (e) {
        print('Error initializing camera: $e');
      }

      // Update the Boolean
      if (mounted) {
        setState(() {
           _isCameraInitialized = controller!.value.isInitialized;
        });
      }
   }

  @override
  void initState() {
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    onNewCameraSelected(cameras[0]);
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isCameraInitialized
          ? AspectRatio(
              aspectRatio: 1 / controller!.value.aspectRatio,
              child: controller!.buildPreview(),
            )
          : Container(),
      floatingActionButton: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // "X" button to go back
                FloatingActionButton(
                  onPressed: () => Navigator.pop(context), // Navigate back
                  child: const Icon(Icons.close),
                ),
                // ... other buttons (if needed)
              ],
            ),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = controller;

    // App state changed before we got the chance to initialize.
    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      // Free up memory when camera not active
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      // Reinitialize the camera with same properties
      onNewCameraSelected(cameraController.description);
    }
  }
}