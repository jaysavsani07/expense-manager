import 'package:expense_manager/core/app_localization.dart';
import 'package:expense_manager/core/constants.dart';
import 'package:expense_manager/ui/app/app_state.dart';
import 'package:expense_manager/ui/category_details/category_details_view_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:numeral/ext.dart';

class BarChartView extends ConsumerWidget {
  const BarChartView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = ref.watch(
        categoryDetailsModelProvider.select((value) => value.barChartList));
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        elevation: 1,
        child: Column(
          children: [
            SizedBox(
              height: 160,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: list.when(
                    data: (value) => BarChart(
                          BarChartData(
                            borderData: FlBorderData(show: false),
                            gridData: FlGridData(show: false),
                            alignment: BarChartAlignment.spaceEvenly,
                            maxY: value.item1,
                            barTouchData: BarTouchData(
                                touchTooltipData: BarTouchTooltipData(
                              getTooltipItem: (group, groupIndex, rod, rodIndex) =>
                                  null,
                            )),
                            titlesData: FlTitlesData(
                              show: true,
                              topTitles: SideTitles(showTitles: false),
                              rightTitles: SideTitles(showTitles: false),
                              bottomTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 8,
                                margin: 8,
                                getTextStyles: (context, value) => const TextStyle(
                                  color: Color(0xff7589a2),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                                getTitles: (double value) =>
                                    AppLocalization.of(context).getTranslatedVal(
                                        AppConstants.monthList[value]),
                              ),
                              leftTitles: SideTitles(
                                showTitles: true,
                                margin: 8,
                                reservedSize: 40,
                                interval: null,
                                checkToShowTitle: (minValue, maxValue, sideTitles,
                                    appliedInterval, value) {
                                  if (value == minValue)
                                    return true;
                                  else if (value == maxValue)
                                    return true;
                                  else
                                    return false;
                                },
                                getTextStyles: (context, value) => const TextStyle(
                                    color: Color(0xff7589a2),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12),
                                getTitles: (data) {
                                  return NumberFormat.compactCurrency(
                                    decimalDigits: 0,
                                              symbol:NumberFormat.simpleCurrency(locale:  ref
                                                  .watch(appStateNotifier)
                                                  .currency.item1).currencySymbol
                                  ).format(data);
                                },
                              ),
                            ),
                            barGroups: value.item2,
                          ),
                        ),
                    error: (e, str) => Text(str.toString()),
                    loading: () => Center(child: CircularProgressIndicator())),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.circle,
                    size: 10,
                    color:  Colors.green,
                  ),
                  SizedBox(width: 4),
                  Text(
                    AppLocalization.of(context).getTranslatedVal("income"),
                    style: Theme.of(context)
                        .textTheme
                        .caption,
                  ),
                  SizedBox(width: 8),
                  Icon(
                    Icons.circle,
                    size: 10,
                    color:  Colors.red,
                  ),
                  SizedBox(width: 4),
                  Text(
                    AppLocalization.of(context).getTranslatedVal("expense"),
                    style: Theme.of(context)
                        .textTheme
                        .caption,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
