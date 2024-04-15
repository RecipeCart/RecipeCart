import 'dart:math';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:recipe_cart/models/ModelProvider.dart';
import 'package:mqtt5_client/mqtt5_client.dart';
import 'package:recipe_cart/common/ui/homepage/widgets/inventory_card.dart';
import 'package:recipe_cart/common/ui/homepage/widgets/search_bar.dart';
import 'package:recipe_cart/common/ui/homepage/widgets/action_button.dart';

import 'package:recipe_cart/features/iot/iot_mqtt5_client.dart';
import 'package:recipe_cart/features/ingredient/service/barcode_script_controller.dart';
import 'package:recipe_cart/features/ingredient/service/barcode_interpreter.dart';
import 'package:recipe_cart/features/ingredient/controller/ingredient_controller.dart';
import 'package:ndialog/ndialog.dart';

import 'dart:convert';

class InventoryPage extends ConsumerStatefulWidget {
  const InventoryPage({super.key, required this.inventoryIngredients});

  final AsyncValue<List<Ingredient?>> inventoryIngredients;

  @override
  InventoryScreenState createState() => InventoryScreenState();
}

class InventoryScreenState extends ConsumerState<InventoryPage> {
  String weight = "0"; // Initial weight
  bool isConnected = false;

  // final TextEditingController weightController = TextEditingController();

  // controller to send start/stop command to Jetson Nano
  final BarcodeScriptController barcodeController = BarcodeScriptController();
  // client for receiving IoT messages from Jetson Nano
  final Mqtt5Client client = Mqtt5Client();
  // controller calling lambda to process barcode
  final BarcodeInterpreter barcodeInterpreter = BarcodeInterpreter();

  List<Ingredient> detectedIngredients = [];
  // receives all live incoming data as list
  List<String> receiver = [];
  List<InventoryCard> cache = [];

  String productInfo = "";

  String searchEntry = "";
  String searchInventoryText = "";
  List<Ingredient?> copiedInventory = [];

  @override
  void initState() {
    super.initState();
    ref.read(ingredientListControllerProvider(searchEntry: ""));
  }

  // late var ingredientSearchProvider = FutureProvider((ref) async {
  //   final searchResults = await ref
  //       .read(ingredientListControllerProvider().notifier)
  //       .getIngredientInventory(searchEntry: searchEntry);
  //   return searchResults;
  // });

  @override
  Widget build(BuildContext context) {
    final inventoryIngredients =
        ref.watch(ingredientListControllerProvider(searchEntry: ""));

    // var searchResults = ref.watch(ingredientSearchProvider);
    return inventoryIngredients.when(data: (inventoryIngredients) {
      // if (inventoryIngredients.isEmpty) {
      //   return Scaffold(
      //       appBar: AppBar(
      //         title: const Text('Inventory Page'),
      //       ),
      //       body: const Center(child: Text("No ingredients in inventory")));
      // }
      print("\n\n\ncopied: \n${copiedInventory.length}\n\n\n");
      print("\n\n\ninventory: \n${inventoryIngredients.length}\n\n\n");

      copiedInventory = inventoryIngredients
          .where((element) => element!.ingredientName
              .toLowerCase()
              .contains(searchEntry.toLowerCase()))
          .toList();

      return Scaffold(
        appBar: AppBar(
          title: const Text('Ingredient Inventory'),
        ),
        extendBody: true,
        body: SafeArea(
          child: Card(
            shape: RoundedRectangleBorder(
              side: const BorderSide(
                color: Colors.transparent,
                width: 0.3,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            margin: const EdgeInsets.only(top: 10.0),
            child: Padding(
              padding: const EdgeInsetsDirectional.only(bottom: 40),
              child: Column(
                children: [
                  SearchAnchor(
                    isFullScreen: false,
                    builder:
                        (BuildContext context, SearchController controller) {
                      return SearchBar(
                        hintText: "Search Inventory...",
                        controller: controller,
                        padding: const MaterialStatePropertyAll<EdgeInsets>(
                            EdgeInsets.symmetric(horizontal: 16.0)),
                        onTap: () {
                          if (controller.isOpen) {
                            FocusManager.instance.primaryFocus?.unfocus();
                            controller.closeView(controller.text);
                          } else {
                            setState(() {
                              searchEntry = controller.text;
                            });
                            controller.openView();
                          }
                        },
                        onChanged: (text) {},
                        leading: const Icon(Icons.search),
                      );
                    },
                    suggestionsBuilder:
                        (BuildContext context, SearchController controller) {
                      return List<ListTile>.generate(copiedInventory.length,
                          (int index) {
                        final String item =
                            copiedInventory[index]!.ingredientName;

                        return ListTile(
                          title: Text(item),
                          onTap: () {
                            FocusManager.instance.primaryFocus?.unfocus();

                            setState(() {
                              // update ingredient inventory view to reflect searched copy
                              searchEntry = item;
                            });
                            controller.closeView(item);
                          },
                        );
                      });
                      // searchResults = ref.watch(ingredientSearchProvider);
                      // return searchResults.when(
                      //     data: (data) {
                      //       controller.openView();
                      //       return List<ListTile>.generate(data.length,
                      //           (int index) {
                      //         final String item = data[index]!.ingredientName;
                      //         return ListTile(
                      //           title: Text(item),
                      //           onTap: () {
                      //             print("\n\n\n\ndata length is " +
                      //                 data.length.toString() +
                      //                 "$searchEntry\n\n\n\n");
                      //             setState(() {
                      //               controller.closeView(item);
                      //             });
                      //           },
                      //         );
                      //       });
                      //     },
                      //     error: (e, s) {
                      //       print("Error! $e, $s, \n\n\n\n\n\n");
                      //       return [
                      //         Column(
                      //           children: [
                      //             const Icon(
                      //               Icons.error_outline,
                      //               color: Colors.red,
                      //               size: 60,
                      //             ),
                      //             Padding(
                      //               padding: const EdgeInsets.only(top: 16),
                      //               child: Text('Error: ${e}, Stack ${s}'),
                      //             ),
                      //           ],
                      //         )
                      //       ];
                      //     },
                      //     loading: () => [
                      //           const SizedBox(
                      //             width: 60,
                      //             height: 60,
                      //             child: CircularProgressIndicator(),
                      //           ),
                      //           const Padding(
                      //             padding: EdgeInsets.only(top: 16),
                      //             child: Text('Searching...'),
                      //           ),
                      //         ]);
                    },
                    viewOnChanged: (text) {
                      setState(() {
                        searchEntry = text;
                      });
                    },
                    viewOnSubmitted: (text) {
                      setState(() {
                        searchEntry = text;
                      });
                    },
                  ),
                  Expanded(
                    child: isConnected
                        ? ingredientStream()
                        : ListView.builder(
                            itemBuilder: (context, index) {
                              final inventoryCard = InventoryCard(
                                  ingredient: inventoryIngredients[
                                      index]!); // Get the card at current index
                              return inventoryCard; // Return the card to be built
                            },
                            scrollDirection: Axis.vertical,
                            itemCount: inventoryIngredients.length,
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: Container(
          padding: const EdgeInsetsDirectional.only(start: 30, end: 10),
          alignment: Alignment.bottomRight,
          child: Column(
            verticalDirection: VerticalDirection.up,
            children: [
              ActionButton(
                onPressed: () async {
                  bool state;
                  state = !isConnected
                      ? await _startBarcode()
                      : await _stopBarcode();
                  setState(() {
                    isConnected = state;
                  });

                  if (!isConnected) {
                    for (final ingredient in detectedIngredients) {
                      await ref
                          .watch(
                              ingredientListControllerProvider(searchEntry: "")
                                  .notifier)
                          .addIngredient(
                              ingredientName: ingredient.ingredientName,
                              relatedNames: ingredient.relatedNames,
                              barcode: ingredient.barcode,
                              quantity: ingredient.quantity,
                              standardQuantity: ingredient.standardQuantity,
                              unit: ingredient.unit);
                    }

                    // reset detected ingredient list
                    detectedIngredients = [];
                    cache = [];
                  }
                },
                icon: isConnected
                    ? const Icon(Icons.close)
                    : const Icon(Icons.add_circle_outlined),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Visibility(
                  visible: isConnected ? true : false,
                  child: ActionButton(
                    onPressed: () => context.go('/camera'),
                    icon: const Icon(Icons.camera_alt_outlined),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }, error: (error, stack) {
      return const Center(child: Text('error'));
    }, loading: () {
      return const Center(
        child: CircularProgressIndicator(),
      );
    });
  }

  Widget ingredientStream() {
    return StreamBuilder<List<MqttReceivedMessage<MqttMessage>>>(
      stream: client.mqttServerClient.updates,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
              //child: Text('No barcode yet')
              child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ));
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          // get message and decode from bytes into Strings
          final mqttReceivedMessages =
              snapshot.data; // as List<MqttReceivedMessage<MqttMessage?>>?;
          final receivedMessage =
              mqttReceivedMessages!.first.payload as MqttPublishMessage;

          final barcodeData = MqttUtilities.bytesToStringAsString(
              receivedMessage.payload.message!);
          safePrint("barcode data: $barcodeData");

          receiver.add(barcodeData);

          return DefaultTextStyle(
            style: Theme.of(context).textTheme.displayMedium!,
            textAlign: TextAlign.center,
            child: FutureBuilder<String>(
              future: retrieveProduct(
                  barcodeData), // a previously-obtained Future<String> or null
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                List<Widget> children;
                if (snapshot.hasData) {
                  final ingredientData = jsonDecode(snapshot.data!)['body'];
                  final String ingredientName =
                      ingredientData['ingredientName'];
                  //final String weightValue = "${ingredientData['quantity'].toString()} ${ingredientData['unit']}";
                  List<String> relatedNames =
                      List<String>.from(ingredientData['relatedNames'] as List);

                  Ingredient detectedIngredient = Ingredient(
                      ingredientName: ingredientName,
                      barcode: ingredientData['barcode'],
                      quantity: ingredientData['quantity'],
                      relatedNames: relatedNames,
                      removed: false,
                      standardQuantity: ingredientData['standardQuantity'],
                      unit: ingredientData['unit']);
                  InventoryCard newCard =
                      InventoryCard(ingredient: detectedIngredient);

                  cache.add(newCard);
                  detectedIngredients.add(detectedIngredient);
                  safePrint(ingredientName);
                  children = <Widget>[
                    Expanded(
                      child: ListView.builder(
                        itemCount:
                            cache.length, // Set itemCount based on list length
                        itemBuilder: (context, index) {
                          final inventoryCard =
                              cache[index]; // Get the card at current index
                          return inventoryCard; // Return the card to be built
                        },
                        scrollDirection: Axis.vertical,
                      ),
                    ),
                  ];
                } else if (snapshot.hasError) {
                  children = <Widget>[
                    const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 60,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text('Error: ${snapshot.error}'),
                    ),
                  ];
                } else {
                  children = const <Widget>[
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: CircularProgressIndicator(),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Text('Awaiting result...'),
                    ),
                  ];
                }
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: children,
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }

  Future<String> retrieveProduct(String barcodeData) async {
    return await barcodeInterpreter.fetchProductInfo(barcodeData);
  }

  Future<bool> _startBarcode() async {
    ProgressDialog progressDialog = ProgressDialog(context,
        blur: 0,
        dialogTransitionType: DialogTransitionType.Shrink,
        dismissable: false,
        title: null,
        message: null);

    cache = [];

    progressDialog.setLoadingWidget(const CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation(Colors.red),
    ));
    progressDialog.setMessage(const Text("Connecting to Jetson Nano..."));
    progressDialog.setTitle(const Text("Connecting"));
    progressDialog.show();

    // call start barcode detection lambda
    bool barcodeStarted = await barcodeController.startBarcodeScript();

    bool status = await client.mqttConnect();

    progressDialog.dismiss();

    return status;
  }

  Future<bool> _stopBarcode() async {
    // call stop barcode detection lambda
    bool barcodeStopped = await barcodeController.stopBarcodeScript();

    setState(() {
      receiver = [];
    });

    return client.mqttDisconnect();
  }
}
