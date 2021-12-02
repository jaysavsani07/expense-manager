import 'package:expense_manager/core/app_localization.dart';
import 'package:expense_manager/core/constants.dart';
import 'package:expense_manager/ui/app/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tuple/tuple.dart';
import 'package:intl/intl.dart';

class CurrencyDialog extends AlertDialog {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 0),
      title: Text(
        AppLocalization.of(context).getTranslatedVal("currency"),
        style: Theme.of(context).textTheme.subtitle1,
      ),
      content: Consumer(
        builder: (context, ref, child) {
          Tuple2<String, String> selected =
              ref.watch(appStateNotifier.notifier).currency;
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: AppConstants.currencyList
                .map((e) => RadioListTile(
                      groupValue: selected,
                      value: e,
                      onChanged: (val) {
                        ref
                            .watch(appStateNotifier.notifier)
                            .changeCurrency(currency: e);
                        Navigator.of(context).pop();
                      },
                      title: Text(
                        "${NumberFormat.simpleCurrency(locale: e.item1).currencySymbol} ${e.item2}",
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2
                            .copyWith(fontSize: 14),
                      ),
                    ))
                .toList(),
          );
        },
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
