import 'dart:convert';
import 'dart:io';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_cart/features/ingredient/controller/ingredient_controller.dart';
import 'package:recipe_cart/main.dart';
import 'package:recipe_cart/features/ingredient/service/image_ingredient_detector.dart';

class CameraScreen extends ConsumerStatefulWidget {
  const CameraScreen({super.key});

  @override
  CameraScreenState createState() => CameraScreenState();
}

class CameraScreenState extends ConsumerState<CameraScreen>
    with WidgetsBindingObserver {
  CameraController? controller;
  bool _isCameraInitialized = false;
  Future<void>? _initializeControllerFuture;

  bool _validated = false;

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
    ref.read(ingredientListControllerProvider);
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
              // final bytes = await File(path!).readAsBytes();
              // final img.Image? finalImage = img.decodeImage(bytes);
              List<int> imageBytes = File(path!).readAsBytesSync();

              String base64Image = base64Encode(imageBytes);
              Stopwatch stopwatch = Stopwatch()..start();

              final json = jsonDecode(
                  await imageInterpreter.fetchProductInfo(base64Image));

              List<dynamic> ingredientClassifications =
                  json['class']['data']['Get']['Ingredient'];
              safePrint(
                  "image primarily classified as ${ingredientClassifications.toString()}");
              safePrint(
                  'ingredient classification executed in ${stopwatch.elapsed} ms!');

              String ingredientName = json['ingredientName'];
              List<String> relatedNames = json['relatedNames'].cast<String>();

              final TextEditingController textEditingController =
                  TextEditingController();

              if (!context.mounted) {
                safePrint("context not mounted");
                return;
              }

              showDialog<void>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                        title: Text("'$ingredientName' detected!"),
                        content: TextField(
                            controller: textEditingController,
                            decoration: InputDecoration(
                              hintText: "Enter value and unit here",
                              errorText: _validated
                                  ? "Quantity value cannot be empty!"
                                  : null,
                            ),
                            autofocus: true),
                        actions: <Widget>[
                          IconButton(
                              icon: const Text('Add'),
                              onPressed: () async {
                                if (textEditingController.text == "") {
                                  setState(() {
                                    _validated = false;
                                  });
                                  return;
                                }
                                // parse newWeight to get quantity and unit
                                final splitted =
                                    textEditingController.text.split(' ');
                                final double quantity =
                                    double.parse(splitted[0]);
                                final String unit;
                                if (splitted.length > 1) {
                                  unit = splitted[1];
                                } else {
                                  unit = "g";
                                }
                                await ref
                                    .watch(ingredientListControllerProvider
                                        .notifier)
                                    .addIngredient(
                                        ingredientName: ingredientName,
                                        relatedNames: relatedNames,
                                        quantity: quantity,
                                        unit: unit);
                                if (context.mounted) {
                                  Navigator.pop(context); // Close dialog
                                }
                              }),
                          TextButton(
                            onPressed: () => Navigator.pop(
                                context), // Close dialog on Cancel
                            child: const Text('Cancel'),
                          )
                        ],
                      ));
            } catch (e) {
              // If an error occurs, log the error to the console.
              safePrint(e);
            }
          },
          child: const Center(
            child: Icon(Icons.camera_alt),
          )),
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
