import 'package:expense_manager/ui/dashboard/dashboard_action.dart';
import 'package:expense_manager/ui/dashboard/dashboard_state.dart';
import 'package:redux/redux.dart';

final dashboardReducer = combineReducers<DashboardState>([
  TypedReducer<DashboardState, AllEntryLoadedAction>(_allEntryLoadedReducer),
  TypedReducer<DashboardState, LoadAllEntryAction>(_loadAllEntryReducer),
]);

DashboardState _loadAllEntryReducer(
    DashboardState dashboardState, LoadAllEntryAction action) {
  return dashboardState;
}

DashboardState _allEntryLoadedReducer(
    DashboardState dashboardState, AllEntryLoadedAction action) {
  return dashboardState.copyWith(list: action.list);
}
