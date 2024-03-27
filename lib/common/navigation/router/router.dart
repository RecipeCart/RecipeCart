import 'package:recipe_cart/common/navigation/router/routes.dart';
import 'package:recipe_cart/features/recipe/ui/homepage/homepage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe_cart/features/recipe/ui/homepage/saved_recipe_page.dart';

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
          builder: (context, state){return const CameraScreen();}, 
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