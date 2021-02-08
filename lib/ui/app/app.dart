import 'package:expense_manager/core/routes.dart';
import 'package:expense_manager/core/theme.dart';
import 'package:expense_manager/ui/addCategory/addCategory.dart';
import 'package:expense_manager/ui/addEntry/addEntry.dart';
import 'package:expense_manager/ui/categoryList/category_list.dart';
import 'package:expense_manager/ui/home/home.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (context) => "Title",
      theme: AppTheme.theme,
      routes: {
        AppRoutes.home: (context) => HomeScreen(),
        AppRoutes.addEntry: (context) => AddEntry(
            entryWithCategory: ModalRoute.of(context).settings.arguments),
        AppRoutes.categoryList: (context) => CategoryList(),
        AppRoutes.addCategory: (context) =>
            AddCategory(category: ModalRoute.of(context).settings.arguments),
      },
    );
  }
}
