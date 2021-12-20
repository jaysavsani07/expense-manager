import 'package:expense_manager/core/constants.dart';
import 'package:expense_manager/data/models/history.dart';
import 'package:expense_manager/data/repository/entry_repository_imp.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final entryTypeProvider = StateProvider<EntryType>((ref) => EntryType.all);

final yearListProvider = StreamProvider<List<int>>((ref) {
  EntryType entryType = ref.watch(entryTypeProvider.state).state;
  return ref.read(repositoryProvider).getYearList(entryType).map((event) {
    if(event.contains(DateTime.now().year)){
      ref.read(yearProvider.state).state = DateTime.now().year;
    }else{
      ref.read(yearProvider.state).state = event.first;
    }
    return event;
  });
});

final yearProvider = StateProvider<int>((ref) => DateTime.now().year);

final monthListProvider = StreamProvider<List<String>>((ref) {
  int year = ref.watch(yearProvider.state).state;
  EntryType entryType = ref.watch(entryTypeProvider.state).state;
  return ref
      .read(repositoryProvider)
      .getMonthListByYear(entryType, year)
      .map((event) {
        if(year==DateTime.now().year){
          ref.read(monthProvider.state).state =
          AppConstants.monthList[DateTime.now().month];
        }else{
          ref.read(monthProvider.state).state = event.first;
        }
    return event;
  });
});

final monthProvider = StateProvider<String>(
    (ref) => AppConstants.monthList[DateTime.now().month]);

final historyListProvider = StreamProvider<List<History>>((ref) {
  String month = ref.watch(monthProvider.state).state;
  int year = ref.watch(yearProvider.state).state;
  EntryType entryType = ref.watch(entryTypeProvider.state).state;
  return ref
      .read(repositoryProvider)
      .getAllEntryWithCategoryDateWiseByMonthAndYear(
          entryType,
          AppConstants.monthList.keys.firstWhere(
              (element) => AppConstants.monthList[element] == month),
          year);
});
