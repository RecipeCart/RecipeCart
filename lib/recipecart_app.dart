import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_cart/common/navigation/router/router.dart';
import 'package:recipe_cart/common/utils/colors.dart' as constants;
import 'package:flutter/material.dart';
import 'package:recipe_cart/common/ui/styles/theme_data_style.dart';

// Code to wrap the RecipeCart app in an Amplify Authenticator widget

class RecipeCartApp extends ConsumerWidget {
  const RecipeCartApp({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return Authenticator(
      initialStep: AuthenticatorStep.signIn,
      child: MaterialApp.router(
        routerConfig: router,
        builder: Authenticator.builder(),
        theme: ThemeDataStyle.light,
        darkTheme: ThemeDataStyle.dark,
      ),
    );
  }
}
