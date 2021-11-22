import 'package:dotted_border/dotted_border.dart';
import 'package:expense_manager/core/app_localization.dart';
import 'package:expense_manager/ui/history/history_list.dart';
import 'package:expense_manager/ui/history/month_list.dart';
import 'package:expense_manager/ui/history/year_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';

class History extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 24),
          child: DottedBorder(
            color: Theme.of(context).appBarTheme.textTheme.headline6.color,
            dashPattern: [5, 5],
            radius: Radius.circular(12),
            borderType: BorderType.RRect,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child:
                  Text(AppLocalization.of(context).getTranslatedVal("history")),
            ),
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  builder: (builder) => YearList());
            },
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Icon(
                Icons.calendar_today_rounded,
              ),
            ),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          MonthList(),
          HistoryList(),
        ],
      ),
    );
  }
}
