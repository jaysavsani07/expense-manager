import 'dart:math';

import 'package:expense_manager/core/constants.dart';
import 'package:expense_manager/data/models/category_with_sum.dart';
import 'package:expense_manager/data/models/entry_with_category.dart';
import 'package:expense_manager/data/repository/entry_repository_imp.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tuple/tuple.dart';
import 'package:collection/collection.dart';

final yearListStreamProvider = StreamProvider<List<int>>((ref) {
  return ref.read(repositoryProvider).getYearList(EntryType.all);
});

final yearListProvider = StateProvider<List<int>>((ref) {
  return ref
      .watch(yearListStreamProvider)
      .whenOrNull(data: (value) => value, loading: () => []);
});

final selectedYearProvider = StateProvider<int>((ref) => DateTime.now().year);

final allEntryWithCategoryByYearStreamProvider = StreamProvider((ref) {
  var year = ref.watch(selectedYearProvider);
  return ref.read(repositoryProvider).getAllEntryWithCategoryByYear(year);
});

final maxAmountStateProvider = StateProvider((ref) {
  return ref
          .watch(columnChartDataProvider)
          .whenOrNull(data: (value) => value)
          ?.map((event) => <double>[
                event.item2?.map((e) => e.entry.amount)?.fold(0,
                        (previousValue, element) => previousValue + element) ??
                    0,
                event.item3?.map((e) => e.entry.amount)?.fold(0,
                        (previousValue, element) => previousValue + element) ??
                    0
              ])
          ?.expand((element) => element)
          ?.toList()
          ?.reduce(max) ??
      0;
});

final columnChartDataProvider = Provider((ref) {
  return ref.watch(allEntryWithCategoryByYearStreamProvider).whenData((event) {
    return event
        .groupListsBy((element) => element.entry.modifiedDate.month)
        .entries
        .map((e) {
      var list = e.value.groupListsBy((element) => element.entryType);
      return Tuple3<int, List<EntryWithCategory>, List<EntryWithCategory>>(
          e.key, list[EntryType.expense], list[EntryType.income]);
    }).toList();
  });
});

final selectedMonthProvider = StateProvider<int>((ref) => DateTime.now().month);

final monthListProvider = Provider((ref) {
  return ref
      .watch(columnChartDataProvider)
      .whenData((event) => event.map((e) => e.item1).toList());
});

final categoryListProvider = Provider((ref) {
  var month = ref.watch(selectedMonthProvider);
  return ref.watch(columnChartDataProvider).whenData((event) => event
          .firstWhere((element) => element.item1 == month)
          .item2
          .groupListsBy((element) => element.category)
          .entries
          .map((e) => CategoryWithSum(
              total: e.value.fold(
                  0,
                  (previousValue, element) =>
                      previousValue + element.entry.amount),
              category: e.key))
          .toList()
          .sorted((a, b) {
        if (a.total > b.total)
          return -1;
        else if (a.total < b.total)
          return 1;
        else
          return 0;
      }));
});
