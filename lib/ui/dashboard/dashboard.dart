import 'package:dotted_border/dotted_border.dart';
import 'package:expense_manager/core/constants.dart';
import 'package:expense_manager/core/routes.dart';
import 'package:expense_manager/core/app_localization.dart';
import 'package:expense_manager/ui/app/app_state.dart';
import 'package:expense_manager/ui/dashboard/category_list_view.dart';
import 'package:expense_manager/ui/dashboard/category_pie_chart_view.dart';
import 'package:expense_manager/ui/dashboard/dashboard_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:expense_manager/core/color_scheme.dart';

class Dashboard extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 24),
          child: DottedBorder(
            color: Theme.of(context).appBarTheme.titleTextStyle.color,
            dashPattern: [5, 5],
            radius: Radius.circular(12),
            borderType: BorderType.RRect,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Text(
                AppLocalization.of(context).getTranslatedVal("dashboard"),
                style: Theme.of(context).appBarTheme.titleTextStyle,
              ),
            ),
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.setting);
            },
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Icon(
                Icons.settings,
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  Text(
                    AppLocalization.of(context).getTranslatedVal("hello"),
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2
                        .copyWith(fontSize: 34),
                  ),
                  const UserName()
                ],
              ),
            ),
            SizedBox(height: 20),
            const TodayAmount(),
            const CategoryChartView(),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalization.of(context).getTranslatedVal("quick_add"),
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2
                        .copyWith(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.categoryList,
                        arguments: EntryType.expense,
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        AppLocalization.of(context)
                            .getTranslatedVal("manage_category"),
                        style: Theme.of(context).textTheme.subtitle2.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff2196F3)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            const CategoryListView()
          ],
        ),
      ),
    );
  }
}

class UserName extends ConsumerWidget {
  const UserName({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appState = ref.watch(appStateNotifier);
    return Text(
      appState.userName,
      style: Theme.of(context)
          .textTheme
          .subtitle2
          .copyWith(fontSize: 34, fontWeight: FontWeight.w300),
    );
  }
}

class TodayAmount extends ConsumerWidget {
  const TodayAmount({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todayExpense = ref.watch(todayExpenseProvider);
    String currency = ref.watch(appStateNotifier).currency.item1;
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  children: [
                    SizedBox(height: 12),
                    Text(
                      AppLocalization.of(context)
                          .getTranslatedVal("today_expanse"),
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2
                          .copyWith(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 6),
                    FittedBox(
                      child: Text(
                        "${NumberFormat.simpleCurrency(locale: currency, decimalDigits: 0).format(todayExpense)}",
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2
                            .copyWith(fontSize: 28),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: SizedBox(height:80, child: RadialTextPointer()),
              ),
            ],
          )),
    );
  }
}

class RadialTextPointer extends ConsumerStatefulWidget {
  /// Creates the gauge text pointer sample
  const RadialTextPointer({Key key}) : super(key: key);

  @override
  _RadialTextPointerState createState() => _RadialTextPointerState();
}

class _RadialTextPointerState extends ConsumerState<RadialTextPointer> {
  _RadialTextPointerState();

  @override
  Widget build(BuildContext context) {
    return _buildRadialTextPointer();
  }

  /// Returns the text pointer gauge
  Widget _buildRadialTextPointer() {
    final totalIncomeExpenseRatio = ref.watch(totalIncomeExpenseRatioProvider);
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom : 8.0),
          child: SfRadialGauge(
            axes: <RadialAxis>[
              RadialAxis(
                showAxisLine: false,
                showLabels: false,
                showTicks: false,
                startAngle: 180,
                endAngle: 360,
                minimum: 0,
                centerY: 0.8,
                maximum: 120,
                canScaleToFit: false,
                radiusFactor: 1.6,
                pointers: <GaugePointer>[
                  NeedlePointer(
                      needleStartWidth: 0.5,
                      lengthUnit: GaugeSizeUnit.factor,
                      needleEndWidth: 3,
                      needleLength: 0.7,
                      needleColor: Theme.of(context).colorScheme.crossColor,
                      value: totalIncomeExpenseRatio * 120,
                      knobStyle: KnobStyle(
                          knobRadius: 0.07,
                          color: Theme.of(context).colorScheme.crossColor)),
                ],
                ranges: <GaugeRange>[
                  GaugeRange(
                      startValue: 0,
                      endValue: 40,
                      startWidth: 0.45,
                      sizeUnit: GaugeSizeUnit.factor,
                      endWidth: 0.45,
                      color: const Color(0xCC8BE724)),
                  GaugeRange(
                      startValue: 40.5,
                      endValue: 80,
                      startWidth: 0.45,
                      sizeUnit: GaugeSizeUnit.factor,
                      endWidth: 0.45,
                      color: const Color(0xCCFFBA00)),
                  GaugeRange(
                      startValue: 80.5,
                      endValue: 120,
                      sizeUnit: GaugeSizeUnit.factor,
                      startWidth: 0.45,
                      endWidth: 0.45,
                      color: const Color(0xCCFF4100)),
                ],
                annotations: <GaugeAnnotation>[
                 /*GaugeAnnotation(
                    angle: 172,
                    positionFactor: 0.9,
                    widget: Container(
                      child: Text(
                        AppLocalization.of(context).getTranslatedVal("expense"),
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2
                            .copyWith(fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  GaugeAnnotation(
                    angle: 8,
                    positionFactor: 0.9,
                    axisValue: 0,
                    widget: Container(
                      child: Text(
                        AppLocalization.of(context).getTranslatedVal("income"),
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2
                            .copyWith(fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                    ),
                  )*/
                ],
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Text(
            AppLocalization.of(context).getTranslatedVal("expense_meter"),
            style: Theme.of(context)
                .textTheme
                .subtitle2
                .copyWith(fontSize: 10, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}

// LinearPercentIndicator(
// lineHeight: 12,
// percent: totalIncomeExpenseRatio,
// padding: EdgeInsets.symmetric(horizontal: 4),
// backgroundColor: Theme.of(context).dividerColor,
// progressColor: Colors.red,
// center: Text(
// "${(totalIncomeExpenseRatio * 100).toStringAsFixed(0)}%",
// style: Theme.of(context)
// .textTheme
//     .subtitle2
//     .copyWith(fontSize: 10, fontWeight: FontWeight.bold),
// ),
// ),

// Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// FittedBox(
// child: Text(
// "${NumberFormat.simpleCurrency(locale: currency, decimalDigits: 0).format(totalExpense)}",
// style: Theme.of(context)
// .textTheme
//     .subtitle2
//     .copyWith(fontSize: 16),
// ),
// ),
// FittedBox(
// child: Text(
// "${NumberFormat.simpleCurrency(locale: currency, decimalDigits: 0).format(totalIncome)}",
// style: Theme.of(context)
// .textTheme
//     .subtitle2
//     .copyWith(fontSize: 16),
// ),
// ),
// ],
// ),
