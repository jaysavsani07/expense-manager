library currency_text_input_formatter;

import 'package:flutter/services.dart';

class CurrencyTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    bool isInsertedCharacter =
        oldValue.text.length + 1 == newValue.text.length &&
            newValue.text.startsWith(oldValue.text);
    bool isRemovedCharacter =
        oldValue.text.length - 1 == newValue.text.length &&
            oldValue.text.startsWith(newValue.text);
    String newString = oldValue.text;
    if (!isInsertedCharacter && !isRemovedCharacter) {
      return oldValue;
    } else if (isInsertedCharacter) {
      print(newValue.text.substring(newValue.text.length - 1) == ".");
      print(oldValue.text.contains("."));
      if (newValue.text.substring(newValue.text.length - 1) == "." &&
          oldValue.text.contains(".")) {
        newString = oldValue.text;
      } else if (newValue.text.substring(newValue.text.length - 1) == " ") {
        newString = oldValue.text;
      } else {
        if (newValue.text.contains(".")) {
          List<String> list = newValue.text.split(".");
          if (list[1].length < 3) {
            newString = newValue.text;
          } else {
            newString = oldValue.text;
          }
        } else {
          if (oldValue.text.length < 6) {
            newString = newValue.text;
          } else {
            newString = oldValue.text;
          }
        }
      }
    } else {
      newString = newValue.text;
    }
    return TextEditingValue(
      text: newString,
      selection: TextSelection.collapsed(offset: newString.length),
    );
  }
}
