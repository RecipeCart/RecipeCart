import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:aws_lambda_api/lambda-2015-03-31.dart';
import 'package:flutter/services.dart';

import 'dart:convert';


class BarcodeInterpreter {
  Future<String> fetchProductInfo(final String barcodeData) async {
    final barcodeDataJson = jsonDecode(barcodeData);

    final String barcode = barcodeDataJson['barcode'];
    final String cognitoID = barcodeDataJson['cognitoID'];

    return _fetchProductInfo(barcode, cognitoID);
  }

  Future<String> _fetchProductInfo(final String barcode, final String cognitoID) async {

    // Fetch current auth session using Amplify Auth Cognito
    final cognitoPlugin = Amplify.Auth.getPlugin(AmplifyAuthCognito.pluginKey);
    final session = await cognitoPlugin.fetchAuthSession();
    final identityId = session.identityIdResult.value;
    safePrint("Current user's identity ID: $identityId");


    // Initalize credentials 
    AwsClientCredentials cred = AwsClientCredentials(
      accessKey: session.credentialsResult.value.accessKeyId,
      secretKey: session.credentialsResult.value.secretAccessKey,
      sessionToken: session.credentialsResult.value.sessionToken
    );
      
    // Edit your region if neccessary
    const region = "us-east-2";
    final service = Lambda(region: region, credentials: cred);

    // json with command
    final json = '''
    {
      "body": {
        "barcode": "$barcode",
        "cognitoID": "$cognitoID"
      }
    }
    ''';

    // Payload containing command
    List<int> payload = json.codeUnits;

    // json payload
    String jsonPayload = "";

    try {
      // try to invoke function
      InvocationResponse lambdaResponse = await service.invoke(
        functionName: "processBarcodeLambda",
        invocationType: InvocationType.requestResponse,
        payload: Uint8List.fromList(payload)
      );

      // payload is returned in a Uint8List but we want to convert it to something readable
      jsonPayload = String.fromCharCodes(lambdaResponse.payload as Iterable<int>);
      safePrint(jsonPayload);
    } catch (e) {
        safePrint("error");
        safePrint(e);
    }

    return jsonPayload;
  }

}