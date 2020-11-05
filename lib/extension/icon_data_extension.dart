import 'dart:convert';

import 'package:flutter/material.dart';

extension IconDataExtension on IconData {
  String iconDataToJson() => jsonEncode({
        'codePoint': this.codePoint,
        'fontFamily': this.fontFamily,
        'fontPackage': this.fontPackage,
        'matchTextDirection': this.matchTextDirection
      });
}
