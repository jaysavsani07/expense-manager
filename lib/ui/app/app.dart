import 'package:expense_manager/core/routes.dart';
import 'package:expense_manager/core/theme.dart';
import 'package:expense_manager/data/models/app_state.dart';
import 'package:expense_manager/ui/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class MyApp extends StatelessWidget {
  final Store<AppState> store;

  const MyApp({Key key, this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        onGenerateTitle: (context) => "Title",
        theme: AppTheme.theme,
        routes: {
          AppRoutes.home: (context) {
            return HomeScreen(
              onInit: () {
                // StoreProvider.of<AppState>(context).dispatch(LoadTodosAction());
              },
            );
          },
        },
      ),
    );
  }
}
