import 'package:dotted_border/dotted_border.dart';
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
import 'package:velocity_x/velocity_x.dart';

class Dashboard extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Scaffold(
      appBar: AppBar(
        title: DottedBorder(
                color: Theme.of(context).appBarTheme.textTheme.headline6.color,
                dashPattern: [5, 5],
                radius: Radius.circular(12),
                borderType: BorderType.RRect,
                child: AppLocalization.of(context)
                    .getTranslatedVal("dashboard")
                    .text
                    .make()
                    .pSymmetric(h: 8, v: 4))
            .pOnly(left: 24),
        actions: [
          Icon(
            Icons.settings,
          ).p24().onInkTap(() {
            Navigator.pushNamed(context, AppRoutes.setting);
          })
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            10.heightBox,
            Row(
              children: [
                AppLocalization.of(context)
                    .getTranslatedVal("hello")
                    .text
                    .size(34)
                    .make(),
                const UserName()
              ],
            ).pSymmetric(h: 24),
            20.heightBox,
            const TodayAmount(),
            const CategoryChartView(),
            20.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppLocalization.of(context)
                    .getTranslatedVal("quick_add")
                    .text
                    .size(18)
                    .bold
                    .make(),
                AppLocalization.of(context)
                    .getTranslatedVal("manage_category")
                    .text
                    .size(16)
                    .color(Color(0xff2196F3))
                    .bold
                    .make()
                    .p(10)
                    .onInkTap(() {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.categoryList,
                  );
                }),
              ],
            ).pSymmetric(h: 24),
            10.heightBox,
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
  Widget build(BuildContext context, ScopedReader watch) {
    final appState = watch(appStateNotifier);
    // int x =int.parse(appState.userName);
    return appState.userName.text.size(34).light.make();
  }
}

class TodayAmount extends ConsumerWidget {
  const TodayAmount({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final todayAmount = watch(todayAmountProvider);
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppLocalization.of(context)
                .getTranslatedVal("today_expanse")
                .text
                .size(12)
                .bold
                .white
                .make(),
            6.heightBox,
            "${NumberFormat.simpleCurrency(decimalDigits: 0).format(todayAmount)}"
                .text
                .size(28)
                .medium
                .white
                .make()
          ],
        ).expand(),
        LineChart(watch(todayLineChartProvider)).h(36).expand()
      ],
    )
        .pSymmetric(v: 24, h: 14)
        .card
        .withRounded(value: 8)
        .color(Theme.of(context).primaryColor)
        .elevation(1)
        .make()
        .pSymmetric(h: 24);
  }
}
