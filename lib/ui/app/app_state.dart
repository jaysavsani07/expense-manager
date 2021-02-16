import 'package:flutter/cupertino.dart';
import 'package:expense_manager/data/datasource/sharedpref/preferences.dart';
import 'package:expense_manager/data/datasource/sharedpref/shared_preference_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final appStateNotifier = ChangeNotifierProvider((ref) => AppThemeState());

class AppThemeState extends ChangeNotifier {
  var isDarkModeEnabled = false;
  var currentLocale = Locale('en', 'US');

  SharedPreferencesHelper prefs;

  AppThemeState() {
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


  void changeLocale({Locale switchToLocale}){
    currentLocale = switchToLocale;
    notifyListeners();
  }

  _loadFromPrefs() async {
    prefs = await SharedPreferencesHelper.getInstance();
    isDarkModeEnabled = prefs.getBool(Preferences.IS_DARK_MODE);
  }

  _saveToPrefs() async {
    await prefs.putBool(Preferences.IS_DARK_MODE, isDarkModeEnabled);
  }
}

