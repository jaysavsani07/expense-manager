import 'package:expense_manager/core/routes.dart';
import 'package:expense_manager/ui/app/app_state.dart';
import 'package:expense_manager/ui/dashboard/dashboard_category_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class Dashboard extends StatelessWidget {
  Dashboard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      distinct: true,
      converter: _ViewModel.fromStore,
      builder: (context, vm) {
        return Container(
          constraints: BoxConstraints.expand(),
          child: Column(
            children: [
              Expanded(
                child: DashboardCategoryList(),
              ),
              OutlinedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.addEntry);
                  },
                  child: Text("NEW"))
            ],
          ),
        );
      },
    );
  }
}

class _ViewModel {
  // final List<EntryWithCategory> list;

  _ViewModel(/*{
    @required this.list,
  }*/
      );

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
        // list: store.state.dashboardState.list,
        );
  }
}
