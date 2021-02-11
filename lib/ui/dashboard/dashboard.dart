import 'package:expense_manager/ui/dashboard/dashboard_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:expense_manager/ui/app/app_state.dart';

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
                    DarkModeSwitch(),
                    Icon(Icons.settings_outlined).p16().onInkTap(() {})
                  ],
                ),
                "${NumberFormat.simpleCurrency().currencySymbol}${vm.list.map((e) => e.total).fold(0.0, (previousValue, element) => previousValue + element).toString().replaceAll(RegExp(r"([.]*0)(?!.*\d)"), "")}"
                    .text
                    .bold
                    .xl5
                    .make()
                    .pSymmetric(h: 16),
                8.heightBox,
                "${NumberFormat.simpleCurrency().currencySymbol}${vm.list.first.total.toString().replaceAll(RegExp(r"([.]*0)(?!.*\d)"), "")} Today"
                    .text
                    .green500
                    .make()
                    .pOnly(left: 18),
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
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    e.category.name.text.bold.base.make(),
                                    "${NumberFormat.simpleCurrency().currencySymbol}${e.total.toString().replaceAll(RegExp(r"([.]*0)(?!.*\d)"), "")}"
                                        .text
                                        .lg
                                        .xl
                                        .make()
                                  ],
                                ).pSymmetric(v: 4, h: 8),
                              ),
                            ],
                          ).card.zero.withRounded(value: 8).p8.make())
                      .toList(),
                ),
              ],
            ),
          ),
        ));
  }
}

class DarkModeSwitch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appThemeState = context.read(appThemeStateNotifier);
    return Switch(
      value: appThemeState.isDarkModeEnabled,
      onChanged: (enabled) {
        if (enabled) {
          appThemeState.setDarkTheme();
        } else {
          appThemeState.setLightTheme();
        }
      },
    );
  }
}
