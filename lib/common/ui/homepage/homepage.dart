import 'package:flutter/material.dart';
// import 'package:recipe_cart/common/utils/colors.dart' as constants;
// import 'package:recipe_cart/common/ui/homepage/generate_recipe_page.dart';
import 'package:recipe_cart/common/ui/homepage/inventory_page.dart';
import 'package:recipe_cart/common/ui/homepage/saved_recipe_page.dart';
import 'package:recipe_cart/common/ui/homepage/settings_page.dart';
import 'package:recipe_cart/common/ui/homepage/search_recipe_page.dart';
import 'package:recipe_cart/features/ingredient/controller/ingredient_controller.dart';
import 'package:recipe_cart/features/settings/controller/settings_controller.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // int currentPageIndex = 0;
    return const Scaffold(
      // theme: ThemeData(useMaterial3: true, brightness: Brightness.dark),
      body: NavigationExample(),
    );
  }
}

class NavigationExample extends ConsumerStatefulWidget {
  const NavigationExample({super.key});

  @override
  NavigationExampleState createState() => NavigationExampleState();
}

class NavigationExampleState extends ConsumerState<NavigationExample> {
  int currentPageIndex = 0;
  // String weight = "";
  // final weightController = TextEditingController();

  @override
  void initState() {
    super.initState();
    ref.read(ingredientListControllerProvider(searchEntry: ""));
    ref.read(settingsControllerProvider);
    // ref.read(router);
  }

  @override
  Widget build(BuildContext context) {
    final inventoryIngredients =
        ref.watch(ingredientListControllerProvider(searchEntry: ""));
    final settings = ref.watch(settingsControllerProvider);
    // final homeRouter = ref.watch(router);

    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: const Color.fromARGB(255, 234, 7, 255),
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.food_bank_rounded),
            icon: Icon(Icons.food_bank_outlined),
            label: 'Inventory',
          ),
          NavigationDestination(
            icon: Icon(Icons.search),
            label: 'Explore',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.bookmark_added),
            icon: Icon(Icons.bookmark_added_outlined),
            label: 'Saved',
          ),
          // NavigationDestination(
          //   selectedIcon: Icon(Icons.fastfood),
          //   icon: Icon(Icons.fastfood_outlined),
          //   label: 'Generate',
          // ),
          NavigationDestination(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
      body: <Widget>[
        /// Home page
        InventoryPage(inventoryIngredients: inventoryIngredients), //
        // search recipes page
        SearchRecipePage(
            userSettings: settings, inventory: inventoryIngredients),
        /// Saved Recipe page
        SavedRecipePage(userSettings: settings),


        /// Generate Recipe Page
        // const GenerateRecipePage(),

        /// Messages page
        const SettingsPage(), //settings: settings
      ][currentPageIndex],
    );
  }
}
