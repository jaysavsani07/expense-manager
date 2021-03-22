import 'package:expense_manager/core/app_localization.dart';
import 'package:expense_manager/ui/setting/setting_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:velocity_x/velocity_x.dart';


class MonthCycleDialog extends AlertDialog {
  @override
  Widget build(BuildContext context) {
    String selected = context.read(monthStartDateStateNotifier).date;
    return AlertDialog(
      contentPadding: const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 0),
      title: AppLocalization.of(context)
          .getTranslatedVal("month_cycle_date")
          .text
          .size(16)
          .medium
          .make(),
      content: ListView(
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
              .map((e) => e.text
              .size(e == selected ? 18 : 14)
              .medium
              .center
              .make()
              .p8()
              .onInkTap(() {
            context.read(monthStartDateStateNotifier).setDate(e);
            Navigator.pop(context);
          }))
              .toList())
          .h(250),
      actions: [
        AppLocalization.of(context)
            .getTranslatedVal("cancel")
            .text
            .size(14)
            .medium
            .make()
            .p24()
            .onInkTap(() {
          Navigator.of(context).pop();
        })
      ],
    );
  }
}
