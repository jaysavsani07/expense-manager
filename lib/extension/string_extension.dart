import 'dart:convert';

import 'package:flutter/cupertino.dart';

extension StringExtension on String {
  IconData jsonToIconData() {
    Map<String, dynamic> map = jsonDecode(this);
    return IconData(
      map['codePoint'],
      fontFamily: map['fontFamily'],
      fontPackage: map['fontPackage'],
      matchTextDirection: map['matchTextDirection'],
    );
  }
}
