import 'package:flutter/cupertino.dart';
import 'package:expense_manager/data/datasource/sharedpref/preferences.dart';
import 'package:expense_manager/data/datasource/sharedpref/shared_preference_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appStateNotifier =
    ChangeNotifierProvider((ref) => AppThemeState(ref.read));

class AppThemeState extends ChangeNotifier {
  Reader reader;
  ThemeMode themeMode = ThemeMode.system;
  var currentLocale = Locale('en', 'US');

  AppThemeState(this.reader) {
    _loadFromPrefs();
  }

  void changeTheme(ThemeMode themeMode) {
    this.themeMode = themeMode;
    _saveToPrefs();
    notifyListeners();
  }

  void changeLocale({Locale switchToLocale}) {
    currentLocale = switchToLocale;
    notifyListeners();
  }

  _loadFromPrefs() async {
    themeMode = ThemeMode.values[
        reader(sharedPreferencesProvider).getInt(Preferences.IS_DARK_MODE)??0];
  }

  _saveToPrefs() async {
    await reader(sharedPreferencesProvider)
        .putInt(Preferences.IS_DARK_MODE, themeMode.index);
  }
}
