import 'package:expense_manager/data/datasource/sharedpref/preferences.dart';
import 'package:expense_manager/data/datasource/sharedpref/shared_preference_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final monthStartDateStateNotifier =
    ChangeNotifierProvider((ref) => MonthStartDateState(ref));

class MonthStartDateState extends ChangeNotifier {
  Ref ref;
  String date = "1";

  MonthStartDateState(this.ref) {
    _loadFromPrefs();
  }

  _loadFromPrefs() async {
    date = ref
        .read(sharedPreferencesProvider)
        .getString(Preferences.MONTH_CYCLE_DATE, defValue: "1");
    notifyListeners();
  }

  setDate(String date) async {
    this.date = date;
    notifyListeners();
    await ref
        .read(sharedPreferencesProvider)
        .putString(Preferences.MONTH_CYCLE_DATE, date);
  }
}
