import 'package:dotted_border/dotted_border.dart';
import 'package:expense_manager/core/routes.dart';
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
                color: Colors.blue,
                dashPattern: [5, 5],
                radius: Radius.circular(12),
                borderType: BorderType.RRect,
                child: "Dashboard"
                    .text
                    .size(16)
                    .medium
                    .color(Colors.blue)
                    .make()
                    .pSymmetric(h: 8, v: 4))
            .pOnly(left: 24),
        actions: [
          Icon(
            Icons.settings,
            size: 24,
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
            "Hello, Jay".text.size(34).make().pOnly(left: 24),
            20.heightBox,
            const TodayAmount(),
            30.heightBox,
            "Total Expanse".text.size(18).bold.make().pOnly(left: 24),
            20.heightBox,
            const CategoryPieChartView(),
            30.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                "Quick Add".text.size(18).bold.make(),
                "Manage Category"
                    .text
                    .size(16)
                    .color(Colors.blue)
                    .bold
                    .make()
                    .onInkTap(() {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.categoryList,
                  );
                }),
              ],
            ).pSymmetric(h: 24),
            20.heightBox,
            const CategoryListView()
          ],
        ),
      ),
    );
  }
}

class TotalAmount extends ConsumerWidget {
  const TotalAmount({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final totalAmount = watch(totalAmountProvider);
    return "${NumberFormat.simpleCurrency().currencySymbol}${totalAmount.toString().replaceAll(RegExp(r"([.]*0)(?!.*\d)"), "")}"
        .text
        .bold
        .xl5
        .make()
        .pSymmetric(h: 16);
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
            "TODAY'S EXPANSE".text.size(12).bold.white.make(),
            6.heightBox,
            "${NumberFormat.simpleCurrency().currencySymbol} ${todayAmount.toString().replaceAll(RegExp(r"([.]*0)(?!.*\d)"), "")}"
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
        .color(Colors.blue)
        .elevation(1)
        .make()
        .pSymmetric(h: 24);
  }
}
