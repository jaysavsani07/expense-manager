import 'package:dotted_border/dotted_border.dart';
import 'package:expense_manager/core/constants.dart';
import 'package:expense_manager/core/routes.dart';
import 'package:expense_manager/core/app_localization.dart';
import 'package:expense_manager/ui/app/app_state.dart';
import 'package:expense_manager/ui/dashboard/category_list_view.dart';
import 'package:expense_manager/ui/dashboard/category_pie_chart_view.dart';
import 'package:expense_manager/ui/dashboard/dashboard_state.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class Dashboard extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 24),
          child: DottedBorder(
            color: Theme.of(context).textTheme.subtitle2.color,
            dashPattern: [5, 5],
            radius: Radius.circular(12),
            borderType: BorderType.RRect,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Text(
                  AppLocalization.of(context).getTranslatedVal("dashboard")),
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
    final todayAmount = ref.watch(todayAmountProvider);
    String currency = ref.watch(appStateNotifier).currency.item1;
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 14),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                        "${NumberFormat.simpleCurrency(locale: currency, decimalDigits: 0).format(todayAmount)}",
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2
                            .copyWith(fontSize: 28),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: SizedBox(
                  height: 36,
                  child: LineChart(ref.watch(todayLineChartProvider)),
                ),
              )
            ],
          )),
    );
  }
}
