import 'package:dotted_border/dotted_border.dart';
import 'package:expense_manager/data/datasource/language_data.dart';
import 'package:expense_manager/ui/setting/setting_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:tuple/tuple.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:expense_manager/ui/app/app_state.dart';

class Setting extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    var appState = watch(appStateNotifier);
    var monthStartDate = watch(monthStartDateStateNotifier);
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back_ios_rounded).onInkTap(() {
          Navigator.pop(context);
        }),
        title: DottedBorder(
            color: Colors.blue,
            dashPattern: [5, 5],
            radius: Radius.circular(12),
            borderType: BorderType.RRect,
            child: "Settings"
                .text
                .size(16)
                .medium
                .color(Colors.blue)
                .make()
                .pSymmetric(h: 8, v: 4)),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          20.heightBox,
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              "Appearance".text.size(16).medium.make(),
              4.heightBox,
              ((appState.themeMode == ThemeMode.system)
                      ? "Choose your light or dark theme preference"
                      : (appState.themeMode == ThemeMode.dark
                          ? "Light Theme"
                          : "Dark Theme"))
                  .text
                  .size(14)
                  .color(Color(0xff616161))
                  .make(),
            ],
          ).pSymmetric(h: 24, v: 12).onInkTap(() {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return ThemeDialog();
                });
          }),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              "Month Cycle Date".text.size(16).medium.make(),
              4.heightBox,
              monthStartDate.date.text.size(14).color(Color(0xff616161)).make(),
            ],
          ).pSymmetric(h: 24, v: 12).onInkTap(() {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return MonthCycleDialog();
                });
          }),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              "Language".text.size(16).medium.make(),
              4.heightBox,
              Language.languageList()
                  .firstWhere(
                      (element) => element.locale == appState.currentLocale)
                  .name
                  .text
                  .size(14)
                  .color(Color(0xff616161))
                  .make(),
            ],
          ).pSymmetric(h: 24, v: 12).onInkTap(() {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return LanguageDialog();
                });
          }),
          Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              "Expense Manager by Nividata".text.size(14).center.make(),
              "App version: 0.0.1"
                  .text
                  .size(14)
                  .color(Color(0xff616161))
                  .center
                  .make(),
              34.heightBox
            ],
          )
        ],
      ),
    );
  }
}

class ThemeDialog extends AlertDialog {
  @override
  Widget build(BuildContext context) {
    ThemeMode selected = context.read(appStateNotifier).themeMode;
    return AlertDialog(
      contentPadding: const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 0),
      title: "Appearance".text.size(16).medium.make(),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Tuple2(ThemeMode.system, "Use Device Theme"),
          Tuple2(ThemeMode.light, "Light Theme"),
          Tuple2(ThemeMode.dark, "Dark Theme")
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
        "Cancel".text.size(14).medium.make().p24().onInkTap(() {
          Navigator.of(context).pop();
        })
      ],
    );
  }
}

class MonthCycleDialog extends AlertDialog {
  @override
  Widget build(BuildContext context) {
    String selected = context.read(monthStartDateStateNotifier).date;
    return AlertDialog(
      contentPadding: const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 0),
      title: "Month Cycle Date".text.size(16).medium.make(),
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
        "Cancel".text.size(14).medium.make().p24().onInkTap(() {
          Navigator.of(context).pop();
        })
      ],
    );
  }
}

class LanguageDialog extends AlertDialog {
  @override
  Widget build(BuildContext context) {
    Locale selected = context.read(appStateNotifier).currentLocale;
    return AlertDialog(
      contentPadding: const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 0),
      title: "Appearance".text.size(16).medium.make(),
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
        "Cancel".text.size(14).medium.make().p24().onInkTap(() {
          Navigator.of(context).pop();
        })
      ],
    );
  }
}
