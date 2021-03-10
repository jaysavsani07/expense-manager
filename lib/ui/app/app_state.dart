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
    themeMode = ThemeMode.values[
        reader(sharedPreferencesProvider).getInt(Preferences.IS_DARK_MODE) ??
            0];
    currentLocale = reader(sharedPreferencesProvider).getObj(
        Preferences.DEFAULT_LANGUAGE, (v) => Locale(v["lc"], v["cc"]),
        defValue: Locale('en', 'US'));
  }

  void changeTheme(ThemeMode themeMode) async {
    this.themeMode = themeMode;
    notifyListeners();
    await reader(sharedPreferencesProvider)
        .putInt(Preferences.IS_DARK_MODE, themeMode.index);
  }

  void changeLocale({Locale switchToLocale}) async {
    currentLocale = switchToLocale;
    notifyListeners();
    await reader(sharedPreferencesProvider)
        .putObjectNew(Preferences.DEFAULT_LANGUAGE, () {
      return "{\"lc\" : \"${currentLocale.languageCode}\" , \"cc\" : \"${currentLocale.countryCode}\"}";
    });
  }
}
