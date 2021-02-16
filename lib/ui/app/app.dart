import 'package:expense_manager/core/routes.dart';
import 'package:expense_manager/core/theme.dart';
import 'package:expense_manager/data/language/app_localization.dart';
import 'package:expense_manager/ui/addCategory/addCategory.dart';
import 'package:expense_manager/ui/addEntry/addEntry.dart';
import 'package:expense_manager/ui/categoryList/category_list.dart';
import 'package:expense_manager/ui/home/home.dart';
import 'package:expense_manager/ui/setting/setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app_state.dart';

class MyApp extends ConsumerWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final appState = watch(appStateNotifier);
    return ProviderListener<AppThemeState>(
        onChange: (context, model) async {},
        provider: appStateNotifier,
        child: MaterialApp(
          onGenerateTitle: (context) => "Title",
          theme: AppTheme.theme,
          darkTheme: AppTheme.darkTheme,
          supportedLocales: [Locale('en', 'US'), Locale('es', 'ES'), Locale('pt', 'BR')],
          localizationsDelegates: [
            AppLocalization.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate
          ],
          localeResolutionCallback: (deviceLocale, supportedLocales) {
            for (var locale in supportedLocales) {
              if (locale.languageCode == deviceLocale.languageCode &&
                  locale.countryCode == deviceLocale.countryCode) {
                return deviceLocale;
              }
            }
            return supportedLocales.first;
          },
          locale: appState.currentLocale,
          themeMode: appState.isDarkModeEnabled ? ThemeMode.dark : ThemeMode.light,
          debugShowCheckedModeBanner: false,
          routes: {
            AppRoutes.home: (context) => HomeScreen(),
            AppRoutes.addEntry: (context) => AddEntry(
                entryWithCategory: ModalRoute.of(context).settings.arguments),
            AppRoutes.categoryList: (context) => CategoryList(),
            AppRoutes.addCategory: (context) => AddCategory(
                category: ModalRoute.of(context).settings.arguments),
            AppRoutes.setting: (context) => Setting(),
          },
        ));
  }
}
