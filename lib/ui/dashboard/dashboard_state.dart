import 'package:expense_manager/core/date_time_util.dart';
import 'package:expense_manager/data/models/category.dart' as cat;
import 'package:expense_manager/data/models/category_with_entry_list.dart';
import 'package:expense_manager/data/repository/entry_repository_imp.dart';
import 'package:expense_manager/ui/setting/setting_view_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:expense_manager/extension/datetime_extension.dart';

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

final categoryPieChartTeachItemProvider = StateProvider<int>((_) => -1);

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
