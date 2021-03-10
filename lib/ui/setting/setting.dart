import 'package:dotted_border/dotted_border.dart';
import 'package:expense_manager/data/datasource/language_data.dart';
import 'package:expense_manager/ui/setting/month_start_date_list.dart';
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
              "Choose your light or dark theme preference"
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
              "Month Start Date".text.size(16).medium.make(),
              4.heightBox,
              "1".text.size(14).color(Color(0xff616161)).make(),
            ],
          ).pSymmetric(h: 24, v: 12).onInkTap(() {}),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              "Language".text.size(16).medium.make(),
              4.heightBox,
              "English".text.size(14).color(Color(0xff616161)).make(),
            ],
          ).pSymmetric(h: 24, v: 12).onInkTap(() {}),
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
                    // Navigator.of(context).pop();
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

class MonthStartDate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      final vm = watch(monthStartDateStateNotifier);
      return vm.date.text.xl
          .make()
          .box
          .alignCenter
          .height(48)
          .width(60)
          .make()
          .pSymmetric(h: 8)
          .card
          .zero
          .rounded
          .make()
          .onInkTap(() {
        showModalBottomSheet(
            context: context,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            builder: (builder) => MonthStartDateList());
      }).p8();
    });
  }
}

class LanguageDropDown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = context.read(appStateNotifier);
    return DropdownButton(
      onChanged: (Language language) {
        Locale _tempLocale = Locale(language.languageCode, 'BR');
        appState.changeLocale(switchToLocale: _tempLocale);
      },
      icon: Icon(
        Icons.language_outlined,
      ),
      items: Language.languageList()
          .map<DropdownMenuItem<Language>>((lang) => DropdownMenuItem(
              value: lang,
              child: Row(
                children: <Widget>[Text(lang.flag), Text(lang.languageCode)],
              )))
          .toList(),
    );
  }
}
