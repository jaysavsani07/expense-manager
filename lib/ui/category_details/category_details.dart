import 'package:dotted_border/dotted_border.dart';
import 'package:expense_manager/core/constants.dart';
import 'package:expense_manager/ui/category_details/category_details_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:velocity_x/velocity_x.dart';

class CategoryDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: DottedBorder(
                  color: Colors.blue,
                  dashPattern: [5, 5],
                  radius: Radius.circular(12),
                  borderType: BorderType.RRect,
                  child: "Total Expense"
                      .text
                      .lg
                      .bold
                      .color(Colors.blue)
                      .make()
                      .pSymmetric(h: 8, v: 4))
              .pOnly(left: 24),
        ),
        body: Column(
          children: [
            const TotalAmount(),
            30.heightBox,
            const CategoryFilterView(),
            20.heightBox,
            const CategoryList1()
          ],
        ));
  }
}

class TotalAmount extends ConsumerWidget {
  const TotalAmount({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final totalAmount = watch(categoryDetailsTotalAmountProvider);
    return "${NumberFormat.simpleCurrency(decimalDigits: 0).format(totalAmount)}"
        .text
        .xl3
        .bold
        .make()
        .pSymmetric(v: 20)
        .centered()
        .card
        .roundedSM
        .elevation(1)
        .make()
        .pSymmetric(h: 24);
  }
}

class CategoryFilterView extends ConsumerWidget {
  const CategoryFilterView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final filterType = watch(categoryDetailsFilterProvider).state;
    return Row(
      children: [
        "Last Month"
            .text
            .color(filterType == filter.lastMonth ? Colors.white : Colors.blue)
            .sm
            .make()
            .centered()
            .pSymmetric(v: 10)
            .box
            .color(filterType == filter.lastMonth
                ? Colors.blue
                : Color(0xffEEEEEE))
            .rounded
            .margin(EdgeInsets.symmetric(horizontal: 10))
            .make()
            .onInkTap(() {
          context.read(categoryDetailsFilterProvider).state = filter.lastMonth;
        }).expand(),
        "Last Year"
            .text
            .color(filterType == filter.lastYear ? Colors.white : Colors.blue)
            .sm
            .make()
            .centered()
            .pSymmetric(v: 10)
            .box
            .color(
                filterType == filter.lastYear ? Colors.blue : Color(0xffEEEEEE))
            .rounded
            .margin(EdgeInsets.symmetric(horizontal: 10))
            .make()
            .onInkTap(() {
          context.read(categoryDetailsFilterProvider).state = filter.lastYear;
        }).expand(),
        "All"
            .text
            .color(filterType == filter.all ? Colors.white : Colors.blue)
            .sm
            .make()
            .centered()
            .pSymmetric(v: 10)
            .box
            .color(filterType == filter.all ? Colors.blue : Color(0xffEEEEEE))
            .rounded
            .margin(EdgeInsets.symmetric(horizontal: 10))
            .make()
            .onInkTap(() {
          context.read(categoryDetailsFilterProvider).state = filter.all;
        }).expand(),
      ],
    ).pSymmetric(h: 24);
  }
}

class CategoryList1 extends ConsumerWidget {
  const CategoryList1({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final list = watch(categoryDetailsModelProvider).categoryList;
    return ListView(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: list
          .map((e) => Row(
                children: [
                  Icon(
                    e.category.icon,
                    color: e.category.iconColor,
                    size: 20,
                  ),
                  16.widthBox,
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          e.category.name.text.bold.base.make(),
                          8.widthBox,
                          "${NumberFormat.simpleCurrency(decimalDigits: 0).format(e.total)}"
                              .text
                              .bold
                              .base
                              .make(),
                        ],
                      ),
                      8.heightBox,
                      LinearPercentIndicator(
                        lineHeight: 6,
                        percent:e.total/ list.first.total,
                        padding: EdgeInsets.symmetric(horizontal: 4),
                        backgroundColor: Color(0xffEEEEEE),
                        progressColor: e.category.iconColor,
                      )
                    ],
                  ).expand(),
                ],
              ).pSymmetric(v: 8, h: 24))
          .toList(),
    );
  }
}
