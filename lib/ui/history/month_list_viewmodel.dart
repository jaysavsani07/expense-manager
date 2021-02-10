import 'package:expense_manager/data/repository/entry_repository_imp.dart';
import 'package:expense_manager/ui/history/history_viewmodel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final monthListViewModelProvider = ChangeNotifierProvider<MonthListViewModel>(
  (ref) {
    int year = ref.watch(historyViewModelProvider).selectedYear;
    return MonthListViewModel(
        entryDataSourceImp: ref.read(repositoryProvider), selectedYear: year);
  },
);

class MonthListViewModel with ChangeNotifier {
  EntryRepositoryImp entryDataSourceImp;

  List<String> monthList = [];
  String selectedMonth = "";
  int selectedYear;

  MonthListViewModel(
      {@required this.entryDataSourceImp, @required this.selectedYear}) {
    entryDataSourceImp.getMonthListByYear(selectedYear).listen((event) {
      monthList = event;
      selectedMonth = event.first;
      notifyListeners();
    });
  }

  void changeMonth(String selectedMonth) {
    this.selectedMonth = selectedMonth;
    notifyListeners();
  }
}
