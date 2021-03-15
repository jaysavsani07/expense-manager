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
        data: (list) =>
            ListView(
              shrinkWrap: true,
              children: list
                  .map((History history) =>
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      30.heightBox,
                      history.title.text.bold
                          .size(18)
                          .make()
                          .pSymmetric(h: 24),
                      14.heightBox,
                      ListView(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: history.list
                            .map((e) =>
                            Dismissible(
                                key: Key(e.entry.id.toString()),
                                direction: DismissDirection.endToStart,
                                background: Container(
                                  color: Theme
                                      .of(context)
                                      .errorColor,
                                  child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Icon(Icons.delete)
                                          .pOnly(right: 24)),
                                ),
                                onDismissed: (direction) {
                                  context.read(deleteItemProvider(e.entry.id));
                                },
                                child: Row(
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
                                        e.category.name.text
                                            .size(14)
                                            .medium
                                            .make(),
                                        Row(
                                          children: [
                                            DateFormat('d MMM')
                                                .format(e
                                                .entry.modifiedDate)
                                                .text
                                                .size(12)
                                                .make(),
                                            8.widthBox,
                                            DateFormat
                                                .Hm()
                                                .format(e
                                                .entry.modifiedDate)
                                                .text
                                                .size(12)
                                                .make(),
                                          ],
                                        ),
                                      ],
                                    ).expand(),
                                    "${NumberFormat.simpleCurrency(
                                        decimalDigits: 2).format(
                                        e.entry.amount)}"
                                        .text
                                        .size(16)
                                        .bold
                                        .make()
                                  ],
                                ).pSymmetric(v: 8, h: 24).onInkTap(() {
                                  Navigator.pushNamed(
                                      context, AppRoutes.addEntry,
                                      arguments: Tuple2(e, null));
                                })))
                            .toList(),
                      )
                    ],
                  ))
                  .toList(),
            ),
        loading: () => Center(child: CircularProgressIndicator()),
        error: (e, str) => Text(e.toString()))
        .expand();
  }
}
