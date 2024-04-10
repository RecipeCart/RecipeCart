import 'package:amplify_flutter/amplify_flutter.dart';

import 'dart:io';

import 'package:flutter/services.dart';

import 'package:mqtt5_client/mqtt5_client.dart';
import 'package:mqtt5_client/mqtt5_server_client.dart';

class Mqtt5Client {
  bool mqttConnected = false;
  // to be edited to replace IoT endpoint with env variable and clientIdentifier
  final MqttServerClient mqttServerClient = MqttServerClient('a30e2r8knzv4ds-ats.iot.us-east-2.amazonaws.com', 'clientIdentifier');

  Future<bool> mqttConnect() async {
    // current Cognito user
    final user = await Amplify.Auth.getCurrentUser();
    final String userID = user.userId;

    // get certs from assets folder
    ByteData rootCA = await rootBundle.load('assets/certs/root.ca.pem');
    ByteData certPem = await rootBundle.load('assets/certs/certificatePem.cert.pem');
    ByteData privateKey = await rootBundle.load('assets/certs/privateKey.private.key');

    // register certs into security context object
    SecurityContext context = SecurityContext.defaultContext;

    context.setClientAuthoritiesBytes(rootCA.buffer.asUint8List());
    context.useCertificateChainBytes(certPem.buffer.asUint8List());
    context.usePrivateKeyBytes(privateKey.buffer.asUint8List());

    // put certs into mqtt server client context and configure settings
    mqttServerClient.securityContext =  context;
    mqttServerClient.logging(on: false);
    mqttServerClient.keepAlivePeriod = 20;
    mqttServerClient.port = 8883;
    mqttServerClient.secure = true;
    mqttServerClient.onConnected = onConnected;
    mqttServerClient.onDisconnected = onDisconnected;
    mqttServerClient.pongCallback = pong;

    final MqttConnectMessage connectMessage = MqttConnectMessage().withClientIdentifier(userID).startClean();
    mqttServerClient.connectionMessage = connectMessage;

    // attempt connecting to MQTT client in AWS IoT
    await mqttServerClient.connect();
    if (mqttServerClient.connectionStatus!.state == MqttConnectionState.connected) {
      safePrint("Connected to AWS IoT MQTT Client");
    }
    else {
      return false;
    }

    // separate topic by userID
    final String topic = 'JetsonNano1/$userID';

    // subscribe to topic
    mqttServerClient.subscribe(topic, MqttQos.atMostOnce);

    return true;
  }

  bool mqttDisconnect() {
    mqttServerClient.disconnect();

    if (mqttServerClient.connectionStatus!.state == MqttConnectionState.disconnected) {
      safePrint("Successfully disconnected from AWS IoT MQTT Client");
    }
    else {
      safePrint("Failed to disconnect from AWS IoT MQTT Client");
      return true;
    }

    return false;
  }

  void setStatus(String content) {
    safePrint(content);

    // setState(() {
    //   statusText = content;
    // });
  }

  void onConnected() {
    setStatus("Client connection was successful");
  }

  void onDisconnected() {
    setStatus("Client disconnection was successful");
    mqttConnected = false;
  }

  void pong() {
    safePrint('Ping response client callback invoked');
  }

}