library currency_text_input_formatter;

import 'dart:math';

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

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
    if (!isInsertedCharacter && !isRemovedCharacter) {
      return oldValue;
    }
    String newString = oldValue.text;
    if (isRemovedCharacter && newValue.text.isEmpty) {
      newString = "";
    } else if (_lastCharacterIsDigit(newValue.text)) {
      newString = newValue.text;
    } else if (isInsertedCharacter &&
        newValue.text.substring(newValue.text.length - 1) == "." &&
        !oldValue.text.contains(".")) {
      newString = newValue.text;
    } else {
      newString = newValue.text;
    }

    /*final format = NumberFormat.currency(
      locale: locale,
      name: name,
      symbol: symbol,
      decimalDigits: decimalDigits,
      customPattern: customPattern,
    );
    if (turnOffGrouping) {
      format.turnOffGrouping();
    }
    bool isNegative = newValue.text.startsWith('-');
    String newText = newValue.text.replaceAll(RegExp('[^0-9]'), '');

    // If the user wants to remove a digit, but the last character of the
    // formatted text is not a digit (for example, "1,00 €"), we need to remove
    // the digit manually.
    if (isRemovedCharacter && !_lastCharacterIsDigit(oldValue.text)) {
      int length = newText.length - 1;
      newText = newText.substring(0, length > 0 ? length : 0);
    }

    if (isNegative) {
      return oldValue;
    } else if (newText.trim() == '') {
      return newValue.copyWith(
        text: '',
        selection: TextSelection.collapsed(offset: 0),
      );
    } else if (newText == '00' || newText == '000') {
      return TextEditingValue(
        text: '',
        selection: TextSelection.collapsed(offset: 0),
      );
    }

    num newInt = int.parse(newText);
    if (decimalDigits > 0) {
      newInt /= pow(10, decimalDigits);
    }*/
    // String newString = ('') + format.format(newInt).trim();

    print(oldValue.text);
    print(newValue.text);
    return TextEditingValue(
      text: newString,
      selection: TextSelection.collapsed(offset: newString.length),
    );
  }

  static bool _lastCharacterIsDigit(String text) {
    String lastChar = text.substring(text.length - 1);
    return RegExp('[0-9]').hasMatch(lastChar);
  }
}
