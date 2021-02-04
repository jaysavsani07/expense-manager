import 'package:expense_manager/data/models/history.dart';
import 'package:expense_manager/ui/history/history_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:intl/intl.dart';

class History1 extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final vm = watch(historyModelProvider);
    return ProviderListener<HistoryViewModel>(
        provider: historyModelProvider,
        onChange: (context, model) async {},
        child: ListView(
          shrinkWrap: true,
          children: vm.list
              .map((History history) => Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          history.title,
                          style: TextTheme().caption,
                        ),
                        ListView(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          children: history.list
                              .map((e) => Container(
                                    padding: EdgeInsets.symmetric(vertical: 8),
                                    height: 66,
                                    child: Row(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(25)),
                                            color: e.category.iconColor,
                                          ),
                                          height: 50,
                                          width: 50,
                                          child: Icon(e.category.icon),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8,
                                                right: 8,
                                                bottom: 4,
                                                top: 4),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      e.category.name,
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(
                                                        e.entry.amount
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold))
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      DateFormat('d MMM')
                                                          .format(e.entry
                                                              .modifiedDate),
                                                      style:
                                                          TextTheme().caption,
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 4),
                                                      child: Icon(
                                                        Icons.circle,
                                                        size: 8,
                                                      ),
                                                    ),
                                                    Text(
                                                      DateFormat.Hm().format(
                                                          e.entry.modifiedDate),
                                                      style:
                                                          TextTheme().caption,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ))
                              .toList(),
                        )
                      ],
                    ),
                  ))
              .toList(),
        ));
  }
}
