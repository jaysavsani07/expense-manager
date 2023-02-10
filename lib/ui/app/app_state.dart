import 'package:expense_manager/data/datasource/sharedpref/preferences.dart';
import 'package:expense_manager/data/datasource/sharedpref/shared_preference_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info/package_info.dart';
import 'package:tuple/tuple.dart';

final appStateNotifier = ChangeNotifierProvider((ref) => AppThemeState(ref));

class AppThemeState extends ChangeNotifier {
  Ref ref;
  ThemeMode themeMode = ThemeMode.system;
  Locale currentLocale = Locale('en', 'US');
  Tuple2<String, String> currency = Tuple2("en", "Dollar");
  String userName = "";
  String appVersion = "";

  AppThemeState(this.ref) {
    userName = ref
        .read(sharedPreferencesProvider)
        .getString(Preferences.USER_NAME, defValue: "");
    themeMode = ThemeMode.values[ref
        .read(sharedPreferencesProvider)
        .getInt(Preferences.IS_DARK_MODE, defValue: 0)];
    currentLocale = ref.read(sharedPreferencesProvider).getObj(
        Preferences.DEFAULT_LANGUAGE, (v) => Locale(v["lc"], v["cc"]),
        defValue: Locale('en', 'US'));
    currency = ref.read(sharedPreferencesProvider).getObj(
        Preferences.DEFAULT_CURRENCY, (v) => Tuple2(v["item1"], v["item2"]),
        defValue: Tuple2("en", "Dollar"));

    PackageInfo.fromPlatform().then((value) {
      appVersion = value.version;
    });
  }

  void changeUserName(String name) async {
    this.userName = name;
    notifyListeners();
    await ref
        .read(sharedPreferencesProvider)
        .putString(Preferences.USER_NAME, name);
  }

  void changeTheme(ThemeMode themeMode) async {
    this.themeMode = themeMode;
    notifyListeners();
    await ref
        .read(sharedPreferencesProvider)
        .putInt(Preferences.IS_DARK_MODE, themeMode.index);
  }

  void changeLocale({required Locale switchToLocale}) async {
    currentLocale = switchToLocale;
    notifyListeners();
    await ref
        .read(sharedPreferencesProvider)
        .putObjectNew(Preferences.DEFAULT_LANGUAGE, () {
      return "{\"lc\" : \"${currentLocale.languageCode}\" , \"cc\" : \"${currentLocale.countryCode}\"}";
    });
  }

  void changeCurrency({required Tuple2<String, String> currency}) async {
    this.currency = currency;
    notifyListeners();
    await ref
        .read(sharedPreferencesProvider)
        .putObjectNew(Preferences.DEFAULT_CURRENCY, () {
      return "{\"item1\" : \"${currency.item1}\" , \"item2\" : \"${currency.item2}\"}";
    });
  }
}
