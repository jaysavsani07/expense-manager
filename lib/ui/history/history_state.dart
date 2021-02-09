import 'dart:async';

import 'package:expense_manager/core/constants.dart';
import 'package:expense_manager/data/models/history.dart';
import 'package:expense_manager/data/repository/entry_repository_imp.dart';
import 'package:expense_manager/ui/history/month_list_viewmodel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final historyModelProvider = ChangeNotifierProvider<HistoryViewModel>((ref) {
  String month = ref.watch(monthListModelProvider).selectedMonth;
  return HistoryViewModel(
      entryDataSourceImp: ref.read(repositoryProvider), selectedMonth: month);
});

class HistoryViewModel with ChangeNotifier {
  EntryRepositoryImp entryDataSourceImp;
  StreamSubscription subscription;
  List<History> list = [];
  String selectedMonth;

  HistoryViewModel(
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
