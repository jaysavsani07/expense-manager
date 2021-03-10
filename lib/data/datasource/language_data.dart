import 'package:flutter/cupertino.dart';

class Language {
  final int id;
  final String name;
  final String flag;
  final Locale locale;

  Language({this.id, this.name, this.flag, this.locale});

  static List<Language> languageList() {
    return <Language>[
      Language(
          id: 1, name: "English", flag: "🇺🇸", locale: Locale('en', 'US')),
      Language(
          id: 2, name: "Spanish", flag: "🇪🇸", locale: Locale('es', 'ES')),
      Language(
          id: 3, name: "Portuguese", flag: "🇧🇷", locale: Locale('pt', 'BR')),
    ];
  }
}
