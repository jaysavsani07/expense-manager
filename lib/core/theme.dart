import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.grey.shade50,
        appBarTheme: AppBarTheme(
            color: Vx.white,
            elevation: 0,
            iconTheme: IconThemeData(color: Vx.black, size: 20),
            textTheme: TextTheme(
                headline6: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                bodyText1: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ))));
  }
}
