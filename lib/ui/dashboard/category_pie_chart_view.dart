import 'package:expense_manager/ui/dashboard/dashboard_state.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:velocity_x/velocity_x.dart';

class CategoryPieChartView extends ConsumerWidget {
  const CategoryPieChartView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final vm = watch(categoryPieChartProvider);
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: vm.isEmpty
              ? SizedBox()
              : PieChart(
                  PieChartData(
                      pieTouchData:
                          PieTouchData(touchCallback: (pieTouchResponse) {
                        context.read(categoryPieChartTeachItemProvider).state =
                            (pieTouchResponse.touchInput is FlLongPressEnd ||
                                    pieTouchResponse.touchInput is FlPanEnd)
                                ? -1
                                : pieTouchResponse.touchedSectionIndex;
                      }),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      sectionsSpace: 8,
                      centerSpaceRadius: 80,
                      sections: vm),
                ),
        ),
        const CategoryPieChatListView()
      ],
    );
  }
}

class CategoryPieChatListView extends ConsumerWidget {
  const CategoryPieChatListView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final vm = watch(categoryPieChartListProvider);
    return GridView(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: 5),
      scrollDirection: Axis.vertical,
      children: vm
          .map((list) => Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.circle,
                    size: 16,
                    color: list.iconColor,
                  ),
                  8.widthBox,
                  list.name.text.make()
                ],
              ).box.height(12).make())
          .toList(),
    ).pSymmetric(h: 16).expand();
  }
}
