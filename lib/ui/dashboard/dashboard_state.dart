import 'package:expense_manager/data/models/category_with_sum.dart';
import 'package:expense_manager/data/repository/entry_repository_imp.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dashboardViewModelProvider = ChangeNotifierProvider<DashboardViewModel>(
  (ref) => DashboardViewModel(entryDataSourceImp: ref.read(repositoryProvider)),
);

class DashboardViewModel with ChangeNotifier {
  EntryRepositoryImp entryDataSourceImp;

  List<CategoryWithSum> list = [];
  List<PieChartSectionData> graphList = [];
  int touchedIndex = -1;
  double total=0;
  double today=0;

  DashboardViewModel({@required this.entryDataSourceImp}) {
    entryDataSourceImp.getAllEntryWithCategory().listen((event) {
      list = event;
      total=list.map((e) => e.total).fold(0.0, (previousValue, element) => previousValue + element);
      today=list.first.total;
      graphList = showingSections(list);
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
    graphList = showingSections(list);
    notifyListeners();
  }

  List<PieChartSectionData> showingSections(List<CategoryWithSum> list) {
    return list.asMap().entries.map((e) {
      return PieChartSectionData(
        color: e.value.category.iconColor,
        value: e.value.total,
        title: '${100*e.value.total~/total}%',
        radius: e.key == touchedIndex ? 60 : 50,
        titleStyle: TextStyle(
            fontSize: e.key == touchedIndex ? 20 : 16,
            fontWeight: FontWeight.bold,
            color: const Color(0xffffffff)),
      );
    }).toList();
  }
}
