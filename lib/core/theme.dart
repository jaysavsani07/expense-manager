import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get theme {
    final themeData = ThemeData.dark();
    final textTheme = themeData.textTheme;
    final body1 = textTheme.body1.copyWith(decorationColor: Colors.transparent);

    return ThemeData.dark().copyWith(
      primaryColor: Colors.grey[800],
      accentColor: Colors.cyan[300],
      buttonColor: Colors.grey[800],
      textSelectionColor: Colors.cyan[100],
      toggleableActiveColor: Colors.cyan[300],
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.cyan[300],
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: themeData.dialogBackgroundColor,
        contentTextStyle: body1,
        actionTextColor: Colors.cyan[300],
      ),
      textTheme: textTheme.copyWith(
        body1: body1,
      ),
    );
  }
}
