import 'package:expense_manager/core/keys.dart';
import 'package:expense_manager/core/localization.dart';
import 'package:expense_manager/data/models/home_tab.dart';
import 'package:expense_manager/ui/app/app_state.dart';
import 'package:expense_manager/ui/home/home_action.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class HomeTabSelector extends StatelessWidget {
  HomeTabSelector({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      distinct: true,
      converter: _ViewModel.fromStore,
      builder: (context, vm) {
        return BottomNavigationBar(
          key: AppKeys.tabs,
          currentIndex: HomeTab.values.indexOf(vm.activeTab),
          onTap: vm.onTabSelected,
          items: HomeTab.values.map((tab) {
            return BottomNavigationBarItem(
              icon: Icon(
                tab == HomeTab.dashboard ? Icons.home : Icons.history,
                key: tab == HomeTab.dashboard
                    ? AppKeys.todoTab
                    : AppKeys.statsTab,
              ),
              label: tab == HomeTab.dashboard
                  ? AppLocalizations.dashboard
                  : AppLocalizations.history,
            );
          }).toList(),
        );
      },
    );
  }
}

class _ViewModel {
  final HomeTab activeTab;
  final Function(int) onTabSelected;

  _ViewModel({
    @required this.activeTab,
    @required this.onTabSelected,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      activeTab: store.state.homeState.activeTab,
      onTabSelected: (index) {
        store.dispatch(UpdateHomeTabAction((HomeTab.values[index])));
      },
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _ViewModel &&
          runtimeType == other.runtimeType &&
          activeTab == other.activeTab;

  @override
  int get hashCode => activeTab.hashCode;
}
