import 'package:flutter/cupertino.dart';
import 'package:expense_manager/data/datasource/sharedpref/preferences.dart';
import 'package:expense_manager/data/datasource/sharedpref/shared_preference_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info/package_info.dart';
import 'package:tuple/tuple.dart';

final appStateNotifier =
    ChangeNotifierProvider((ref) => AppThemeState(ref.read));

class AppThemeState extends ChangeNotifier {
  Reader reader;
  ThemeMode themeMode = ThemeMode.system;
  Locale currentLocale = Locale('en', 'US');
  Tuple2<String, String> currency = Tuple2("en", "Dollar");
  String userName = "";
  String appVersion = "";

  AppThemeState(this.reader) {
    userName = reader(sharedPreferencesProvider)
        .getString(Preferences.USER_NAME, defValue: "");
    themeMode = ThemeMode.values[
        reader(sharedPreferencesProvider).getInt(Preferences.IS_DARK_MODE) ??
            0];
    currentLocale = reader(sharedPreferencesProvider).getObj(
        Preferences.DEFAULT_LANGUAGE, (v) => Locale(v["lc"], v["cc"]),
        defValue: Locale('en', 'US'));
    currency = reader(sharedPreferencesProvider).getObj(
        Preferences.DEFAULT_CURRENCY, (v) => Tuple2(v["item1"], v["item2"]),
        defValue: Tuple2("en", "Dollar"));

    PackageInfo.fromPlatform().then((value) {
      appVersion = value.version;
    });
  }

  void changeUserName(String name) async {
    this.userName = name;
    notifyListeners();
    await reader(sharedPreferencesProvider)
        .putString(Preferences.USER_NAME, name);
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

  void changeCurrency({Tuple2<String, String> currency}) async {
    this.currency = currency;
    notifyListeners();
    await reader(sharedPreferencesProvider)
        .putObjectNew(Preferences.DEFAULT_CURRENCY, () {
      return "{\"item1\" : \"${currency.item1}\" , \"item2\" : \"${currency.item2}\"}";
    });
  }
}
