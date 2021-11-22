import 'package:expense_manager/core/app_localization.dart';
import 'package:expense_manager/ui/app/app_state.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';
import 'package:flutter_riverpod/all.dart';

class ThemeDialog extends AlertDialog {
  @override
  Widget build(BuildContext context) {
    ThemeMode selected = context.read(appStateNotifier).themeMode;
    return AlertDialog(
      contentPadding: const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 0),
      title: Text(
        AppLocalization.of(context).getTranslatedVal("appearance"),
        style: Theme.of(context).textTheme.subtitle1,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Tuple2(ThemeMode.system,
              AppLocalization.of(context).getTranslatedVal("use_device_theme")),
          Tuple2(ThemeMode.light,
              AppLocalization.of(context).getTranslatedVal("light_theme")),
          Tuple2(ThemeMode.dark,
              AppLocalization.of(context).getTranslatedVal("dark_theme"))
        ]
            .map((e) => RadioListTile(
                  groupValue: selected,
                  value: e.item1,
                  onChanged: (val) {
                    context.read(appStateNotifier).changeTheme(e.item1);
                    Navigator.of(context).pop();
                  },
                  title: Text(
                    e.item2,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2
                        .copyWith(fontSize: 14),
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
