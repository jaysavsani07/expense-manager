import 'dart:async';
import 'dart:math';

import 'package:expense_manager/core/constants.dart';
import 'package:expense_manager/data/models/category_with_sum.dart';
import 'package:expense_manager/data/models/entry_with_category.dart';
import 'package:expense_manager/data/repository/entry_repository_imp.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tuple/tuple.dart';
import 'package:collection/collection.dart';

final yearListStreamProvider = StreamProvider<List<int>>((ref) {
  return ref.read(repositoryProvider).getYearList(EntryType.all);
});

final selectedYearProvider =
    StateProvider.autoDispose<int>((ref) => DateTime.now().year);

final categoryDetailsModelProvider =
    ChangeNotifierProvider.autoDispose((ref) => CategoryDetailsViewModel(
          entryDataSourceImp: ref.read(repositoryProvider),
          year: ref.watch(selectedYearProvider),
        ));

class CategoryDetailsViewModel with ChangeNotifier {
  EntryRepositoryImp entryDataSourceImp;
  int year;
  int month = DateTime.now().month;
  StreamSubscription streamSubscription;
  List<Tuple3<int, List<EntryWithCategory>, List<EntryWithCategory>>> list;
  List<int> monthList = [];
  AsyncValue<Tuple2<List<CategoryWithSum>, List<CategoryWithSum>>>
      categoryList = AsyncValue.loading();
  AsyncValue<Tuple2<double, List<BarChartGroupData>>> barChartList =
      AsyncValue.loading();

  CategoryDetailsViewModel({
    @required this.entryDataSourceImp,
    @required this.year,
  }) {
    getData();
  }

  getData() {
    streamSubscription = entryDataSourceImp
        .getAllEntryWithCategoryByYear(year)
        .map((event) => event
                .groupListsBy((element) => element.entry.modifiedDate.month)
                .entries
                .map((e) {
              var list = e.value.groupListsBy((element) => element.entryType);
              return Tuple3<int, List<EntryWithCategory>,
                      List<EntryWithCategory>>(e.key,
                  list[EntryType.expense] ?? [], list[EntryType.income] ?? []);
            }).toList())
        .listen((event) {
      list = event;

      monthList = list.map((e) => e.item1).toList().sorted((a, b) {
        if (a > b)
          return -1;
        else if (a < b)
          return 1;
        else
          return 0;
      });
      updateCategoryList();

      barChartList = AsyncValue.data(Tuple2(
          list.map((event) => <double>[
                        event.item2?.map((e) => e.entry.amount)?.fold(
                                0,
                                (previousValue, element) =>
                                    previousValue + element) ??
                            0,
                        event.item3?.map((e) => e.entry.amount)?.fold(
                                0,
                                (previousValue, element) =>
                                    previousValue + element) ??
                            0
                      ])
                  ?.expand((element) => element)
                  ?.toList()
                  ?.reduce(max) ??
              0,
          list
              .map((e) => BarChartGroupData(
                    x: e.item1,
                    barRods: [
                      BarChartRodData(
                        y: e.item3?.map((e) => e.entry.amount)?.fold(
                                0,
                                (previousValue, element) =>
                                    previousValue + element) ??
                            0,
                        width: 16,
                        borderRadius: BorderRadius.circular(2),
                        colors: [
                          Colors.green,
                          Colors.greenAccent,
                        ],
                      ),
                      BarChartRodData(
                        y: e.item2?.map((e) => e.entry.amount)?.fold(
                                0,
                                (previousValue, element) =>
                                    previousValue + element) ??
                            0,
                        width: 16,
                        borderRadius: BorderRadius.circular(2),
                        colors: [
                          Colors.red,
                          Colors.redAccent,
                        ],
                      )
                    ],
                    showingTooltipIndicators: [0],
                  ))
              .toList()));
      notifyListeners();
    });
  }

  void updateCategoryList() {
    var tempTuple3 = list.firstWhere((element) => element.item1 == month);
    categoryList = AsyncValue.data(Tuple2(
        tempTuple3.item3
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
        }),
        tempTuple3.item2
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
        })));
    notifyListeners();
  }

  void changeMonth(int month) {
    this.month = month;
    notifyListeners();
    updateCategoryList();
  }

  @override
  void dispose() {
    streamSubscription.cancel();
    super.dispose();
  }
}
