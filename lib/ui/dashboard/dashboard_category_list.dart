import 'package:expense_manager/data/models/entry_with_category.dart';
import 'package:expense_manager/ui/app/app_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class DashboardCategoryList extends StatelessWidget {
  DashboardCategoryList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      distinct: true,
      converter: _ViewModel.fromStore,
      builder: (context, vm) {
        return ListView(
          children: vm.list
              .map((e) => Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    width: double.maxFinite,
                    height: 110,
                    child: Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  bottomLeft: Radius.circular(8)),
                              color: e.category.iconColor,
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            height: double.maxFinite,
                            child: Icon(e.category.icon),
                          ),
                          Flexible(
                            flex: 4,
                            child: Column(
                              children: [
                                Text(e.category.name),
                                Text(e.entry.amount.toString())
                              ],
                            ),
                          ),
                          Flexible(
                            flex: 4,
                            child: Column(
                              children: [
                                Text(e.category.name),
                                Text(e.entry.modifiedDate.toString())
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ))
              .toList(),
        );
      },
    );
  }
}

class _ViewModel {
  final List<EntryWithCategory> list;

  _ViewModel({
    @required this.list,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      list: store.state.dashboardState.list,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _ViewModel &&
          runtimeType == other.runtimeType &&
          list == other.list;

  @override
  int get hashCode => list.hashCode;
}