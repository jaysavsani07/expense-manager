import 'package:expense_manager/core/constants.dart';
import 'package:expense_manager/data/models/history.dart';
import 'package:expense_manager/data/repository/entry_repository_imp.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final yearListProvider = StreamProvider<List<int>>((ref) {
  return ref.read(repositoryProvider).getYearList().map((event) {
    if (event.isNotEmpty) {
      ref.read(yearProvider).state = event.first;
    }
    return event;
  });
});

final yearProvider = StateProvider<int>((ref) => DateTime.now().year);

final monthListProvider = StreamProvider<List<String>>((ref) {
  int year = ref.watch(yearProvider).state;
  return ref
      .read(repositoryProvider)
      .getMonthListByYear(year)
      .where((event) => event.isNotEmpty)
      .map((event) {
    ref.read(monthProvider).state = event.first;
    return event;
  });
});

final monthProvider = StateProvider<String>(
    (ref) => AppConstants.monthList[DateTime.now().month]);

final historyListProvider = StreamProvider<List<History>>((ref) {
  String month = ref.watch(monthProvider).state;
  return ref.read(repositoryProvider).getAllEntryWithCategoryDateWiseByMonth(
      AppConstants.monthList.keys
          .firstWhere((element) => AppConstants.monthList[element] == month));
});
