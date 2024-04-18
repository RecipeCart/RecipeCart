import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:aws_lambda_api/lambda-2015-03-31.dart';
import 'package:flutter/services.dart';

import 'dart:convert';

class SearchRecipeLambdaInvoker {
  Future<String> searchRecipes(
      final String searchEntry,
      final List<List<String>> allRelatedNames,
      final String dietType,
      final List<List<String>> avoidances,
      final int offset) async {
    return _searchRecipes(searchEntry, jsonEncode(allRelatedNames), dietType,
        jsonEncode(avoidances), offset);
  }

  Future<String> _searchRecipes(
      final String searchEntry,
      final String allRelatedNames,
      final String dietType,
      final String avoidances,
      final int offset) async {
    // Fetch current auth session using Amplify Auth Cognito
    final cognitoPlugin = Amplify.Auth.getPlugin(AmplifyAuthCognito.pluginKey);
    final session = await cognitoPlugin.fetchAuthSession();
    final identityId = session.identityIdResult.value;
    safePrint("Current user's identity ID: $identityId");

    // Initalize credentials
    AwsClientCredentials cred = AwsClientCredentials(
        accessKey: session.credentialsResult.value.accessKeyId,
        secretKey: session.credentialsResult.value.secretAccessKey,
        sessionToken: session.credentialsResult.value.sessionToken);

    // Edit your region if neccessary
    const region = "us-east-2";
    final service = Lambda(region: region, credentials: cred);

    // json with command
    final json = '''
    {
      "body": {
        "searchEntry": "$searchEntry",
        "allRelatedNames": $allRelatedNames,
        "dietType": "$dietType",
        "avoidances": $avoidances,
        "offset": $offset
      }
    }
    ''';

    print("\n\n\n\n\nRECIPE REQUEST: $json\n\n\n\n\n");

    // Payload containing command
    List<int> payload = json.codeUnits;

    // json payload
    String jsonPayload = "";

    try {
      // try to invoke function
      InvocationResponse lambdaResponse = await service.invoke(
          functionName: "recipeSearchWeaviate",
          invocationType: InvocationType.requestResponse,
          payload: Uint8List.fromList(payload));

      // payload is returned in a Uint8List but we want to convert it to something readable
      jsonPayload =
          String.fromCharCodes(lambdaResponse.payload as Iterable<int>);
      safePrint(jsonPayload);
    } catch (e) {
      safePrint("error");
      safePrint(e);
    }

    return jsonPayload;
  }
}
