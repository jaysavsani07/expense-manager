import 'package:dotted_border/dotted_border.dart';
import 'package:expense_manager/core/app_localization.dart';
import 'package:expense_manager/ui/dialog/common_alert_dialog.dart';
import 'package:expense_manager/ui/dialog/history_filter_dialog.dart';
import 'package:expense_manager/ui/history/history_list.dart';
import 'package:expense_manager/ui/history/month_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class History extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
              showGeneralDialog(
                  context: context,
                  barrierDismissible: true,
                  barrierLabel: "history",
                  transitionDuration: Duration(milliseconds: 200),
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      CommonAlertDialog(child: HistoryFilterDialog()),
                  transitionBuilder:
                      (context, animation, secondaryAnimation, child) =>
                          Transform.scale(
                            scale: animation.value,
                            alignment: Alignment(0.83, -0.83),
                            child: child,
                          ));
            },
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Icon(
                Icons.filter_list_rounded,
              ),
            ),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8),
          MonthList(),
          HistoryList(),
        ],
      ),
    );
  }
}
