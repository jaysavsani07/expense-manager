import 'package:expense_manager/data/models/home_tab.dart';
import 'package:expense_manager/ui/home/home_action.dart';
import 'package:redux/redux.dart';

final tabsReducer = combineReducers<HomeTab>([
  TypedReducer<HomeTab, UpdateHomeTabAction>(_activeTabReducer),
]);

HomeTab _activeTabReducer(HomeTab activeTab, UpdateHomeTabAction action) {
  return action.homeTab;
}
