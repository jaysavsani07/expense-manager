import 'dart:async';

import 'package:expense_manager/core/constants.dart';
import 'package:expense_manager/data/models/history.dart';
import 'package:expense_manager/data/repository/entry_repository_imp.dart';
import 'package:expense_manager/ui/history/month_list_viewmodel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final historyListViewModelProvider = ChangeNotifierProvider<HistoryListViewModel>((ref) {
  String month = ref.watch(monthListViewModelProvider).selectedMonth;
  return HistoryListViewModel(
      entryDataSourceImp: ref.read(repositoryProvider), selectedMonth: month);
});

class HistoryListViewModel with ChangeNotifier {
  EntryRepositoryImp entryDataSourceImp;
  StreamSubscription subscription;
  List<History> list = [];
  String selectedMonth;

  HistoryListViewModel(
      {@required this.entryDataSourceImp, @required this.selectedMonth}) {
    subscription = entryDataSourceImp
        .getDateWiseAllEntryWithCategoryByMonth(AppConstants.monthList.keys
            .firstWhere(
                (element) => AppConstants.monthList[element] == selectedMonth,
                orElse: () => 1))
        .listen((event) {
      list = event;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }
}