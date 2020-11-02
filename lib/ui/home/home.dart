import 'package:expense_manager/core/keys.dart';
import 'package:expense_manager/core/routes.dart';
import 'package:expense_manager/data/models/app_state.dart';
import 'package:expense_manager/data/models/home_tab.dart';
import 'package:expense_manager/ui/home/home_tab_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class HomeScreen extends StatefulWidget {
  final void Function() onInit;

  HomeScreen({@required this.onInit}) : super(key: AppKeys.homeScreen);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    widget.onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, HomeTab>(
      distinct: true,
      converter: (Store<AppState> store) => store.state.activeTab,
      builder: (BuildContext context, HomeTab activeTab) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Title"),
          ),
          body: activeTab == HomeTab.dashboard ? Text("d") : Text("H"),
          floatingActionButton: FloatingActionButton(
            key: AppKeys.addTodoFab,
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.addTodo);
            },
            child: Icon(Icons.add),
          ),
          bottomNavigationBar: HomeTabSelector(),
        );
      },
    );
  }
}
