import 'package:expense_manager/data/datasource/sharedpref/preferences.dart';
import 'package:expense_manager/data/datasource/sharedpref/shared_preference_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final monthStartDateStateNotifier =
    ChangeNotifierProvider((ref) => MonthStartDateState());

class MonthStartDateState extends ChangeNotifier {
  String date = "1";

  SharedPreferencesHelper prefs;

  MonthStartDateState() {
    _loadFromPrefs();
  }

  _loadFromPrefs() async {
    prefs = await SharedPreferencesHelper.getInstance();
    date = prefs.getString(Preferences.MONTH_CYCLE_DATE);
  }

  setDate(String date) async {
    this.date = date;
    notifyListeners();
    await prefs.putString(Preferences.MONTH_CYCLE_DATE, date);
  }
}
