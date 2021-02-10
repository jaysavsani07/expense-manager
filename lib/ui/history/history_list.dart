import 'package:expense_manager/core/routes.dart';
import 'package:expense_manager/data/models/history.dart';
import 'package:expense_manager/ui/history/history_state.dart';
import 'package:expense_manager/ui/history/month_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:intl/intl.dart';
import 'package:velocity_x/velocity_x.dart';

class HistoryList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final vm = watch(historyModelProvider);
    return ListView(
      shrinkWrap: true,
      children: vm.list
          .map((History history) => Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  history.title.text.light.make(),
                  8.heightBox,
                  ListView(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: history.list
                        .map((e) => Row(
                              children: [
                                Icon(e.category.icon, color: Vx.white)
                                    .p8()
                                    .box
                                    .color(e.category.iconColor)
                                    .roundedFull
                                    .make(),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        e.category.name.text.bold.base.make(),
                                        "${NumberFormat.simpleCurrency().currencySymbol}${e.entry.amount.toString().replaceAll(RegExp(r"([.]*0)(?!.*\d)"), "")}"
                                            .text
                                            .lg
                                            .make()
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        DateFormat('d MMM')
                                            .format(e.entry.modifiedDate)
                                            .text
                                            .make(),
                                        Icon(
                                          Icons.circle,
                                          size: 8,
                                        ).pSymmetric(h: 4),
                                        DateFormat.Hm()
                                            .format(e.entry.modifiedDate)
                                            .text
                                            .make(),
                                      ],
                                    ),
                                  ],
                                ).pSymmetric(h: 8, v: 8).expand(),
                              ],
                            ).pSymmetric(v: 4).onInkTap(() {
                              Navigator.pushNamed(context, AppRoutes.addEntry,
                                  arguments: e);
                            }))
                        .toList(),
                  )
                ],
              ).pSymmetric(h: 16, v: 12))
          .toList(),
    ).expand();
  }
}
