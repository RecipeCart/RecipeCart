import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:aws_lambda_api/lambda-2015-03-31.dart';
import 'package:flutter/services.dart';


class BarcodeScriptController {
  Future<bool> startBarcodeScript() async {
    return _startStopBarcodeScript("START");
  }

  Future<bool> stopBarcodeScript() async {
    return _startStopBarcodeScript("STOP");
  }

  Future<bool> _startStopBarcodeScript(final String code) async {

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

    final user = await Amplify.Auth.getCurrentUser();
    final String cognitoID = user.userId;

    // json with command
    final json = '''
    {
      "body": {
        "cognitoID": "$cognitoID", 
        "Command": "$code"
      }
    }
    ''';

    // Payload containing command
    List<int> payload = json.codeUnits;

    try {
      // try to invoke function
      InvocationResponse lambdaResponse = await service.invoke(
        functionName: "startStopLambda-deve",
        invocationType: InvocationType.requestResponse,
        payload: Uint8List.fromList(payload)
      );

      // payload is returned in a Uint8List but we want to convert it to something readable
      safePrint(String.fromCharCodes(lambdaResponse.payload as Iterable<int>));
    } catch (e) {
        safePrint("error");
        safePrint(e);
        return false;
    }

    return true;
  }

}