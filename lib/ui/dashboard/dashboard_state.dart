import 'package:expense_manager/core/constants.dart';
import 'package:expense_manager/core/date_time_util.dart';
import 'package:expense_manager/data/models/category.dart' as cat;
import 'package:expense_manager/data/models/category_with_entry_list.dart';
import 'package:expense_manager/data/repository/entry_repository_imp.dart';
import 'package:expense_manager/ui/setting/setting_view_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final totalExpenseProvider = StateProvider((ref) {
  return ref
      .watch(totalExpenseStreamProvider)
      .whenOrNull(data: (value) => value, loading: () => 0);
});

final totalExpenseStreamProvider = StreamProvider((ref) {
  var cycleDate = int.parse(ref.watch(monthStartDateStateNotifier).date);
  return ref.read(repositoryProvider).getExpanseSumByDateRange(
      DateTimeUtil.getStartDateTime(cycleDate),
      DateTimeUtil.getEndDateTime(cycleDate));
});

final totalIncomeProvider = StateProvider((ref) {
  return ref
      .watch(totalIncomeStreamProvider)
      .whenOrNull(data: (value) => value, loading: () => 0);
});

final totalIncomeStreamProvider = StreamProvider((ref) {
  var cycleDate = int.parse(ref.watch(monthStartDateStateNotifier).date);
  return ref.read(repositoryProvider).getIncomeSumByDateRange(
      DateTimeUtil.getStartDateTime(cycleDate),
      DateTimeUtil.getEndDateTime(cycleDate));
});

final todayExpenseProvider = StateProvider((ref) {
  return ref
      .watch(todayExpenseStreamProvider)
      .whenOrNull(data: (value) => value, loading: () => 0);
});

final todayExpenseStreamProvider = StreamProvider((ref) {
  return ref.read(repositoryProvider).getTodayExpense();
});

final totalIncomeExpenseRatioProvider = StateProvider<double>((ref) {
  var expense = ref.watch(totalExpenseProvider);
  var income = ref.watch(totalIncomeProvider);
  if (income == 0 && expense == 0) {
    return 0.0;
  } else if (income == 0) {
    return 1.0;
  } else if (expense == 0) {
    return 0.0;
  } else {
    return expense! / income!;
  }
});

final categoryPieChartTeachItemProvider = StateProvider<int>((_) => -1);

final categoryPieChartVisibilityProvider =
    StateProvider<bool>((ref) => ref.watch(dashboardProvider).list.isEmpty);

final categoryPieChartProvider = Provider<List<PieChartSectionData>>((ref) {
  int touchedIndex =
      ref.watch(categoryPieChartTeachItemProvider.notifier).state;
  double? totalAmount = ref.read(totalExpenseStreamProvider).value;
  return ref.watch(dashboardProvider).list.asMap().entries.map((e) {
    return PieChartSectionData(
      color: e.value.category.iconColor,
      value: e.value.total,
      title: '${100 * e.value.total ~/ totalAmount!}%',
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

  DashboardViewModel({
    required this.entryDataSourceImp,
    required this.cycleDate,
  }) {
    entryDataSourceImp
        .getAllEntryWithCategory(DateTimeUtil.getStartDateTime(cycleDate),
            DateTimeUtil.getEndDateTime(cycleDate))
        .listen((event) {
      list = event
        ..sort((a, b) {
          if (a.total > b.total) {
            return -1;
          } else if (a.total < b.total) {
            return 1;
          } else {
            return 0;
          }
        });
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

  CategoryModel({required this.entryDataSourceImp}) {
    entryDataSourceImp.getAllCategory(EntryType.all).listen((event) {
      list = event;
      notifyListeners();
    });
  }
}
