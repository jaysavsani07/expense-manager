import 'package:expense_manager/core/date_time_util.dart';
import 'package:expense_manager/data/models/category_with_entry_list.dart';
import 'package:expense_manager/data/repository/entry_repository_imp.dart';
import 'package:expense_manager/ui/setting/setting_view_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:expense_manager/extension/datetime_extension.dart';

final categoryWithEntryListProvider =
    StreamProvider<List<CategoryWithEntryList>>((ref) {
  return ref.read(repositoryProvider).getAllEntryWithCategory(null, null);
});

final totalAmountProvider = StateProvider<double>((ref) {
  return ref
      .watch(dashboardViewModelProvider)
      .list
      .map((e) => e.total)
      .fold(0.0, (previousValue, element) => previousValue + element);
});

final todayAmountProvider = StateProvider<double>((ref) {
  return ref
      .watch(dashboardViewModelProvider)
      .list
      .expand((element) => element.entry)
      .where((e) => e.modifiedDate.isToday())
      .map((e) => e.amount)
      .fold(0.0, (previousValue, element) => previousValue + element);
});

final dashboardViewModelProvider =
    ChangeNotifierProvider<DashboardViewModel>((ref) {
  return DashboardViewModel(
      entryDataSourceImp: ref.read(repositoryProvider),
      cycleDate: int.parse(ref.watch(monthStartDateStateNotifier).date));
});

class DashboardViewModel with ChangeNotifier {
  EntryRepositoryImp entryDataSourceImp;

  List<CategoryWithEntryList> list = [];
  List<PieChartSectionData> graphList = [];
  int touchedIndex = -1;
  int cycleDate = 1;

  DashboardViewModel(
      {@required this.entryDataSourceImp, @required this.cycleDate}) {
    entryDataSourceImp
        .getAllEntryWithCategory(DateTimeUtil.getStartDateTime(cycleDate),
            DateTimeUtil.getEndDateTime(cycleDate))
        .listen((event) {
      list = event;
      graphList = getPieChartData(list);
      notifyListeners();
    });
  }

  void onGraphItemTeach(PieTouchResponse pieTouchResponse) {
    if (pieTouchResponse.touchInput is FlLongPressEnd ||
        pieTouchResponse.touchInput is FlPanEnd) {
      touchedIndex = -1;
    } else {
      touchedIndex = pieTouchResponse.touchedSectionIndex;
    }
    graphList = getPieChartData(list);
    notifyListeners();
  }

  LineChartData getLineChatData(CategoryWithEntryList categoryWithSum) {
    return LineChartData(
      lineTouchData: LineTouchData(enabled: false),
      gridData: FlGridData(show: false),
      titlesData: FlTitlesData(show: false),
      borderData: FlBorderData(show: false),
      minX: 0,
      maxX: categoryWithSum.numberOfEntry.toDouble(),
      minY: 0,
      maxY: categoryWithSum.maxAmount,
      lineBarsData: [
        LineChartBarData(
          spots: categoryWithSum.entry
              .asMap()
              .entries
              .map((e) => FlSpot(e.key.toDouble(), e.value.amount))
              .toList(),
          isCurved: true,
          colors: [categoryWithSum.category.iconColor],
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: FlDotData(show: false),
        ),
      ],
    );
  }

  List<PieChartSectionData> getPieChartData(List<CategoryWithEntryList> list) {
    return list.asMap().entries.map((e) {
      return PieChartSectionData(
        color: e.value.category.iconColor,
        value: e.value.total,
        title: '${100 * e.value.total ~/ 100}%',
        radius: e.key == touchedIndex ? 60 : 50,
        titleStyle: TextStyle(
            fontSize: e.key == touchedIndex ? 20 : 16,
            fontWeight: FontWeight.bold,
            color: const Color(0xffffffff)),
      );
    }).toList();
  }
}
