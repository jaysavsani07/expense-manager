import 'package:dotted_border/dotted_border.dart';
import 'package:expense_manager/core/app_localization.dart';
import 'package:expense_manager/core/constants.dart';
import 'package:expense_manager/ui/app/app_state.dart';
import 'package:expense_manager/ui/category_details/category_details_view_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:numeral/ext.dart';

class CategoryDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios_rounded),
          ),
          title: DottedBorder(
            color: Theme.of(context).appBarTheme.textTheme.headline6.color,
            dashPattern: [5, 5],
            radius: Radius.circular(12),
            borderType: BorderType.RRect,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Text(AppLocalization.of(context)
                  .getTranslatedVal("total_expense")),
            ),
          ),
        ),
        body: Column(
          children: [
            const BarChartView(),
            SizedBox(height: 30),
            const CategoryFilterView(),
            YearListView(),
            // MonthList(),
            SizedBox(height: 20),
            Expanded(child: const CategoryListView())
          ],
        ));
  }
}

class BarChartView extends ConsumerWidget {
  const BarChartView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = ref.watch(columnChartDataProvider);
    final maxAmount = ref.watch(maxAmountStateProvider.state).state;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: AspectRatio(
        aspectRatio: 1.7,
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          elevation: 1,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: list.when(
                data: (value) => BarChart(
                      BarChartData(
                        barTouchData: BarTouchData(
                            touchTooltipData: BarTouchTooltipData(
                          getTooltipItem: (group, groupIndex, rod, rodIndex) =>
                              null,
                        )),
                        titlesData: FlTitlesData(
                          show: true,
                          bottomTitles: SideTitles(
                            showTitles: true,
                            getTextStyles: (context, value) => const TextStyle(
                              color: Color(0xff7589a2),
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                            reservedSize: 8,
                            margin: 8,
                            getTitles: (double value) =>
                                AppLocalization.of(context).getTranslatedVal(
                                    AppConstants.monthList[value]),
                          ),
                          leftTitles: SideTitles(
                            showTitles: true,
                            getTextStyles: (context, value) => const TextStyle(
                                color: Color(0xff7589a2),
                                fontWeight: FontWeight.bold,
                                fontSize: 12),
                            margin: 8,
                            reservedSize: 28,
                            interval: 1,
                            getTitles: (value) {
                              if (value == 0) {
                                return 0.numeral();
                              } else if (value == maxAmount) {
                                return maxAmount.numeral();
                              } else {
                                return '';
                              }
                            },
                          ),
                          topTitles: SideTitles(showTitles: false),
                          rightTitles: SideTitles(showTitles: false),
                        ),
                        borderData: FlBorderData(show: false),
                        barGroups: [
                          ...value
                              .map((e) => BarChartGroupData(
                                    x: e.item1,
                                    barRods: [
                                      BarChartRodData(
                                        y: e.item3
                                                ?.map((e) => e.entry.amount)
                                                ?.fold(
                                                    0,
                                                    (previousValue, element) =>
                                                        previousValue +
                                                        element) ??
                                            0,
                                        colors: [
                                          Colors.green,
                                          Colors.greenAccent
                                        ],
                                      ),
                                      BarChartRodData(
                                        y: e.item2
                                                ?.map((e) => e.entry.amount)
                                                ?.fold(
                                                    0,
                                                    (previousValue, element) =>
                                                        previousValue +
                                                        element) ??
                                            0,
                                        colors: [Colors.red, Colors.redAccent],
                                      )
                                    ],
                                    showingTooltipIndicators: [0],
                                  ))
                              .toList()
                        ],
                        gridData: FlGridData(show: false),
                        alignment: BarChartAlignment.spaceEvenly,
                        maxY: maxAmount,
                      ),
                    ),
                error: (e, str) => Text(str.toString()),
                loading: () => CircularProgressIndicator()),
          ),
        ),
      ),
    );
  }
}

class CategoryFilterView extends ConsumerWidget {
  const CategoryFilterView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final monthList = ref.watch(monthListProvider);
    return monthList.when(
        data: (list) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: list
                    .map((e) => Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 4),
                          child: InkWell(
                            onTap: () {
                              ref.read(selectedMonthProvider.state).state = e;
                            },
                            borderRadius: BorderRadius.circular(15),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 9, horizontal: 14),
                              decoration: BoxDecoration(
                                color: ref
                                            .watch(selectedMonthProvider.state)
                                            .state ==
                                        e
                                    ? Color(0xff2196F3)
                                    : Theme.of(context).dividerColor,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Text(
                                AppLocalization.of(context).getTranslatedVal(
                                    AppConstants.monthList[e]),
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2
                                    .copyWith(
                                      fontSize: 12,
                                      color: ref
                                                  .watch(selectedMonthProvider
                                                      .state)
                                                  .state ==
                                              e
                                          ? Colors.white
                                          : Color(0xff2196F3),
                                    ),
                              ),
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ),
        loading: () => SizedBox(),
        error: (e, str) => SizedBox());
  }
}

class CategoryListView extends ConsumerWidget {
  const CategoryListView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = ref.watch(categoryListProvider);
    var currency = ref.watch(appStateNotifier).currency.item1;
    return list.when(
        data: (value) => ListView(
              children: value
                  .map((e) => Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 24),
                        child: Row(
                          children: [
                            Icon(
                              e.category.icon,
                              color: e.category.iconColor,
                              size: 20,
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        e.category.name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2
                                            .copyWith(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        "${NumberFormat.simpleCurrency(locale: currency, decimalDigits: 0).format(e.total)}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2
                                            .copyWith(
                                                fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8),
                                  LinearPercentIndicator(
                                    lineHeight: 6,
                                    percent: e.total / value.first.total,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 4),
                                    backgroundColor:
                                        Theme.of(context).dividerColor,
                                    progressColor: e.category.iconColor,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ))
                  .toList(),
            ),
        error: (e, str) => Text(str.toString()),
        loading: () => Center(child: CircularProgressIndicator()));
  }
}

class YearListView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(yearListStreamProvider);

    return SizedBox(
      height: 48,
      child: vm.when(
        data: (yearList) => ListView(
          shrinkWrap: false,
          padding: EdgeInsets.only(left: 24),
          scrollDirection: Axis.horizontal,
          children: yearList
              .map(
                (e) => Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                  child: InkWell(
                    onTap: () {
                      ref.read(selectedYearProvider.state).state = e;
                    },
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 9, horizontal: 14),
                      decoration: BoxDecoration(
                        color: ref.watch(selectedYearProvider.state).state == e
                            ? Color(0xff2196F3)
                            : Theme.of(context).dividerColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        e.toString(),
                        style: Theme.of(context).textTheme.subtitle2.copyWith(
                              fontSize: 12,
                              color:
                                  ref.watch(selectedYearProvider.state).state ==
                                          e
                                      ? Colors.white
                                      : Color(0xff2196F3),
                            ),
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
        loading: () => CircularProgressIndicator(),
        error: (e, str) => Center(child: Text(e.toString())),
      ),
    );
  }
}
