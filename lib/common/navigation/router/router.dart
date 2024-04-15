import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_cart/common/navigation/router/routes.dart';
import 'package:recipe_cart/common/ui/homepage/homepage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe_cart/common/ui/homepage/widgets/camera_screen.dart';
import 'package:recipe_cart/common/ui/homepage/widgets/preference_page.dart';
import 'package:recipe_cart/common/ui/homepage/widgets/avoidance_page.dart';
import 'package:recipe_cart/models/ModelProvider.dart';

final routerProvider = Provider((ref) {
  return GoRouter(
    routes: [
      GoRoute(
        path: '/',
        name: AppRoute.home.name,
        builder: (context, state) => const HomePage(),
        routes: <RouteBase>[
          GoRoute(
            path: 'camera',
            // name: AppRoute.home.name,
            builder: (context, state) => const CameraScreen(),
          ),
          GoRoute(
            path: 'preference',
            name: 'preference',
            builder: (context, state) => const PreferencePage(),
          ),
          GoRoute(
            path: 'avoidance',
            name: 'avoidance',
            builder: (context, state) => const AvoidancePage(),
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text(state.error.toString()),
      ),
    ),
    // navigatorBuilder: (context, state, child) {
    //   return Consumer(
    //     builder: (_, ref, __) =>
    //       ref.watch(authControllerProvider).asData?.value == null
    //         ? Navigator(
    //             onGenerateRoute: (settings) => MaterialPageRoute(
    //               builder: (context) => AuthScreen(),
    //             ),
    //           )
    //         : child,
    //   );
    // },
  );
});