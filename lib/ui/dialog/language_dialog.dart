import 'package:expense_manager/core/color_scheme.dart';
import 'package:expense_manager/data/datasource/language_data.dart';
import 'package:expense_manager/core/app_localization.dart';
import 'package:expense_manager/ui/app/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LanguageDialog extends AlertDialog {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 24),
        Text(
          AppLocalization.of(context).getTranslatedVal("language"),
          style: Theme.of(context).textTheme.subtitle1,
        ),
        SizedBox(height: 8),
        Divider(color: Theme.of(context).colorScheme.crossLightColor),
        Consumer(
          builder: (context, ref, child) {
            Locale selected = ref.watch(appStateNotifier.notifier).currentLocale;
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: Language.languageList()
                  .map((e) => RadioListTile(
                groupValue: selected,
                value: e.locale,
                onChanged: (val) {
                  ref
                      .watch(appStateNotifier.notifier)
                      .changeLocale(switchToLocale: e.locale);
                  Navigator.of(context).pop();
                },
                title: Row(
                  children: [
                    Text(
                      e.flag,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    SizedBox(width: 4),
                    Text(
                      e.name,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2!
                          .copyWith(fontSize: 14),
                    ),
                  ],
                ),
              ))
                  .toList(),
            );
          },
        ),
        SizedBox(height: 8),
      ],
    );
  }
}
