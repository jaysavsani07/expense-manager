import 'package:expense_manager/core/routes.dart';
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
        child: Container(
          constraints: BoxConstraints.expand(),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: vm.list
                      .map((e) => Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 4),
                            width: double.maxFinite,
                            height: 110,
                            child: Card(
                              elevation: 1,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(8),
                                          bottomLeft: Radius.circular(8)),
                                      color: e.category.iconColor,
                                    ),
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 12),
                                    height: double.maxFinite,
                                    child: Icon(e.category.icon),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8, right: 8, bottom: 4, top: 4),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          e.category.name.text.bold.base.make(),
                                          "${NumberFormat.simpleCurrency().currencySymbol} ${e.total.toString().replaceAll(RegExp(r"([.]*0)(?!.*\d)"), "")}"
                                              .text
                                              .lg
                                              .make()
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ))
                      .toList(),
                ),
              ),
              OutlinedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.addEntry,
                        arguments: null);
                  },
                  child: Text("NEW"))
            ],
          ),
        ));
  }
}
