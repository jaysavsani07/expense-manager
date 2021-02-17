import 'package:expense_manager/data/models/category_with_entry_list.dart';
import 'package:expense_manager/ui/dashboard/dashboard_state.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:intl/intl.dart';
import 'package:velocity_x/velocity_x.dart';

final _currentCategory = ScopedProvider<CategoryWithEntryList>(null);

class CategoryListView extends ConsumerWidget {
  const CategoryListView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return ListView(shrinkWrap: true, children: [
      ...watch(categoryListProvider)
          .list
          .map((category) => ProviderScope(
              overrides: [_currentCategory.overrideWithValue(category)],
              child: const CategoryItem()))
          .toList()
    ]);
  }
}

class CategoryItem extends ConsumerWidget {
  const CategoryItem({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final category = watch(_currentCategory);
    print(category.maxX);
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Icon(
          category.category.icon,
          color: Vx.white,
        )
            .box
            .p12
            .height(80)
            .withDecoration(BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
              color: category.category.iconColor,
            ))
            .make(),
        category.category.name.text.bold.base.ellipsis
            .make()
            .pSymmetric(v: 4, h: 8)
            .expand(),
        LineChart(LineChartData(
          lineTouchData: LineTouchData(enabled: false),
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(show: false),
          borderData: FlBorderData(show: false),
          minX: 0,
          maxX: category.maxX,
          minY: 0,
          maxY: category.maxY,
          lineBarsData: [
            LineChartBarData(
              spots: category.toFlSpotList(),
              isCurved: false,
              colors: [category.category.iconColor],
              barWidth: 2,
              isStrokeCapRound: true,
              dotData: FlDotData(show: false),
            ),
          ],
        )).h(40).w(80),
        // const CategoryLineChart(),
        16.widthBox,
        "${NumberFormat.simpleCurrency().currencySymbol}${category.total.toString().replaceAll(RegExp(r"([.]*0)(?!.*\d)"), "")}"
            .text
            .lg
            .make()
            .w(50)
      ],
    ).card.zero.withRounded(value: 8).p8.make();
  }
}

// class CategoryLineChart extends ConsumerWidget {
//   const CategoryLineChart({Key key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context, ScopedReader watch) {
//     final category = watch(_currentCategory);
//     return  LineChart(vm.getLineChatData(e)).h(40).w(80);
//   }
// }
