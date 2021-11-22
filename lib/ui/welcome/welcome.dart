import 'package:expense_manager/core/routes.dart';
import 'package:expense_manager/data/datasource/language_data.dart';
import 'package:expense_manager/core/app_localization.dart';
import 'package:expense_manager/ui/app/app_state.dart';
import 'package:expense_manager/ui/dialog/language.dart';
import 'package:expense_manager/ui/dialog/month_cycle.dart';
import 'package:expense_manager/ui/dialog/theme.dart';
import 'package:expense_manager/ui/setting/setting_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  String name = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 100),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                AppLocalization.of(context).getTranslatedVal("welcome_to"),
                style: Theme.of(context)
                    .textTheme
                    .subtitle2
                    .copyWith(fontSize: 38, fontWeight: FontWeight.w300),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                AppLocalization.of(context).getTranslatedVal("expense_manager"),
                style: Theme.of(context)
                    .textTheme
                    .subtitle2
                    .copyWith(fontSize: 38, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 60),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: TextFormField(
                keyboardType: TextInputType.text,
                // borderType: VxTextFieldBorderType.underLine,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                    labelText: AppLocalization.of(context)
                        .getTranslatedVal("enter_your_name")),
                onChanged: (text) {
                  name = text;
                },
                style: Theme.of(context)
                    .textTheme
                    .subtitle2
                    .copyWith(fontSize: 30),
              ),
            ),
            SizedBox(height: 20),
            const OptionSelection(),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: ElevatedButton(
                onPressed: () {
                  if (name.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          AppLocalization.of(context)
                              .getTranslatedVal("pls_enter_user_name"),
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        backgroundColor: Colors.redAccent,
                      ),
                    );
                  } else if (name.length < 3 || name.length > 10) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          AppLocalization.of(context).getTranslatedVal(
                              "user_name_allowed_from_3_to_20_characters"),
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        backgroundColor: Colors.redAccent,
                      ),
                    );
                  } else {
                    context.read(appStateNotifier).changeUserName(name);
                    Navigator.popAndPushNamed(context, AppRoutes.home);
                  }
                },
                child: Container(
                  height: 56,
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Text(
                    AppLocalization.of(context).getTranslatedVal("next"),
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OptionSelection extends ConsumerWidget {
  const OptionSelection({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    var appState = watch(appStateNotifier);
    var monthStartDate = watch(monthStartDateStateNotifier);

    return Column(
      children: [
        InkWell(
          onTap: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return ThemeDialog();
                });
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
                      .subtitle2
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
                      .subtitle1
                      .copyWith(fontSize: 12, color: Color(0xff616161)),
                ),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return MonthCycleDialog();
                });
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
                      .subtitle2
                      .copyWith(fontSize: 16),
                ),
                SizedBox(height: 4),
                Text(
                  monthStartDate.date,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      .copyWith(fontSize: 12, color: Color(0xff616161)),
                ),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return LanguageDialog();
                });
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
                      .subtitle2
                      .copyWith(fontSize: 16),
                ),
                SizedBox(height: 4),
                Text(
                  Language.languageList()
                      .firstWhere(
                          (element) => element.locale == appState.currentLocale)
                      .name,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      .copyWith(fontSize: 12, color: Color(0xff616161)),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
