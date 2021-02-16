import 'package:flutter/cupertino.dart';
import 'package:expense_manager/data/datasource/sharedpref/preferences.dart';
import 'package:expense_manager/data/datasource/sharedpref/shared_preference_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appStateNotifier =
    ChangeNotifierProvider((ref) => AppThemeState(ref.read));

class AppThemeState extends ChangeNotifier {
  Reader reader;
  var isDarkModeEnabled = false;
  var currentLocale = Locale('en', 'US');

  AppThemeState(this.reader) {
    _loadFromPrefs();
  }

  void setLightTheme() {
    isDarkModeEnabled = false;
    _saveToPrefs();
    notifyListeners();
  }

  void setDarkTheme() {
    isDarkModeEnabled = true;
    _saveToPrefs();
    notifyListeners();
  }

  void changeLocale({Locale switchToLocale}) {
    currentLocale = switchToLocale;
    notifyListeners();
  }

  _loadFromPrefs() async {
    isDarkModeEnabled =
        reader(sharedPreferencesProvider).getBool(Preferences.IS_DARK_MODE);
  }

  _saveToPrefs() async {
    await reader(sharedPreferencesProvider).putBool(Preferences.IS_DARK_MODE, isDarkModeEnabled);
  }
}
