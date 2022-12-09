import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalization {
  final Locale locale;

  AppLocalization(this.locale);

  static AppLocalization of(BuildContext context) {
    return Localizations.of<AppLocalization>(context, AppLocalization)!;
  }

 late Map<String, String> _localizedValues;

  Future load() async {
    String languageJsonValues = await rootBundle
        .loadString('assets/language/${locale.languageCode}.json');

    Map<String, dynamic> mappedJson = json.decode(languageJsonValues);

    _localizedValues = mappedJson.map((key, value) => MapEntry(key, value));
  }

  String getTranslatedVal(String key) {
    return _localizedValues[key]??"No text";
  }

  static const LocalizationsDelegate<AppLocalization> delegate =
      _AppLocalizationDelegate();
}

class _AppLocalizationDelegate extends LocalizationsDelegate<AppLocalization> {
  const _AppLocalizationDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'es', 'pt'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalization> load(Locale locale) async {
    AppLocalization localization = new AppLocalization(locale);
    await localization.load();
    return localization;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalization> old) =>
      false;
}

// class AppLocalizations {
//   static final AppLocalizations _singleton = new AppLocalizations._internal();
//
//   AppLocalizations._internal();
//
//   static AppLocalizations get instance => _singleton;
//
//   late Map<dynamic, dynamic> _localisedValues;
//
//   Future<AppLocalizations> load(Locale locale) async {
//     String jsonContent = await rootBundle
//         .loadString('assets/language/${locale.languageCode}.json');
//     _localisedValues = json.decode(jsonContent);
//     return this;
//   }
//
//   String getTranslatedVal(String key) {
//     return _localisedValues[key] ?? "$key not found";
//   }
// }
//
// class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
//   const AppLocalizationsDelegate();
//
//   @override
//   bool isSupported(Locale locale) =>
//       ['en', 'es', 'pt'].contains(locale.languageCode);
//
//   @override
//   Future<AppLocalizations> load(Locale locale) {
//     return AppLocalizations.instance.load(locale);
//   }
//
//   @override
//   bool shouldReload(AppLocalizationsDelegate old) => true;
// }
