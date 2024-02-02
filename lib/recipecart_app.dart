import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:recipe_cart/common/navigation/router/router.dart';
import 'package:recipe_cart/common/utils/colors.dart' as constants;
import 'package:flutter/material.dart';

// Code to wrap the RecipeCart app in an Amplify Authenticator widget

class RecipeCartApp extends StatelessWidget {
  const RecipeCartApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Authenticator(
      child: MaterialApp.router(
        routerConfig: router,
        builder: Authenticator.builder(),
        theme: ThemeData(
          colorScheme:
              ColorScheme.fromSwatch(primarySwatch: constants.primaryColor)
                  .copyWith(
            background: const Color(0xff82CFEA),
          ),
        ),
      ),
    );
  }
}