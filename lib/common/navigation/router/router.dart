import 'package:recipe_cart/common/navigation/router/routes.dart';
import 'package:recipe_cart/features/recipe/ui/homepage/homepage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe_cart/features/recipe/ui/homepage/widgets/camera_screen.dart';
import 'package:recipe_cart/features/recipe/ui/homepage/widgets/preference_page.dart';
import 'package:recipe_cart/features/recipe/ui/homepage/widgets/avoidance_page.dart';

final router = GoRouter(
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
          // name: AppRoute.home.name,
          builder: (context, state) => const PreferencePage(), 
        ),
        GoRoute(
          path: 'avoidance',
          // name: AppRoute.home.name,
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
);