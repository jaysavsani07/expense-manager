import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.white,
      backgroundColor: Colors.white,
      cursorColor: Colors.black,
      primaryColor: Color(0xff2196F3),
      appBarTheme: AppBarTheme(
          color: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black, size: 20),
          textTheme: TextTheme(
            headline6: TextStyle(
              color: Colors.blue,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          )),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      bottomAppBarTheme: BottomAppBarTheme(
        color: Colors.white,
      ),
      cardTheme: CardTheme(
        color: Colors.white,
      ),
      textTheme: TextTheme(
        caption: TextStyle(
          fontSize: 12,
          color: Color(0xff212121),
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Colors.black,
      cursorColor: Colors.white,
      backgroundColor: Colors.black,
      primaryColor: Color(0xff212121),
      appBarTheme: AppBarTheme(
          color: Colors.black,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.white, size: 20),
          textTheme: TextTheme(
            headline6: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          )),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Color(0xff212121),
        foregroundColor: Colors.white,
      ),
      bottomAppBarTheme: BottomAppBarTheme(
        color: Color(0xff212121),
      ),
      cardTheme: CardTheme(
        color: Color(0xff212121),
        shadowColor: Color(0x000000DE),
      ),
      textTheme: TextTheme(
        caption: TextStyle(
          fontSize: 12,
          color: Color(0xffc9c9c9),
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}
