import 'dart:convert';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:recipe_cart/main.dart';
import 'package:image/image.dart' as img;
import 'package:recipe_cart/features/ingredient/service/image_ingredient_detector.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> with WidgetsBindingObserver{
  CameraController? controller;
  bool _isCameraInitialized = false;
  Future<void>? _initializeControllerFuture;

  final ImageIngredientDetector imageInterpreter = ImageIngredientDetector();

   void onNewCameraSelected(CameraDescription cameraDescription) async {
      final previousCameraController = controller;
      // Instantiating the camera controller
      final CameraController cameraController = CameraController(
        cameraDescription,
        ResolutionPreset.medium,
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
        if (kDebugMode) {
          print('Error initializing camera: $e');
        }
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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: _isCameraInitialized
          ? AspectRatio(
              aspectRatio: 1 / controller!.value.aspectRatio,
              child: controller!.buildPreview(),
            )
          : Container(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Take the Picture in a try / catch block. If anything goes wrong,
          // catch the error.
          try {
            // Ensure that the camera is initialized.
            await _initializeControllerFuture;

            // Attempt to take a picture and then get the location
            // where the image file is saved.
            final image = await controller?.takePicture();
            final path = image?.path;
            final bytes = await File(path!).readAsBytes();
            // final img.Image? finalImage = img.decodeImage(bytes);
            List<int> imageBytes = File(path).readAsBytesSync();

            String base64Image = base64Encode(imageBytes);
            print("image bytes");
            print(base64Image);
            Stopwatch stopwatch = new Stopwatch()..start();
            print(await imageInterpreter.fetchProductInfo(base64Image));
            print('imageInterpretor() executed in ${stopwatch.elapsed}');
            if (!context.mounted) return;

          } catch (e) {
            // If an error occurs, log the error to the console.
            print(e);
          }
        },
        child: const Icon(Icons.camera_alt),
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