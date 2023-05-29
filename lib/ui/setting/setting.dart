import 'package:dotted_border/dotted_border.dart';
import 'package:expense_manager/data/datasource/language_data.dart';
import 'package:expense_manager/core/app_localization.dart';
import 'package:expense_manager/ui/dialog/common_alert_dialog.dart';
import 'package:expense_manager/ui/dialog/currency_dialog.dart';
import 'package:expense_manager/ui/dialog/language_dialog.dart';
import 'package:expense_manager/ui/dialog/monthly_cycle_date_dialog.dart';
import 'package:expense_manager/ui/dialog/theme_dialog.dart';
import 'package:expense_manager/ui/setting/setting_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:expense_manager/ui/app/app_state.dart';
import 'package:intl/intl.dart';

class Setting extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var appState = ref.watch(appStateNotifier);
    var monthStartDate = ref.watch(monthStartDateStateNotifier);
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios_rounded)),
        title: DottedBorder(
          color: Theme.of(context).appBarTheme.titleTextStyle!.color!,
          dashPattern: [5, 5],
          radius: Radius.circular(12),
          borderType: BorderType.RRect,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Text(
              AppLocalization.of(context).getTranslatedVal("settings"),
              style: Theme.of(context).appBarTheme.titleTextStyle,
            ),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          InkWell(
            onTap: () {
              showGeneralDialog(
                  context: context,
                  barrierDismissible: true,
                  barrierLabel: "themeDialog",
                  transitionDuration: Duration(milliseconds: 200),
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      CommonAlertDialog(child: ThemeDialog()),
                  transitionBuilder:
                      (context, animation, secondaryAnimation, child) =>
                          Transform.scale(
                            scale: animation.value,
                            alignment: Alignment.center,
                            child: child,
                          ));
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    AppLocalization.of(context).getTranslatedVal("appearance"),
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2!
                        .copyWith(fontSize: 16),
                  ),
                  SizedBox(height: 4),
                  Text(
                    ((appState.themeMode == ThemeMode.system)
                        ? AppLocalization.of(context).getTranslatedVal(
                            "choose_your_light_or_dark_theme_preference")
                        : (appState.themeMode == ThemeMode.dark
                            ? AppLocalization.of(context)
                                .getTranslatedVal("dark_theme")
                            : AppLocalization.of(context)
                                .getTranslatedVal("light_theme"))),
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .copyWith(fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              showGeneralDialog(
                  context: context,
                  barrierDismissible: true,
                  barrierLabel: "monthlyCycleDateDialog",
                  transitionDuration: Duration(milliseconds: 200),
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      CommonAlertDialog(child: MonthlyCycleDateDialog()),
                  transitionBuilder:
                      (context, animation, secondaryAnimation, child) =>
                          Transform.scale(
                            scale: animation.value,
                            alignment: Alignment.center,
                            child: child,
                          ));
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    AppLocalization.of(context)
                        .getTranslatedVal("month_cycle_date"),
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2!
                        .copyWith(fontSize: 16),
                  ),
                  SizedBox(height: 4),
                  Text(
                    monthStartDate.date,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .copyWith(fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              showGeneralDialog(
                  context: context,
                  barrierDismissible: true,
                  barrierLabel: "languageDialog",
                  transitionDuration: Duration(milliseconds: 200),
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      CommonAlertDialog(child: LanguageDialog()),
                  transitionBuilder:
                      (context, animation, secondaryAnimation, child) =>
                          Transform.scale(
                            scale: animation.value,
                            alignment: Alignment.center,
                            child: child,
                          ));
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    AppLocalization.of(context).getTranslatedVal("language"),
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2!
                        .copyWith(fontSize: 16),
                  ),
                  SizedBox(height: 4),
                  Text(
                    Language.languageList()
                        .firstWhere((element) =>
                            element.locale == appState.currentLocale)
                        .name,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .copyWith(fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              showGeneralDialog(
                  context: context,
                  barrierDismissible: true,
                  barrierLabel: "currencyDialog",
                  transitionDuration: Duration(milliseconds: 200),
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      CommonAlertDialog(child: CurrencyDialog()),
                  transitionBuilder:
                      (context, animation, secondaryAnimation, child) =>
                          Transform.scale(
                            scale: animation.value,
                            alignment: Alignment.center,
                            child: child,
                          ));
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    AppLocalization.of(context).getTranslatedVal("currency"),
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2!
                        .copyWith(fontSize: 16),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "${NumberFormat.simpleCurrency(locale: appState.currency.item1).currencySymbol} ${appState.currency.item2}",
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .copyWith(fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
          Spacer(),
          Column(
            children: [
              Center(
                child: Text(
                  AppLocalization.of(context)
                      .getTranslatedVal("expense_manager_by_nividata"),
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(fontSize: 14),
                ),
              ),
              Center(
                child: Text(
                  "${AppLocalization.of(context).getTranslatedVal("app_version")}${appState.appVersion}",
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(fontSize: 14),
                ),
              ),
              SizedBox(height: 34),
            ],
          )
        ],
      ),
    );
  }
}
