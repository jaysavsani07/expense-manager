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
    final vm = watch(dashboardViewModelProvider);
    return ProviderListener<DashboardViewModel>(
        provider: dashboardViewModelProvider,
        onChange: (context, model) async {},
        child: SafeArea(
          top: true,
          child: Scaffold(
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    "Total expense".text.xl2.make().pOnly(left: 8),
                    Icon(Icons.settings_outlined).p16().onInkTap(() {})
                  ],
                ),
                "${NumberFormat.simpleCurrency().currencySymbol}${vm.total.toString().replaceAll(RegExp(r"([.]*0)(?!.*\d)"), "")}"
                    .text
                    .bold
                    .xl5
                    .make()
                    .pSymmetric(h: 16),
                8.heightBox,
                "${NumberFormat.simpleCurrency().currencySymbol}${vm.today.toString().replaceAll(RegExp(r"([.]*0)(?!.*\d)"), "")} Today"
                    .text
                    .green500
                    .make()
                    .pOnly(left: 18),
                16.heightBox,
                PageView(
                  scrollDirection: Axis.horizontal,
                  controller: PageController(
                    initialPage: 0,
                  ),
                  children: [
                    Column(
                      children: [
                        AspectRatio(
                          aspectRatio: 1,
                          child: PieChart(
                            PieChartData(
                                pieTouchData: PieTouchData(
                                    touchCallback: (pieTouchResponse) {
                                  vm.onGraphItemTeach(pieTouchResponse);
                                }),
                                borderData: FlBorderData(
                                  show: false,
                                ),
                                sectionsSpace: 0,
                                centerSpaceRadius: 80,
                                sections: vm.graphList),
                          ),
                        ),
                        GridView(
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, childAspectRatio: 5),
                          scrollDirection: Axis.vertical,
                          children: vm.list
                              .map((list) => Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.circle,
                                        size: 16,
                                        color: list.category.iconColor,
                                      ),
                                      8.widthBox,
                                      list.category.name.text.make()
                                    ],
                                  ).box.height(12).make())
                              .toList(),
                        ).pSymmetric(h: 16).expand()
                      ],
                    ),
                    ListView(
                      shrinkWrap: true,
                      children: vm.list
                          .map((e) => Row(
                                children: [
                                  Icon(
                                    e.category.icon,
                                    color: Vx.white,
                                  )
                                      .box
                                      .p12
                                      .height(80)
                                      .withDecoration(BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(8),
                                            bottomLeft: Radius.circular(8)),
                                        color: e.category.iconColor,
                                      ))
                                      .make(),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        e.category.name.text.bold.base.make(),
                                        "${NumberFormat.simpleCurrency().currencySymbol}${e.total.toString().replaceAll(RegExp(r"([.]*0)(?!.*\d)"), "")}"
                                            .text
                                            .lg
                                            .make()
                                      ],
                                    ).pSymmetric(v: 4, h: 8),
                                  ),
                                ],
                              ).card.zero.withRounded(value: 8).white.p8.make())
                          .toList(),
                    ),
                  ],
                ).expand(),
              ],
            ),
          ),
        ));
  }
}
