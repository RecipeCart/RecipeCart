import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mqtt5_client/mqtt5_client.dart';
import 'package:recipe_cart/common/ui/homepage/widgets/inventory_card.dart';

import 'package:recipe_cart/features/iot/iot_mqtt5_client.dart';
import 'package:recipe_cart/features/ingredient/service/barcode_script_controller.dart';
import 'package:recipe_cart/features/ingredient/service/barcode_interpreter.dart';
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
        child: isConnected
            ? ingredientStream()
            : ListView.builder(
                itemBuilder: (context, index) {
                  return SizedBox(
                      height: MediaQuery.of(context).size.height * .2,
                      child: InventoryCard(
                          name: "name",
                          weight: "weight",
                          weightController: weightController));
                },
                scrollDirection: Axis.vertical,
                itemCount: 2,
              ),
      )),
      floatingActionButton: Column(children: [
        FloatingActionButton(
          onPressed: () => context.go('/camera'),
          child: const Icon(Icons.camera_alt_outlined),
        ),
        FloatingActionButton(
          onPressed: () async {
            bool state = await _startBarcode();
            setState(() {
              isConnected = state;
            });
          },
          child: const Icon(Icons.add_circle_outlined),
        ),
        FloatingActionButton(
          onPressed: () async {
            bool state = await _stopBarcode();
            setState(() {
              isConnected = state;
            });
          },
          child: const Icon(Icons.close),
        )
      ]),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
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

          // pass message to barcodeInterpreter
          String productInfo = "";
          barcodeInterpreter
              .fetchProductInfo(barcodeData)
              .then((value) => {productInfo = value});

          safePrint(const JsonEncoder.withIndent(' ').convert(productInfo));

          setState(() {
            numBarcodeItems += 1;
          });
          return ListView.builder(
            // reverse: false,
            itemBuilder: (context, index) {
              return SizedBox(
                  height: MediaQuery.of(context).size.height * .5,
                  child: ListTile(
                      title: const Text("Ingredient"),
                      subtitle: Text('Latest barcode message: $barcodeData')));
            },
            itemCount: numBarcodeItems,
            scrollDirection: Axis.vertical,
          );
          // child: Text('Latest barcode message: $barcodeData'),
        }
      },
    );
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
    });

    return client.mqttDisconnect();
  }
}
