import 'package:expense_manager/data/language/app_localization.dart';
import 'package:expense_manager/ui/app/app_state.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:velocity_x/velocity_x.dart';

class ThemeDialog extends AlertDialog {
  @override
  Widget build(BuildContext context) {
    ThemeMode selected = context.read(appStateNotifier).themeMode;
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
                  title: e.item2.text.size(14).medium.make(),
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
