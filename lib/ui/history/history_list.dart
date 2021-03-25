import 'package:expense_manager/core/app_localization.dart';
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
        list.isEmpty
            ? HistoryEmpty()
            : ListView(
          shrinkWrap: true,
          children: list
              .map((History history) =>
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  30.heightBox,
                  ((history.title == "recent_expanse" || history.title == "yesterday") ? AppLocalization
                      .of(context)
                      .getTranslatedVal(history.title) : history.title)
                      .text
                      .bold
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
                            direction:
                            DismissDirection.endToStart,
                            background: Container(
                              color: Theme
                                  .of(context)
                                  .errorColor,
                              child: Align(
                                  alignment:
                                  Alignment.centerRight,
                                  child: Icon(Icons.delete)
                                      .pOnly(right: 24)),
                            ),
                            onDismissed: (direction) {
                              context.read(
                                  deleteItemProvider(e.entry.id));
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
                                  MainAxisAlignment
                                      .spaceAround,
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
                                            .format(e.entry
                                            .modifiedDate)
                                            .text
                                            .size(12)
                                            .make(),
                                        8.widthBox,
                                        DateFormat
                                            .Hm()
                                            .format(e.entry
                                            .modifiedDate)
                                            .text
                                            .size(12)
                                            .make(),
                                      ],
                                    ),
                                  ],
                                ).expand(),
                                "${NumberFormat.simpleCurrency(decimalDigits: 2)
                                    .format(e.entry.amount)}"
                                    .text
                                    .size(16)
                                    .bold
                                    .make()
                              ],
                            )
                                .pSymmetric(v: 8, h: 24)
                                .onInkTap(() {
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

class HistoryEmpty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      child: Stack(children: [
        Align(
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 20,
                        width: 20,
                        margin: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Color(0xff2196F3),
                            borderRadius: BorderRadius.all(Radius.circular(2))),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            height: 15,
                            width: 55,
                            margin: EdgeInsets.only(bottom: 4),
                            decoration: BoxDecoration(
                                color: Theme
                                    .of(context)
                                    .dividerColor,
                                borderRadius:
                                BorderRadius.all(Radius.circular(2))),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                height: 12,
                                width: 40,
                                margin: EdgeInsets.only(right: 8),
                                decoration: BoxDecoration(
                                    color: Theme
                                        .of(context)
                                        .dividerColor,
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(2))),
                              ),
                              Container(
                                height: 12,
                                width: 40,
                                decoration: BoxDecoration(
                                    color: Theme
                                        .of(context)
                                        .dividerColor,
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(2))),
                              )
                            ],
                          )
                        ],
                      ),
                      Container(
                        height: 15,
                        width: 40,
                        margin: EdgeInsets.only(
                            left: 16, right: 8, bottom: 8, top: 8),
                        decoration: BoxDecoration(
                            color: Theme
                                .of(context)
                                .dividerColor,
                            borderRadius: BorderRadius.all(Radius.circular(2))),
                      )
                    ],
                  ),
                  6.heightBox,
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 20,
                        width: 20,
                        margin: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Color(0xffFCEA2B),
                            borderRadius: BorderRadius.all(Radius.circular(2))),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            height: 15,
                            width: 55,
                            margin: EdgeInsets.only(bottom: 4),
                            decoration: BoxDecoration(
                                color: Theme
                                    .of(context)
                                    .dividerColor,
                                borderRadius:
                                BorderRadius.all(Radius.circular(2))),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                height: 12,
                                width: 40,
                                margin: EdgeInsets.only(right: 8),
                                decoration: BoxDecoration(
                                    color: Theme
                                        .of(context)
                                        .dividerColor,
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(2))),
                              ),
                              Container(
                                height: 12,
                                width: 40,
                                decoration: BoxDecoration(
                                    color: Theme
                                        .of(context)
                                        .dividerColor,
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(2))),
                              )
                            ],
                          )
                        ],
                      ),
                      Container(
                        height: 15,
                        width: 40,
                        margin: EdgeInsets.only(
                            left: 16, right: 8, bottom: 8, top: 8),
                        decoration: BoxDecoration(
                            color: Theme
                                .of(context)
                                .dividerColor,
                            borderRadius: BorderRadius.all(Radius.circular(2))),
                      )
                    ],
                  ),
                  6.heightBox,
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 20,
                        width: 20,
                        margin: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Color(0xffFF5722),
                            borderRadius: BorderRadius.all(Radius.circular(2))),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            height: 15,
                            width: 55,
                            margin: EdgeInsets.only(bottom: 4),
                            decoration: BoxDecoration(
                                color: Theme
                                    .of(context)
                                    .dividerColor,
                                borderRadius:
                                BorderRadius.all(Radius.circular(2))),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                height: 12,
                                width: 40,
                                margin: EdgeInsets.only(right: 8),
                                decoration: BoxDecoration(
                                    color: Theme
                                        .of(context)
                                        .dividerColor,
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(2))),
                              ),
                              Container(
                                height: 12,
                                width: 40,
                                decoration: BoxDecoration(
                                    color: Theme
                                        .of(context)
                                        .dividerColor,
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(2))),
                              )
                            ],
                          )
                        ],
                      ),
                      Container(
                        height: 15,
                        width: 40,
                        margin: EdgeInsets.only(
                            left: 16, right: 8, bottom: 8, top: 8),
                        decoration: BoxDecoration(
                            color: Theme
                                .of(context)
                                .dividerColor,
                            borderRadius: BorderRadius.all(Radius.circular(2))),
                      )
                    ],
                  ),
                ],
              )
                  .p8()
                  .card
                  .withRounded(value: 8)
                  .elevation(1)
                  .make(),
              24.heightBox,
              AppLocalization
                  .of(context)
                  .getTranslatedVal("no_expense_yet")
                  .text
                  .center
                  .bold
                  .size(28)
                  .make(),
              6.heightBox,
              AppLocalization
                  .of(context)
                  .getTranslatedVal("no_expense_yet_2")
                  .text
                  .center
                  .size(14)
                  .make(),
            ],
          ),
        ).pOnly(bottom: 105),
        Positioned(
          bottom: 30,
          left: context.screenWidth / 2,
          child: Image.asset(
            "assets/images/add_expense_arrow.png",
            width: 75,
            height: 75,
          ),
        )
      ]),
    );
  }
}
