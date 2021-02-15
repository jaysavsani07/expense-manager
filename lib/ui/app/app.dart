import 'package:expense_manager/core/routes.dart';
import 'package:expense_manager/core/theme.dart';
import 'package:expense_manager/ui/addCategory/addCategory.dart';
import 'package:expense_manager/ui/addEntry/addEntry.dart';
import 'package:expense_manager/ui/categoryList/category_list.dart';
import 'package:expense_manager/ui/home/home.dart';
import 'package:expense_manager/ui/setting/setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app_state.dart';

class MyApp extends ConsumerWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final appThemeState = watch(appThemeStateNotifier);
    return ProviderListener<AppThemeState>(
        onChange: (context, model) async {},
        provider: appThemeStateNotifier,
        child: MaterialApp(
          onGenerateTitle: (context) => "Title",
          theme: AppTheme.theme,
          darkTheme: AppTheme.darkTheme,
          themeMode: appThemeState.isDarkModeEnabled
              ? ThemeMode.dark
              : ThemeMode.light,
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
