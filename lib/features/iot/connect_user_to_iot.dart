import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:aws_iot_api/iot-2015-05-28.dart';

class IoTPolicyConnector {
  IoTPolicyConnector();

  Future<void> attachPolicyToUser() async {
    IoT iot = IoT(region: 'us-east-2', endpointUrl: 'a30e2r8knzv4ds-ats.iot.us-east-2.amazonaws.com');

    const String policyName = "client-pubSub-permissions-JetsonNano";

    // attaching IoT policy to cognito identity id
    try {
      final result = await Amplify.Auth.getCurrentUser();
      final String cognitoID = result.userId;

      iot.attachPolicy(policyName: policyName, target: cognitoID);
    }
    on Exception catch (e) {
      safePrint("Error attaching policy to Cognito User Identity: $e");
    }
  }
}