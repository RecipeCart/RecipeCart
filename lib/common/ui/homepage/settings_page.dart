import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe_cart/models/Settings.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:recipe_cart/common/ui/homepage/widgets/avoidance_page.dart';
import 'package:recipe_cart/common/ui/homepage/widgets/preference_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system; // Initial theme mode

  ThemeMode get themeMode => _themeMode;

  void toggleTheme(ThemeMode newThemeMode) {
    _themeMode = newThemeMode;
    notifyListeners(); // Notify listeners of theme change
  }
}

class SettingsPage extends ConsumerStatefulWidget {
  final AsyncValue<Settings?> settings;

  const SettingsPage({
    super.key,
    required this.settings,
  });

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  final _themeProvider = ThemeProvider(); // Instance of ThemeProvider

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Add some padding
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ... other settings options
            // _buildThemeModeButton(),
            Center(child: _preferenceButton()),
            Center(child: _avoidanceButton()),
            Center(child: _logoutButton()),
            // Text(test as String),
          ],
        ),
      ),
    );
  }

  // Widget _buildThemeModeButton() {
  //   return TextButton(
  //     onPressed: () {
  //       final newThemeMode = _themeProvider.themeMode == ThemeMode.light
  //           ? ThemeMode.dark
  //           : ThemeMode.light;
  //       _themeProvider.toggleTheme(newThemeMode); // Toggle theme mode
  //     },
  //     child: Text(
  //       _themeProvider.themeMode == ThemeMode.light ? 'Dark Mode' : 'Light Mode',
  //     ),
  //   );
  // }

  Widget _logoutButton() {
    return  OutlinedButton(
      onPressed: () async {
        final result = await Amplify.Auth.signOut();
        if (result is CognitoCompleteSignOut) {
          safePrint('Sign out completed successfully');
        } else if (result is CognitoFailedSignOut) {
          safePrint('Error signing user out: ${result.exception.message}');
        }
      },
      style: ButtonStyle(
        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0))),
      ),
      child: const Text(
        'Log Out',
        style: TextStyle(color: Colors.white)
      ),
    );
                    
  }
  Widget _preferenceButton() {
    return  OutlinedButton(
      onPressed: () async {
        context.goNamed('preference');
      },
      style: ButtonStyle(
        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0))),
      ),
      child: const Text(
        'Preferences',
        style: TextStyle(color: Colors.white)
      ),
    );
                    
  }
  Widget _avoidanceButton() {

    return  OutlinedButton(
      onPressed: () async {
        context.goNamed('avoidance');
      },
      style: ButtonStyle(
        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0))),
      ),
      child: const Text(
        'Avoidances',
        style: TextStyle(color: Colors.white)
      ),
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
