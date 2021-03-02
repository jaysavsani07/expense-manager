import 'package:dotted_border/dotted_border.dart';
import 'package:expense_manager/data/language/app_localization.dart';
import 'package:expense_manager/core/routes.dart';
import 'package:expense_manager/ui/dashboard/category_list_view.dart';
import 'package:expense_manager/ui/dashboard/category_pie_chart_view.dart';
import 'package:expense_manager/ui/dashboard/dashboard_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:velocity_x/velocity_x.dart';

class Dashboard extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return SafeArea(
      top: true,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DottedBorder(
                          color: Colors.blue,
                          dashPattern: [5, 5],
                          radius: Radius.circular(12),
                          borderType: BorderType.RRect,
                          child: "Dashboard"
                              .text
                              .lg
                              .bold
                              .color(Colors.blue)
                              .make()
                              .pSymmetric(h: 8, v: 4))
                      .pOnly(left: 24),
                  Icon(
                    Icons.settings,
                    size: 20,
                  ).p24().onInkTap(() {
                    Navigator.pushNamed(context, AppRoutes.setting);
                  })
                ],
              ),
              24.heightBox,
              "Hello, Jay".text.xl4.make().pOnly(left: 24),
              20.heightBox,
              const TodayAmount(),
              30.heightBox,
              "Total Expanse".text.xl.bold.make().pOnly(left: 24),
              20.heightBox,
              const CategoryPieChartView(),
              30.heightBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  "Quick Add".text.xl.bold.make(),
                  "Manage Category".text.lg.color(Colors.blue).bold.make(),
                ],
              ).pSymmetric(h: 24),
              20.heightBox,
              const CategoryListView()
            ],
          ),
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
            "TODAY'S EXPANSE".text.sm.semiBold.white.make(),
            16.heightBox,
            "${NumberFormat.simpleCurrency().currencySymbol} ${todayAmount.toString().replaceAll(RegExp(r"([.]*0)(?!.*\d)"), "")}"
                .text
                .xl2
                .bold
                .white
                .make()
          ],
        )
      ],
    )
        .pSymmetric(v: 24, h: 16)
        .card
        .roundedSM
        .color(Colors.blue)
        .elevation(1)
        .make()
        .pSymmetric(h: 24);
  }
}
