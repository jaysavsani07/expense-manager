import 'package:expense_manager/core/app_localization.dart';
import 'package:expense_manager/ui/setting/setting_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';

class MonthCycleDialog extends AlertDialog {
  @override
  Widget build(BuildContext context) {
    String selected = context.read(monthStartDateStateNotifier).date;
    return AlertDialog(
      contentPadding: const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 0),
      title: Text(
        AppLocalization.of(context).getTranslatedVal("month_cycle_date"),
        style: Theme.of(context).textTheme.subtitle1,
      ),
      content: SizedBox(
        height: 250,
        child: ListView(
            shrinkWrap: true,
            children: [
              "1",
              "2",
              "3",
              "4",
              "5",
              "6",
              "7",
              "8",
              "9",
              "10",
              "11",
              "12",
              "13",
              "14",
              "15",
              "16",
              "17",
              "18",
              "19",
              "20",
            ]
                .map((e) => InkWell(
                      onTap: () {
                        context.read(monthStartDateStateNotifier).setDate(e);
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Center(
                          child: Text(
                            e,
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2
                                .copyWith(
                                    fontSize: e == selected ? 24 : 14,
                                    fontWeight: e == selected
                                        ? FontWeight.bold
                                        : FontWeight.w500),
                          ),
                        ),
                      ),
                    ))
                .toList()),
      ),
      actions: [
        InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              AppLocalization.of(context).getTranslatedVal("cancel"),
              style:
                  Theme.of(context).textTheme.subtitle2.copyWith(fontSize: 14),
            ),
          ),
        ),
      ],
    );
  }
}
