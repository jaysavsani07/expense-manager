import 'package:expense_manager/ui/home/home_action.dart';
import 'package:expense_manager/ui/home/home_state.dart';
import 'package:redux/redux.dart';

final homeReducer = combineReducers<HomeState>([
  TypedReducer<HomeState, UpdateHomeTabAction>(_activeTabReducer),
]);

HomeState _activeTabReducer(HomeState homeState, UpdateHomeTabAction action) {
  return homeState.copyWith(activeTab: action.homeTab);
}
