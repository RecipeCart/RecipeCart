import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:aws_lambda_api/lambda-2015-03-31.dart';
import 'package:flutter/services.dart';


class RatingProcessor {
//public function
  Future<String> updateRating(final int rating, final String recipeID, final String settingsID) async {
    return _updateRating(rating, recipeID, settingsID);
  }

//private function
  Future<String> _updateRating(final int rating, final String recipeID, final String settingsID) async {

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
        "recipeID": "$recipeID",
        "settingsID": "$settingsID",
        "rating": $rating
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
        functionName: "updateRecipeRating",
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