import 'dart:async';
import 'dart:math';

import 'package:expense_manager/core/constants.dart';
import 'package:expense_manager/data/models/category_with_sum.dart';
import 'package:expense_manager/data/models/entry_with_category.dart';
import 'package:expense_manager/data/repository/entry_repository_imp.dart';
import 'package:fimber/fimber.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tuple/tuple.dart';
import 'package:collection/collection.dart';

final yearListStreamProvider = StreamProvider<List<int>>((ref) {
  return ref
      .read(repositoryProvider)
      .getYearList(EntryType.all)
      .map((event) => event.where((element) => element <= DateTime.now().year).toList());
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
  int month;
  QuarterlyType quarterlyType;

  StreamSubscription streamSubscription;
  List<Tuple3<int, List<EntryWithCategory>, List<EntryWithCategory>>> mainList;
  List<Tuple3<int, List<EntryWithCategory>, List<EntryWithCategory>>> list;

  List<int> monthList = [];
  Map<QuarterlyType, List<int>> quarterList = {};

  AsyncValue<Tuple2<List<CategoryWithSum>, List<CategoryWithSum>>>
      categoryList = AsyncValue.loading();
  AsyncValue<Tuple2<double, List<BarChartGroupData>>> barChartList =
      AsyncValue.loading();

  CategoryDetailsViewModel({
    @required this.entryDataSourceImp,
    @required this.year,
  }) {
    getQuarterList();
    getMonthList();
    streamSubscription = entryDataSourceImp
        .getAllEntryWithCategoryByYear(year, month)
        .listen((event) {
      mainList = event;
      updateData();
    });
  }

  updateData() {
    list = mainList
        .where((element) => quarterList[quarterlyType].contains(element.item1))
        .toList();

    updateCategoryList();

    barChartList = AsyncValue.data(Tuple2(
        list
                .map((event) => <double>[
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
                      width: 30,
                      borderRadius: BorderRadius.circular(4),
                      colors: [
                        Colors.green,
                        // Colors.greenAccent,
                      ],
                    ),
                    BarChartRodData(
                      y: e.item2?.map((e) => e.entry.amount)?.fold(
                              0,
                              (previousValue, element) =>
                                  previousValue + element) ??
                          0,
                      width: 30,
                      borderRadius: BorderRadius.circular(4),
                      colors: [
                        Colors.red,
                        // Colors.redAccent,
                      ],
                    )
                  ],
                  showingTooltipIndicators: [0],
                ))
            .toList()));
    notifyListeners();
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

  void changeQuarter(QuarterlyType quarterlyType) {
    this.quarterlyType = quarterlyType;
    getMonthList();
    notifyListeners();
    updateData();
  }

  void getQuarterList() {
    if (year == DateTime.now().year) {
      for (int i = 1; i <= DateTime.now().month; i++) {
        if (i <= 3) {
          if (quarterList[QuarterlyType.Q1] == null)
            quarterList[QuarterlyType.Q1] = [i];
          else
            quarterList[QuarterlyType.Q1].add(i);
        } else if (i <= 6) {
          if (quarterList[QuarterlyType.Q2] == null)
            quarterList[QuarterlyType.Q2] = [i];
          else
            quarterList[QuarterlyType.Q2].add(i);
        } else if (i <= 9) {
          if (quarterList[QuarterlyType.Q3] == null)
            quarterList[QuarterlyType.Q3] = [i];
          else
            quarterList[QuarterlyType.Q3].add(i);
        } else {
          if (quarterList[QuarterlyType.Q4] == null)
            quarterList[QuarterlyType.Q4] = [i];
          else
            quarterList[QuarterlyType.Q4].add(i);
        }
      }
      quarterlyType = quarterList.entries.last.key;
    } else {
      quarterList = AppConstants.quarterlyMonth;
      quarterlyType = QuarterlyType.Q4;
    }
    Fimber.e(quarterlyType.toString());
    Fimber.e(quarterList.toString());
  }

  void getMonthList() {
    monthList = quarterList[quarterlyType].sorted((a, b) {
      if (a > b)
        return -1;
      else if (a < b)
        return 1;
      else
        return 0;
    });
    month = monthList.first;
    Fimber.e(month.toString());
    Fimber.e(monthList.toString());
  }

  @override
  void dispose() {
    streamSubscription.cancel();
    super.dispose();
  }
}
