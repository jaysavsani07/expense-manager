import 'package:dotted_border/dotted_border.dart';
import 'package:expense_manager/core/app_localization.dart';
import 'package:expense_manager/ui/history/history_list.dart';
import 'package:expense_manager/ui/history/month_list.dart';
import 'package:expense_manager/ui/history/year_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:velocity_x/velocity_x.dart';

class History extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Scaffold(
      appBar: AppBar(
        title: DottedBorder(
                color: Theme.of(context).appBarTheme.textTheme.headline6.color,
                dashPattern: [5, 5],
                radius: Radius.circular(12),
                borderType: BorderType.RRect,
                child: AppLocalization.of(context)
                    .getTranslatedVal("history")
                    .text
                    .make()
                    .pSymmetric(h: 8, v: 4))
            .pOnly(left: 24),
        actions: [
          Icon(
            Icons.calendar_today_rounded,
          ).p24().onInkTap(() {
            showModalBottomSheet(
                context: context,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                builder: (builder) => YearList());
          })
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          10.heightBox,
          MonthList(),
          HistoryList(),
        ],
      ),
    );
  }
}

