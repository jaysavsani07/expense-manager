import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.grey.shade50,
        cardTheme: CardTheme(color: Colors.white),
        primaryColor: Colors.blue,
        backgroundColor: Colors.white,
        cursorColor: Colors.white,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.blueGrey
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.greenAccent,
          highlightColor: Colors.red
        ),
        appBarTheme: AppBarTheme(
            color: Vx.white,
            elevation: 0,
            iconTheme: IconThemeData(color: Vx.black, size: 20),
            textTheme: TextTheme(
                headline6: TextStyle(
                  color: Colors.blue,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                bodyText1: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ))));
  }

  static ThemeData get darkTheme {
    return ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.grey.shade900,
        cardTheme: CardTheme(color: Colors.grey.shade800, shadowColor: Colors.grey.shade50),
        cursorColor: Colors.grey.shade800,
        backgroundColor: Colors.grey.shade800,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.pink
        ),
        buttonTheme: ButtonThemeData(
            buttonColor: Colors.blue,
            highlightColor: Colors.red
        ),
        appBarTheme: AppBarTheme(color: Colors.black12));
  }
}
