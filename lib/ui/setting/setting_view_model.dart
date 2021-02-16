import 'package:expense_manager/data/datasource/sharedpref/preferences.dart';
import 'package:expense_manager/data/datasource/sharedpref/shared_preference_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final monthStartDateStateNotifier =
    ChangeNotifierProvider((ref) => MonthStartDateState(ref.read));

class MonthStartDateState extends ChangeNotifier {
  Reader reader;
  String date = "1";

  MonthStartDateState(this.reader) {
    _loadFromPrefs();
  }

  _loadFromPrefs() async {
    date = reader(sharedPreferencesProvider)
        .getString(Preferences.MONTH_CYCLE_DATE);
    notifyListeners();
  }

  setDate(String date) async {
    this.date = date;
    notifyListeners();
    await reader(sharedPreferencesProvider)
        .putString(Preferences.MONTH_CYCLE_DATE, date);
  }
}
