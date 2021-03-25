import 'package:expense_manager/core/app_localization.dart';
import 'package:expense_manager/core/constants.dart';
import 'package:expense_manager/ui/app/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tuple/tuple.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:intl/intl.dart';

class CurrencyDialog extends AlertDialog {
  @override
  Widget build(BuildContext context) {
    Tuple2<String,String> selected = context.read(appStateNotifier).currency;
    return AlertDialog(
      contentPadding: const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 0),
      title: AppLocalization.of(context)
          .getTranslatedVal("currency")
          .text
          .size(16)
          .medium
          .make(),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: AppConstants.currencyList
            .map((e) => RadioListTile(
                  groupValue: selected,
                  value: e,
                  onChanged: (val) {
                    context.read(appStateNotifier).changeCurrency(currency: e);
                    Navigator.of(context).pop();
                  },
                  title: Row(
                    children: [
                      "${NumberFormat.simpleCurrency(locale: e.item1).currencySymbol} ${e.item2}"
                          .text
                          .size(14)
                          .medium
                          .make()
                    ],
                  ),
                ))
            .toList(),
      ),
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
