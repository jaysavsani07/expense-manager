import 'package:expense_manager/core/routes.dart';
import 'package:expense_manager/data/datasource/language_data.dart';
import 'package:expense_manager/data/language/app_localization.dart';
import 'package:expense_manager/ui/app/app_state.dart';
import 'package:expense_manager/ui/dialog/language.dart';
import 'package:expense_manager/ui/dialog/month_cycle.dart';
import 'package:expense_manager/ui/dialog/theme.dart';
import 'package:expense_manager/ui/setting/setting_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:velocity_x/velocity_x.dart';

class Welcome extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    var appState = watch(appStateNotifier);
    var monthStartDate = watch(monthStartDateStateNotifier);
    String name = "";
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          100.heightBox,
          AppLocalization.of(context)
              .getTranslatedVal("welcome_to")
              .text
              .size(38)
              .light
              .make()
              .pSymmetric(h: 24),
          AppLocalization.of(context)
              .getTranslatedVal("expense_manager")
              .text
              .size(38)
              .bold
              .make()
              .pSymmetric(h: 24),
          60.heightBox,
          TextFormField(
            keyboardType: TextInputType.text,
            // borderType: VxTextFieldBorderType.underLine,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              labelText:AppLocalization.of(context).getTranslatedVal("enter_your_name")
            ),
            onChanged: (text) {
              name = text;
            },
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
          ).pSymmetric(h: 24),
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
          20.heightBox,
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
          30.heightBox,
          AppLocalization.of(context)
              .getTranslatedVal("next")
              .text
              .size(16)
              .medium
              .white
              .make()
              .centered()
              .pSymmetric(v: 20)
              .card
              .withRounded(value: 6)
              .color(Theme.of(context).primaryColor)
              .elevation(1)
              .make()
              .onInkTap(() {
            if (name.isEmptyOrNull) {
              VxToast.show(context,
                  msg: AppLocalization.of(context)
                      .getTranslatedVal("pls_enter_user_name"),
                  bgColor: Colors.redAccent);
            } else if (name.length < 3 || name.length > 10) {
              VxToast.show(context,
                  msg: AppLocalization.of(context).getTranslatedVal(
                      "user_name_allowed_from_3_to_20_characters"),
                  bgColor: Colors.redAccent);
            } else {
              context.read(appStateNotifier).changeUserName(name);
              Navigator.popAndPushNamed(context, AppRoutes.home);
            }
          }).pSymmetric(h: 22)
        ],
      ).scrollVertical(),
    );
  }
}
