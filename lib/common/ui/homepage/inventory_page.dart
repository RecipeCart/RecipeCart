import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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

class InventoryPage extends StatefulWidget {
  const InventoryPage({super.key});

  @override
  State<InventoryPage> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryPage> {
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
  // receives all live incoming data as list
  List<String> receiver = [];
  // receives all existing ingredients in user's inventory as list
  List<InventoryCard> fetcher = [];
  String productInfo = "";
  // const api = new api();
  // final Ingredient test = queryItem('raisins') as Ingredient;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                              return SizedBox(
                                height: MediaQuery.of(context).size.height * .2,
                                child: InventoryCard(
                                  name: "name",
                                  weight: "weight",
                                  weightController: weightController
                                )
                              );
                            },
                            scrollDirection: Axis.vertical,
                            itemCount: 7,
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
            safePrint(ingredientName);
            children = <Widget>[
              const Icon(
                Icons.check_circle_outline,
                color: Colors.green,
                size: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(
                  'Result: $ingredientName',
                  style: const TextStyle(fontSize: 10),  
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
          // return ListView.builder(
          //   // reverse: false,
          //   itemBuilder: (context, index) {
          //     return SizedBox(
          //         height: MediaQuery.of(context).size.height * .5,
          //         child: ListTile(
          //             title: const Text("Ingredient"),
          //             subtitle: Text('Latest barcode message: ${receiver[index]}')));
          //   },
          //   itemCount: numBarcodeItems,
          //   scrollDirection: Axis.vertical,
          // );
          // child: Text('Latest barcode message: $barcodeData');
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
