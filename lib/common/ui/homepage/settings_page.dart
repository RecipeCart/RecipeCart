import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:recipe_cart/models/Settings.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system; // Initial theme mode

  ThemeMode get themeMode => _themeMode;

  void toggleTheme(ThemeMode newThemeMode) {
    _themeMode = newThemeMode;
    notifyListeners(); // Notify listeners of theme change
  }
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _themeProvider = ThemeProvider(); // Instance of ThemeProvider
  // List<Settings> test = getSettings('en') as List<Settings>;

  // @override
  // void initState() {
  //   super.initState();
  //   getSettings('en').then((data) { // Call getSettings after initState
  //     setState(() {
  //       test = data; // Update state with fetched data
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Add some padding
        child: Column(
          children: [
            // ... other settings options
            _buildThemeModeButton(),
            _logoutButton(),
            // Text(test as String),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeModeButton() {
    return TextButton(
      onPressed: () {
        final newThemeMode = _themeProvider.themeMode == ThemeMode.light
            ? ThemeMode.dark
            : ThemeMode.light;
        _themeProvider.toggleTheme(newThemeMode); // Toggle theme mode
      },
      child: Text(
        _themeProvider.themeMode == ThemeMode.light ? 'Dark Mode' : 'Light Mode',
      ),
    );
  }

  Widget _logoutButton() {
    return  TextButton(
      onPressed: () async {
        final result = await Amplify.Auth.signOut();
        if (result is CognitoCompleteSignOut) {
          safePrint('Sign out completed successfully');
        } else if (result is CognitoFailedSignOut) {
          safePrint('Error signing user out: ${result.exception.message}');
        }
      },
      child: const Text('Log Out'),
    );
                    
  }
  static Future <List<Settings>> getSettings(String itemName) async{
      try{
          // ignore: non_constant_identifier_names
          final Setting = await Amplify.DataStore.query(
              Settings.classType,
              where: Settings.LANGUAGE.contains(itemName)
          );
          return Setting;
      } catch (e){
          throw e;
      }
  }

}
