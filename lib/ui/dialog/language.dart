import 'package:expense_manager/data/datasource/language_data.dart';
import 'package:expense_manager/core/app_localization.dart';
import 'package:expense_manager/ui/app/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';

class LanguageDialog extends AlertDialog {
  @override
  Widget build(BuildContext context) {
    Locale selected = context.read(appStateNotifier).currentLocale;
    return AlertDialog(
      contentPadding: const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 0),
      title: Text(
        AppLocalization.of(context).getTranslatedVal("language"),
        style: Theme.of(context).textTheme.subtitle1,
      ),
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
                      Text(
                        e.flag,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      SizedBox(width: 4),
                      Text(
                        e.name,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2
                            .copyWith(fontSize: 14),
                      ),
                    ],
                  ),
                ))
            .toList(),
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
