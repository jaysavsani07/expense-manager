import 'package:expense_manager/ui/dashboard/dashboard_state.dart';
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
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.grey.shade50,
            title: "Total expense".text.xl2.make(),
            actions: [Icon(Icons.settings_outlined).p16().onInkTap(() {})],
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              "${NumberFormat.simpleCurrency().currencySymbol}${vm.list.map((e) => e.total).fold(0.0, (previousValue, element) => previousValue + element).toString().replaceAll(RegExp(r"([.]*0)(?!.*\d)"), "")}"
                  .text
                  .bold
                  .xl5
                  .make()
                  .pSymmetric(h: 8),
              16.heightBox,
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
          ),
        ));
  }
}
