import 'package:expense_manager/core/app_localization.dart';
import 'package:expense_manager/core/routes.dart';
import 'package:expense_manager/data/models/history.dart';
import 'package:expense_manager/ui/app/app_state.dart';
import 'package:expense_manager/ui/history/history_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:tuple/tuple.dart';

class HistoryList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(historyListProvider);
    String currency = ref.watch(appStateNotifier).currency.item1;
    return Expanded(
      child: vm.when(
          data: (list) => list.isEmpty
              ? HistoryEmpty()
              : ListView(
                  shrinkWrap: true,
                  children: list
                      .map((History history) => Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 30),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 24),
                                child: Text(
                                  ((history.title == "recent_expanse" ||
                                          history.title == "yesterday")
                                      ? AppLocalization.of(context)
                                          .getTranslatedVal(history.title)
                                      : history.title),
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2
                                      .copyWith(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(height: 14),
                              ListView(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                children: history.list
                                    .map((e) => Dismissible(
                                        key: Key(e.entry.id.toString()),
                                        direction: DismissDirection.endToStart,
                                        background: Container(
                                          color: Theme.of(context).errorColor,
                                          child: Align(
                                              alignment: Alignment.centerRight,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 24),
                                                child: Icon(Icons.delete),
                                              )),
                                        ),
                                        onDismissed: (direction) {
                                          ref.read(
                                              deleteItemProvider(e.entry.id));
                                        },
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context, AppRoutes.addEntry,
                                                arguments: Tuple2(e, null));
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8, horizontal: 24),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  e.category.icon,
                                                  color: e.category.iconColor,
                                                  size: 20,
                                                ),
                                                SizedBox(width: 16),
                                                Expanded(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        e.category.name,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .subtitle2,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            DateFormat('d MMM')
                                                                .format(e.entry
                                                                    .modifiedDate),
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .subtitle1
                                                                .copyWith(
                                                                    fontSize:
                                                                        12),
                                                          ),
                                                          SizedBox(width: 8),
                                                          Text(
                                                            DateFormat.Hm()
                                                                .format(e.entry
                                                                    .modifiedDate),
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .subtitle1
                                                                .copyWith(
                                                                    fontSize:
                                                                        12),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Text(
                                                  "${NumberFormat.simpleCurrency(locale: currency, decimalDigits: 2).format(e.entry.amount)}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .subtitle2
                                                      .copyWith(fontSize: 16),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )))
                                    .toList(),
                              )
                            ],
                          ))
                      .toList(),
                ),
          loading: () => Center(child: CircularProgressIndicator()),
          error: (e, str) => Text(e.toString())),
    );
  }
}

class HistoryEmpty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      child: Stack(children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 105),
          child: Align(
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(2))),
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
                                      color: Theme.of(context).dividerColor,
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
                                          color: Theme.of(context).dividerColor,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(2))),
                                    ),
                                    Container(
                                      height: 12,
                                      width: 40,
                                      decoration: BoxDecoration(
                                          color: Theme.of(context).dividerColor,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(2))),
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
                                  color: Theme.of(context).dividerColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(2))),
                            )
                          ],
                        ),
                        SizedBox(height: 6),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              height: 20,
                              width: 20,
                              margin: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: Color(0xffFCEA2B),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(2))),
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
                                      color: Theme.of(context).dividerColor,
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
                                          color: Theme.of(context).dividerColor,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(2))),
                                    ),
                                    Container(
                                      height: 12,
                                      width: 40,
                                      decoration: BoxDecoration(
                                          color: Theme.of(context).dividerColor,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(2))),
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
                                  color: Theme.of(context).dividerColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(2))),
                            )
                          ],
                        ),
                        SizedBox(height: 6),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              height: 20,
                              width: 20,
                              margin: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: Color(0xffFF5722),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(2))),
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
                                      color: Theme.of(context).dividerColor,
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
                                          color: Theme.of(context).dividerColor,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(2))),
                                    ),
                                    Container(
                                      height: 12,
                                      width: 40,
                                      decoration: BoxDecoration(
                                          color: Theme.of(context).dividerColor,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(2))),
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
                                  color: Theme.of(context).dividerColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(2))),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 24),
                Text(
                  AppLocalization.of(context)
                      .getTranslatedVal("no_expense_yet"),
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2
                      .copyWith(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 6),
                Text(
                  AppLocalization.of(context)
                      .getTranslatedVal("no_expense_yet_2"),
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      .copyWith(fontSize: 14),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 30,
          left: MediaQuery.of(context).size.width / 2,
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
