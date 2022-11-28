import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.white,
      backgroundColor: Colors.white,
      primaryColor: Color(0xff2196F3),
      dividerColor: Color(0xffeeeeee),
      appBarTheme: AppBarTheme(
          centerTitle: false,
          color: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black, size: 20),
          titleTextStyle: TextStyle(
            color: Color(0xff2196F3),
            fontSize: 16,
            fontWeight: FontWeight.w500,
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
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: Colors.black,
      ),
      inputDecorationTheme: InputDecorationTheme(
        fillColor: Colors.black,
        labelStyle: TextStyle(
            color: Color(0xff2196F3),
            fontSize: 16,
            fontWeight: FontWeight.normal),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xff2196F3))),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xff2196F3))),
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
      backgroundColor: Colors.black,
      primaryColor: Color(0xff212121),
      dividerColor: Color(0xff121212),
      appBarTheme: AppBarTheme(
          centerTitle: false,
          color: Colors.black,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.white, size: 20),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
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
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: Colors.white,
      ),
      inputDecorationTheme: InputDecorationTheme(
        fillColor: Colors.black,
        labelStyle: TextStyle(
            color: Color(0xff2196F3),
            fontSize: 16,
            fontWeight: FontWeight.normal),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xff2196F3))),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xff2196F3))),
        disabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xff2196F3))),
      ),
      textTheme: TextTheme(
        caption: TextStyle(
          fontSize: 12,
          color: Color(0xffc9c9c9),
          fontWeight: FontWeight.normal,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor:
              MaterialStateColor.resolveWith((states) => Color(0xff212121)),
        ),
      ),
    );
  }
}
