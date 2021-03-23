import 'package:expense_manager/core/routes.dart';
import 'package:expense_manager/core/app_localization.dart';
import 'package:expense_manager/ui/dashboard/dashboard_state.dart';
import 'package:expense_manager/ui/dashboard/pie_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:intl/intl.dart';
import 'package:tuple/tuple.dart';
import 'package:velocity_x/velocity_x.dart';

class CategoryChartView extends ConsumerWidget {
  const CategoryChartView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final vm = watch(categoryPieChartVisibilityProvider);
    return Visibility(
      visible: !vm.state,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          30.heightBox,
          AppLocalization.of(context)
              .getTranslatedVal("total_expense")
              .text
              .size(18)
              .bold
              .make()
              .pOnly(left: 24),
          20.heightBox,
          const CategoryPieChartView(),
        ],
      ),
    );
  }
}

class CategoryPieChartView extends ConsumerWidget {
  const CategoryPieChartView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final vm = watch(categoryPieChartProvider);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        vm.isEmpty
            ? SizedBox()
            : SizedBox(
                height: 140,
                width: 140,
                child: PieChart(
                  dataMap: [
                    ...vm.map((e) => Tuple2(e.value, e.color)).toList()
                  ],
                  animationDuration: Duration(milliseconds: 800),
                  chartLegendSpacing: 16,
                  chartRadius: MediaQuery.of(context).size.width / 3.2 > 300
                      ? 300
                      : MediaQuery.of(context).size.width / 3.2,
                  initialAngleInDegree: 0,
                  centerText: const TotalAmount(),
                  ringStrokeWidth: 12,
                  emptyColor: Colors.grey,
                ),
              ).expand(),
        24.widthBox,
        CategoryPieChatListView()
      ],
    ).pSymmetric(h: 16, v: 24).card.withRounded(value: 6).make().onInkTap(() {
      Navigator.pushNamed(context, AppRoutes.categoryDetails);
    }).pSymmetric(h: 24);
  }
}

class CategoryPieChatListView extends ConsumerWidget {
  const CategoryPieChatListView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final vm = watch(categoryPieChartListProvider);
    return ListView(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      children: vm
          .map((list) => Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.circle,
                    size: 10,
                    color: list.iconColor,
                  ),
                  4.widthBox,
                  list.name.text.size(14).ellipsis.make()
                ],
              ).pOnly(bottom: 24))
          .toList(),
    ).h(140).expand();
  }
}

class TotalAmount extends ConsumerWidget {
  const TotalAmount({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final totalAmount = watch(totalAmountProvider);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppLocalization.of(context)
            .getTranslatedVal("last_month")
            .text
            .textStyle(Theme.of(context).textTheme.caption)
            .make(),
        FittedBox(
          child:
              "${NumberFormat.simpleCurrency(decimalDigits: 0).format(totalAmount)}"
                  .text
                  .size(20)
                  .bold
                  .make()
                  .pSymmetric(h: 12),
        )
      ],
    );
  }
}
