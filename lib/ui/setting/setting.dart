import 'package:expense_manager/data/datasource/language_data.dart';
import 'package:expense_manager/ui/setting/month_start_date_list.dart';
import 'package:expense_manager/ui/setting/setting_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:expense_manager/ui/app/app_state.dart';

class Setting extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Scaffold(
      appBar: AppBar(
        title: "Setting".text.xl3.make(),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              "Dark mode".text.bold.xl.make(),
              DarkModeSwitch(),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              "Month Start Date".text.bold.xl.make(),
              MonthStartDate()
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: ["Language".text.bold.xl.make(), LanguageDropDown()],
          )
        ],
      ).pSymmetric(h: 16),
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

class DarkModeSwitch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appThemeState = context.read(appStateNotifier);
    return Switch(
      value: appThemeState.isDarkModeEnabled,
      onChanged: (enabled) {
        if (enabled) {
          appThemeState.setDarkTheme();
        } else {
          appThemeState.setLightTheme();
        }
      },
    ).pSymmetric(h: 8).card.zero.rounded.p8.make();
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
