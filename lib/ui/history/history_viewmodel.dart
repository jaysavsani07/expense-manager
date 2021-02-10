import 'dart:async';

import 'package:expense_manager/core/constants.dart';
import 'package:expense_manager/data/models/history.dart';
import 'package:expense_manager/data/repository/entry_repository_imp.dart';
import 'package:expense_manager/ui/history/month_list_viewmodel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final historyViewModelProvider =
    ChangeNotifierProvider<HistoryViewModel>((ref) {
  return HistoryViewModel(entryDataSourceImp: ref.read(repositoryProvider));
});

class HistoryViewModel with ChangeNotifier {
  EntryRepositoryImp entryDataSourceImp;
  StreamSubscription subscription;
  List<int> yearList = [];
  int selectedYear;
  int maxYear;
  int minYear;

  HistoryViewModel({@required this.entryDataSourceImp}) {
    subscription = entryDataSourceImp.getYearList().listen((event) {
      yearList = event;
      selectedYear = event.first;
      maxYear = event.first;
      minYear = event.last;
      notifyListeners();
    });
  }

  void changeYear(int year){
    this.selectedYear=year;
    notifyListeners();
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }
}
