import 'package:expense_manager/core/date_time_util.dart';
import 'package:expense_manager/data/models/category.dart' as cat;
import 'package:expense_manager/data/models/category_with_entry_list.dart';
import 'package:expense_manager/data/repository/entry_repository_imp.dart';
import 'package:expense_manager/ui/setting/setting_view_model.dart';
import 'package:fimber/fimber.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:expense_manager/extension/datetime_extension.dart';
import 'package:collection/collection.dart';
import 'package:tuple/tuple.dart';

final totalAmountProvider = Provider<double>((ref) {
  return ref
      .watch(dashboardProvider)
      .list
      .map((e) => e.total)
      .fold(0.0, (previousValue, element) => previousValue + element);
});

final todayAmountProvider = Provider<double>((ref) {
  return ref
      .watch(dashboardProvider)
      .list
      .expand((element) => element.entry)
      .where((e) => e.modifiedDate.isToday())
      .map((e) => e.amount)
      .fold(0.0, (previousValue, element) => previousValue + element);
});

final todayLineChartProvider = Provider<LineChartData>((ref) {
  Map<int, double> list1 = {};
  for (int i = 0; i < DateTime.now().hour; i++) {
    list1[i] = 0;
  }
  List<Tuple2<int, double>> list = ref
      .watch(dashboardProvider)
      .list
      .expand((element) => element.entry)
      .where((e) => e.modifiedDate.isToday())
      .map((e) => Tuple2(e.modifiedDate.hour, e.amount))
      .toList();

  groupBy(list, (Tuple2<int, double> e) {
    return e.item1;
  })
      .map((key, value) => MapEntry(
          key,
          value.fold(
              0.0, (previousValue, element) => previousValue + element.item2)))
      .forEach((key, value) {
    list1[key] = value;
  });

  return LineChartData(
    lineTouchData: LineTouchData(enabled: false),
    gridData: FlGridData(show: false),
    titlesData: FlTitlesData(show: false),
    borderData: FlBorderData(show: false),
    minX: 0,
    maxX: 24,
    minY: 0,
    maxY: list1.entries.map((e) => e.value).fold(
        0.0,
        (previousValue, element) =>
            previousValue > element ? previousValue : element),
    lineBarsData: [
      LineChartBarData(
        spots: [
          ...list1.entries
              .map((e) => FlSpot(e.key.toDouble(), e.value))
              .toList(),
        ],
        isCurved: true,
        colors: [Colors.white],
        barWidth: 1,
        isStrokeCapRound: true,
        dotData: FlDotData(show: false),
      ),
    ],
  );
});

final categoryPieChartTeachItemProvider = StateProvider<int>((_) => -1);

final categoryPieChartVisibilityProvider =
    StateProvider<bool>((ref) => ref.watch(dashboardProvider).list.isEmpty);

final categoryPieChartProvider = Provider<List<PieChartSectionData>>((ref) {
  int touchedIndex = ref.watch(categoryPieChartTeachItemProvider).state;
  double totalAmount = ref.read(totalAmountProvider);
  return ref.watch(dashboardProvider).list.asMap().entries.map((e) {
    return PieChartSectionData(
      color: e.value.category.iconColor,
      value: e.value.total,
      title: '${100 * e.value.total ~/ totalAmount}%',
      radius: e.key == touchedIndex ? 60 : 50,
      titleStyle: TextStyle(
          fontSize: e.key == touchedIndex ? 20 : 16,
          fontWeight: FontWeight.bold,
          color: const Color(0xffffffff)),
    );
  }).toList();
});

final categoryPieChartListProvider = Provider<List<cat.Category>>((ref) {
  return ref.watch(dashboardProvider).list.map((e) => e.category).toList();
});

final dashboardProvider = ChangeNotifierProvider<DashboardViewModel>((ref) {
  return DashboardViewModel(
      entryDataSourceImp: ref.read(repositoryProvider),
      cycleDate: int.parse(ref.watch(monthStartDateStateNotifier).date));
});

class DashboardViewModel with ChangeNotifier {
  EntryRepositoryImp entryDataSourceImp;
  List<CategoryWithEntryList> list = [];
  int cycleDate = 1;

  DashboardViewModel(
      {@required this.entryDataSourceImp, @required this.cycleDate}) {
    entryDataSourceImp
        .getAllEntryWithCategory(DateTimeUtil.getStartDateTime(cycleDate),
            DateTimeUtil.getEndDateTime(cycleDate))
        .listen((event) {
      list = event;
      notifyListeners();
    });
  }
}

final categoryListProvider = ChangeNotifierProvider<CategoryModel>((ref) {
  return CategoryModel(entryDataSourceImp: ref.read(repositoryProvider));
});

class CategoryModel with ChangeNotifier {
  EntryRepositoryImp entryDataSourceImp;
  List<cat.Category> list = [];

  CategoryModel({@required this.entryDataSourceImp}) {
    entryDataSourceImp.getAllCategory().listen((event) {
      list = event;
      notifyListeners();
    });
  }
}
