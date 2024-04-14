import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe_cart/features/ingredient/service/ingredient_api_service.dart';
import 'package:recipe_cart/models/ModelProvider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:mqtt5_client/mqtt5_client.dart';
import 'package:recipe_cart/common/ui/homepage/widgets/inventory_card.dart';
import 'package:recipe_cart/common/ui/homepage/widgets/search_bar.dart';
import 'package:recipe_cart/common/ui/homepage/widgets/expandable_fab.dart';
import 'package:recipe_cart/common/ui/homepage/widgets/action_button.dart';


import 'package:recipe_cart/features/iot/iot_mqtt5_client.dart';
import 'package:recipe_cart/features/ingredient/service/barcode_script_controller.dart';
import 'package:recipe_cart/features/ingredient/service/barcode_interpreter.dart';
import 'package:recipe_cart/features/ingredient/controller/ingredient_controller.dart';
import 'package:ndialog/ndialog.dart';

import 'dart:convert';

<<<<<<< HEAD
class InventoryPage extends ConsumerStatefulWidget {
  const InventoryPage({
    required this.inventoryIngredients,
    super.key});

  final AsyncValue <List<Ingredient?>> inventoryIngredients;

  @override
  InventoryScreenState createState() => InventoryScreenState();

  // State<InventoryPage> createState() => _InventoryScreenState();
}

class InventoryScreenState extends ConsumerState<InventoryPage> {
  int numBarcodeItems = 0;
  String weight = "0"; // Initial weight
  bool isConnected = false;


  final TextEditingController weightController = TextEditingController();

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
  
  // receives all existing ingredients in user's inventory as list
  List<InventoryCard> fetcher = [];
  String productInfo = "";
  
  GlobalKey globalKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final inventoryIngredients = widget.inventoryIngredients;
    switch (inventoryIngredients) {
      case AsyncData(:final value): 
        return value.isEmpty
          ? Scaffold(
            appBar: AppBar(
              title: const Text('Inventory Page'),
            ),
          )
          : Scaffold(
      appBar: AppBar(
        title: const Text('Inventory Page'),
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
                const SearchBarWidget(),
                Expanded(
                  child: 
                          isConnected
                            ? ingredientStream()
                            : ListView.builder(
                                itemBuilder: (context, index) {
                                  String weight = (inventoryIngredients.value[index].toString());
                                  final inventoryCard = InventoryCard(name: detectedIngredients[index].ingredientName, weight: weight, weightController: weightController,); // Get the card at current index
                                  return inventoryCard; // Return the card to be built
                                },
                                scrollDirection: Axis.vertical,
                                itemCount: fetcher.length,
                              
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
                  state = !isConnected ? await _startBarcode() : await _stopBarcode();
                  setState(() {
                    isConnected = state;
                  });
                  if (!isConnected){
                    fetcher.addAll(cache);

                    for (final ingredient in detectedIngredients) {
                      await ref.watch(ingredientListControllerProvider.notifier).addIngredient(ingredientName: ingredient.ingredientName, relatedNames: ingredient.relatedNames, barcode: ingredient.barcode, quantity: ingredient.quantity, standardQuantity: ingredient.standardQuantity, unit: ingredient.unit);
                
                    }
                    if (context.mounted) {
                      context.pop();
                    }
                  } 
                },
                icon: isConnected ? const Icon(Icons.close) : const Icon(Icons.add_circle_outlined),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Visibility(
              visible: isConnected ? true : false,
                child: ActionButton (
                onPressed: () => context.go('/camera'),
                icon: const Icon(Icons.camera_alt_outlined),
                ),
              ),
            ),

          ],
        ),
      ),
    );
      case AsyncError():
        return const Center(child: Text('error'));

      case AsyncLoading():
        return const Center(child: CircularProgressIndicator(),);

      case _:
        return const Center(child: Text("other errors"));
    }
    // return Scaffold(
    //   appBar: AppBar(
    //     title: const Text('Inventory Page'),
    //   ),
    //   extendBody: true,
    //   body: SafeArea(
    //       child: Card(
    //         shape: RoundedRectangleBorder(
    //           side: const BorderSide(
    //             color: Colors.transparent,
    //             width: 0.3,
    //           ),
    //           borderRadius: BorderRadius.circular(15),
    //         ),
    //         margin: const EdgeInsets.only(top: 10.0),
    //         child: Padding(
    //           padding: const EdgeInsetsDirectional.only(bottom: 40),
    //           child: Column(
    //           children: [
    //             const SearchBarWidget(),
    //             Expanded(
    //               child: 
    //                       isConnected
    //                         ? ingredientStream()
    //                         : ListView.builder(
    //                             itemBuilder: (context, index) {
    //                               String weight = (inventoryIngredients.value[index].quantity.toString()) + detectedIngredients[index].unit!;
    //                               final inventoryCard = InventoryCard(name: detectedIngredients[index].ingredientName, weight: weight, weightController: weightController,); // Get the card at current index
    //                               return inventoryCard; // Return the card to be built
    //                             },
    //                             scrollDirection: Axis.vertical,
    //                             itemCount: fetcher.length,
                              
    //                         ),
            
    //             ),
    //           ],
    //         ),
    //         ),
    //       ),
    //   ),
    //   floatingActionButton: Container(
    //     padding: const EdgeInsetsDirectional.only(start: 30, end: 10),
    //     alignment: Alignment.bottomRight,
    //     child: Column(
    //       verticalDirection: VerticalDirection.up,
    //       children: [
    //         ActionButton(
    //             onPressed: () async {
    //               bool state;
    //               state = !isConnected ? await _startBarcode() : await _stopBarcode();
    //               setState(() {
    //                 isConnected = state;
    //               });
    //               if (!isConnected){
    //                 fetcher.addAll(cache);

    //                 for (final ingredient in detectedIngredients) {
    //                   await ref.watch(ingredientListControllerProvider.notifier).addIngredient(ingredientName: ingredient.ingredientName, relatedNames: ingredient.relatedNames, barcode: ingredient.barcode, quantity: ingredient.quantity, standardQuantity: ingredient.standardQuantity, unit: ingredient.unit);
                
    //                 }
    //                 if (context.mounted) {
    //                   context.pop();
    //                 }
    //               } 
    //             },
    //             icon: isConnected ? const Icon(Icons.close) : const Icon(Icons.add_circle_outlined),
    //         ),
    //         Padding(
    //           padding: const EdgeInsets.only(bottom: 10),
    //           child: Visibility(
    //           visible: isConnected ? true : false,
    //             child: ActionButton (
    //             onPressed: () => context.go('/camera'),
    //             icon: const Icon(Icons.camera_alt_outlined),
    //             ),
    //           ),
    //         ),

    //       ],
    //     ),
    //   ),
    // );
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
          safePrint(const JsonEncoder.withIndent(' ').convert(productInfo));

          numBarcodeItems += 1;
          
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.displayMedium!,
      textAlign: TextAlign.center,
      child: FutureBuilder<String>(
        future: retrieveProduct(barcodeData), // a previously-obtained Future<String> or null
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            final ingredient = jsonDecode(snapshot.data!)['body'];
            final String ingredientName = ingredient['ingredientName'];
            final String weightValue = ingredient['quantity'].toString() + ' ' + ingredient['unit'];
            InventoryCard newCard = InventoryCard(name: ingredientName, weight: weightValue, weightController: weightController);
            cache.add(newCard);
            Ingredient detectedIngredient = Ingredient(ingredientName: ingredientName, barcode: ingredient['barcode'], quantity: ingredient['quantity'], relatedNames: ingredient['relatedNames'].cast<String>(), removed: false, standardQuantity: ingredient['standardQuantity'], unit: ingredient['unit']);
            detectedIngredients.add(detectedIngredient);
            safePrint(ingredientName);
            children = <Widget>[
                  Expanded(
                    child: ListView.builder(
                      itemCount: cache.length, // Set itemCount based on list length
                      itemBuilder: (context, index) {
                        final inventoryCard = cache[index]; // Get the card at current index
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
              return barcodeInterpreter
              .fetchProductInfo(barcodeData);
              // .then((value) => {productInfo = value});
          // print(productInfo);
          
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
      numBarcodeItems = 0;
      receiver = [];
    });

    return client.mqttDisconnect();
  }
}
