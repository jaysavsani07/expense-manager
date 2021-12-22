import 'package:expense_manager/core/routes.dart';
import 'package:expense_manager/core/theme.dart';
import 'package:expense_manager/core/app_localization.dart';
import 'package:expense_manager/ui/addCategory/addCategory.dart';
import 'package:expense_manager/ui/addEntry/addEntry.dart';
import 'package:expense_manager/ui/category_details/category_details.dart';
import 'package:expense_manager/ui/category_list/category_list.dart';
import 'package:expense_manager/ui/home/home.dart';
import 'package:expense_manager/ui/landing/onboarding_pageview.dart';
import 'package:expense_manager/ui/setting/setting.dart';
import 'package:expense_manager/ui/welcome/welcome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app_state.dart';

class MyApp extends ConsumerWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appState = ref.watch(appStateNotifier);
    return MaterialApp(
      theme: AppTheme.theme,
      darkTheme: AppTheme.darkTheme,
      supportedLocales: [
        Locale('en', 'US'),
        Locale('es', 'ES'),
        Locale('pt', 'BR')
      ],
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
      themeMode: appState.themeMode,
      debugShowCheckedModeBanner: false,
      initialRoute: (ref.read(appStateNotifier)).userName.isEmpty
          ? AppRoutes.onBoarding
          : AppRoutes.home,
      routes: {
        AppRoutes.welcome: (context) => Welcome(),
        AppRoutes.onBoarding: (context) => CustomScrollOnboarding(),
        AppRoutes.home: (context) => HomeScreen(),
        AppRoutes.addEntry: (context) => AddEntry(
            entryWithCategory: ModalRoute.of(context).settings.arguments),
        AppRoutes.categoryList: (context) =>
            CategoryList(entryType: ModalRoute.of(context).settings.arguments),
        AppRoutes.addCategory: (context) =>
            AddCategory(tuple2: ModalRoute.of(context).settings.arguments),
        AppRoutes.categoryDetails: (context) => CategoryDetails(),
        AppRoutes.setting: (context) => Setting(),
      },
    );
  }
}
