import 'package:expense_manager/core/routes.dart';
import 'package:expense_manager/data/models/history.dart';
import 'package:expense_manager/ui/history/history_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:intl/intl.dart';
import 'package:tuple/tuple.dart';
import 'package:velocity_x/velocity_x.dart';

class HistoryList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final vm = watch(historyListProvider);
    return vm
        .when(
            data: (list) => ListView(
                  shrinkWrap: true,
                  children: list
                      .map((History history) => Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              30.heightBox,
                              history.title.text.bold.size(18).make(),
                              14.heightBox,
                              ListView(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                children: history.list
                                    .map((e) => Row(
                                          children: [
                                            Icon(
                                              e.category.icon,
                                              color: e.category.iconColor,
                                              size: 20,
                                            ),
                                            16.widthBox,
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                e.category.name.text.medium
                                                    .make(),
                                                Row(
                                                  children: [
                                                    DateFormat('d MMM')
                                                        .format(e
                                                            .entry.modifiedDate)
                                                        .text
                                                        .size(12)
                                                        .color(
                                                            Color(0xff212121))
                                                        .make(),
                                                    8.widthBox,
                                                    DateFormat.Hm()
                                                        .format(e
                                                            .entry.modifiedDate)
                                                        .text
                                                        .size(12)
                                                        .color(
                                                            Color(0xff212121))
                                                        .make(),
                                                  ],
                                                ),
                                              ],
                                            ).expand(),
                                            "${NumberFormat.simpleCurrency().currencySymbol} ${e.entry.amount.toString().replaceAll(RegExp(r"([.]*0)(?!.*\d)"), "")}"
                                                .text
                                                .size(16)
                                                .bold
                                                .make()
                                          ],
                                        ).pSymmetric(v: 8).onInkTap(() {
                                          Navigator.pushNamed(
                                              context, AppRoutes.addEntry,
                                              arguments: Tuple2(e, null));
                                        }))
                                    .toList(),
                              )
                            ],
                          ).pSymmetric(h: 24))
                      .toList(),
                ),
            loading: () => Center(child: CircularProgressIndicator()),
            error: (e, str) => Text(e.toString()))
        .expand();
  }
}
