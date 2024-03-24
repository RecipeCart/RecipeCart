import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:recipe_cart/common/utils/colors.dart' as constants;

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // int currentPageIndex = 0;

    return MaterialApp(
      theme: ThemeData(useMaterial3: true, brightness: Brightness.dark),
      home: const NavigationExample(),
    );
  }
}

class NavigationExample extends StatefulWidget {
  const NavigationExample({super.key});

  @override
  State<NavigationExample> createState() => _NavigationExampleState();
}

class _NavigationExampleState extends State<NavigationExample> {
  int currentPageIndex = 0;
  String weight = "";
  final weightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventory'),
      ),
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
            selectedIcon: Icon(Icons.bookmark_added),
            icon: Icon(Icons.bookmark_added_outlined),
            label: 'Saved Recipes',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
      body: <Widget>[
        /// Home page
        Card(
          // color: Colors.black,
          shadowColor: Colors.transparent,
          margin: const EdgeInsets.all(8.0),
          child: SizedBox.expand(
            
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                children: <Widget>[
                  Card(
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        color: Colors.white,
                        width: 0.3,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    margin: const EdgeInsets.only(top: 10.0),
                    child: Row( // Use Row for horizontal layout
                      children: [
                        Expanded( // Ensures title takes most space
                          child: ListTile(
                            title: const Text('Watermelon'),
                            subtitle: Row( // Row for weight and edit icon
                              children: [
                                Text('Weight: $weight'),
                                // Editable text field for weight
                                Expanded(
                                  child: TextField(
                                      controller: weightController, // Use controller
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                      border: InputBorder.none,// Remove default border
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Icon trailing the content
                        IconButton(
                          icon: const Icon(Icons.edit), // Use Icons.edit for writing icon
                          onPressed: () {
                            weight = weightController.text;
                          },
                        ),
                      ],
                    ),
                  ),  
                  Card(
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        color: Colors.white,
                        width: 0.3,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    margin: const EdgeInsets.only(top: 10.0),
                    child: Row( // Use Row for horizontal layout
                      children: [
                        Expanded( // Ensures title takes most space
                          child: ListTile(
                            title: const Text('Banana'),
                            subtitle: Row( // Row for weight and edit icon
                              children: [
                                Text('Weight: $weight'),
                                // Editable text field for weight
                                Expanded(
                                  child: TextField(
                                      controller: weightController, // Use controller
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                      border: InputBorder.none,// Remove default border
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Icon trailing the content
                        IconButton(
                          icon: const Icon(Icons.edit), // Use Icons.edit for writing icon
                          onPressed: () {
                            weight = weightController.text;
                          },
                        ),
                      ],
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        color: Colors.white,
                        width: 0.3,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    margin: const EdgeInsets.only(top: 10.0),
                    child: Row( // Use Row for horizontal layout
                      children: [
                        Expanded( // Ensures title takes most space
                          child: ListTile(
                            title: const Text('Orange'),
                            subtitle: Row( // Row for weight and edit icon
                              children: [
                                Text('Weight: $weight'),
                                // Editable text field for weight
                                Expanded(
                                  child: TextField(
                                      controller: weightController, // Use controller
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                      border: InputBorder.none,// Remove default border
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Icon trailing the content
                        IconButton(
                          icon: const Icon(Icons.edit), // Use Icons.edit for writing icon
                          onPressed: () {
                            weight = weightController.text;
                          },
                        ),
                      ],
                    ),
                  ),               
                ],
              ),
            ),

          ),
        ),

        /// Notifications page
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Card(
                child: ListTile(
                  leading: Icon(Icons.notifications_sharp),
                  title: Text('Notification 1'),
                  subtitle: Text('This is a notification'),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.bookmark_add),
                  title: Text('Notification 2'),
                  subtitle: Text('This is a notification'),
                ),
              ),
            ],
          ),
        ),

        /// Messages page
        ListView.builder(
          reverse: true,
          itemCount: 2,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return Align(
                alignment: Alignment.centerRight,
                child: Container(
                  margin: const EdgeInsets.all(8.0),
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    'Hello',
                    style: theme.textTheme.bodyLarge!
                        .copyWith(color: theme.colorScheme.onPrimary),
                  ),
                ),
              );
            }
            return Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.all(8.0),
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  'Hi!',
                  style: theme.textTheme.bodyLarge!
                      .copyWith(color: theme.colorScheme.onPrimary),
                ),
              ),
            );
          },
        ),
      ][currentPageIndex],
    );
  }
}
