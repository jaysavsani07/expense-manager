import 'package:expense_manager/data/models/history.dart';
import 'package:expense_manager/data/repository/entry_repository_imp.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final monthListModelProvider = ChangeNotifierProvider<MonthListViewModel>(
  (ref) => MonthListViewModel(entryDataSourceImp: ref.read(repositoryProvider)),
);

class MonthListViewModel with ChangeNotifier {
  EntryRepositoryImp entryDataSourceImp;

  List<String> monthList = [];
  String selectedMonth = "";

  MonthListViewModel({@required this.entryDataSourceImp}) {
    entryDataSourceImp.getMonthList().listen((event) {
      monthList = event;
      selectedMonth = event.first;
      print(event);
      notifyListeners();
    });
  }

  void changeMonth(String selectedMonth) {
    this.selectedMonth = selectedMonth;
    notifyListeners();
  }
}
