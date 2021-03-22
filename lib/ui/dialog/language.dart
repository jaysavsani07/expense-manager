import 'package:expense_manager/data/datasource/language_data.dart';
import 'package:expense_manager/core/app_localization.dart';
import 'package:expense_manager/ui/app/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:velocity_x/velocity_x.dart';

class LanguageDialog extends AlertDialog {
  @override
  Widget build(BuildContext context) {
    Locale selected = context.read(appStateNotifier).currentLocale;
    return AlertDialog(
      contentPadding: const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 0),
      title: AppLocalization.of(context)
          .getTranslatedVal("language")
          .text
          .size(16)
          .medium
          .make(),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: Language.languageList()
            .map((e) => RadioListTile(
                  groupValue: selected,
                  value: e.locale,
                  onChanged: (val) {
                    context
                        .read(appStateNotifier)
                        .changeLocale(switchToLocale: e.locale);
                    Navigator.of(context).pop();
                  },
                  title: Row(
                    children: [
                      e.flag.text.make(),
                      e.name.text.size(14).medium.make()
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
