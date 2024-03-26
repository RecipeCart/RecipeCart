import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:recipe_cart/recipecart_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'amplifyconfiguration.dart';
import 'models/ModelProvider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // set up Amplify plugins first
  try {
    await _configureAmplify();
  } on AmplifyAlreadyConfiguredException {
    debugPrint('Amplify configuration failed.');
  }

  // initiate app
  runApp(
    const ProviderScope(
      child: RecipeCartApp(),
    ),
  );
}

Future<void> _configureAmplify() async {
  // add services as Amplify plugins here
  try {
    await Amplify.addPlugins([
      AmplifyAuthCognito(),
      AmplifyAPI(modelProvider: ModelProvider.instance)
    ]);

    await Amplify.configure(amplifyconfig);
    safePrint('Successfully configured');

  } on Exception catch (e) {
    safePrint('Error configuring Amplify: $e');
  }
}