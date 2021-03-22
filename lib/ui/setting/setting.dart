import 'package:dotted_border/dotted_border.dart';
import 'package:expense_manager/data/datasource/language_data.dart';
import 'package:expense_manager/core/app_localization.dart';
import 'package:expense_manager/ui/dialog/language.dart';
import 'package:expense_manager/ui/dialog/month_cycle.dart';
import 'package:expense_manager/ui/dialog/theme.dart';
import 'package:expense_manager/ui/setting/setting_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:package_info/package_info.dart';
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
            color: Theme.of(context).appBarTheme.textTheme.headline6.color,
            dashPattern: [5, 5],
            radius: Radius.circular(12),
            borderType: BorderType.RRect,
            child: AppLocalization.of(context)
                .getTranslatedVal("settings")
                .text
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
              AppLocalization.of(context)
                  .getTranslatedVal("appearance")
                  .text
                  .size(16)
                  .medium
                  .make(),
              4.heightBox,
              ((appState.themeMode == ThemeMode.system)
                      ? AppLocalization.of(context).getTranslatedVal(
                          "choose_your_light_or_dark_theme_preference")
                      : (appState.themeMode == ThemeMode.dark
                          ? AppLocalization.of(context)
                              .getTranslatedVal("dark_theme")
                          : AppLocalization.of(context)
                              .getTranslatedVal("light_theme")))
                  .text
                  .size(12)
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
              AppLocalization.of(context)
                  .getTranslatedVal("month_cycle_date")
                  .text
                  .size(16)
                  .medium
                  .make(),
              4.heightBox,
              monthStartDate.date.text.size(12).make(),
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
              AppLocalization.of(context)
                  .getTranslatedVal("language")
                  .text
                  .size(16)
                  .medium
                  .make(),
              4.heightBox,
              Language.languageList()
                  .firstWhere(
                      (element) => element.locale == appState.currentLocale)
                  .name
                  .text
                  .size(12)
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
              AppLocalization.of(context)
                  .getTranslatedVal("expense_manager_by_nividata")
                  .text
                  .size(14)
                  .center
                  .make(),
              "${AppLocalization.of(context).getTranslatedVal("app_version")}${appState.appVersion}"
                  .text
                  .size(14)
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
