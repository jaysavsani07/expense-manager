import 'package:expense_manager/data/models/app_state.dart';
import 'package:expense_manager/ui/app/loading_reducer.dart';
import 'package:expense_manager/ui/home/home_reducer.dart';

AppState appReducer(AppState state, action) {
  return AppState(
    isLoading: loadingReducer(state.isLoading, action),
    activeTab: tabsReducer(state.activeTab, action),
  );
}
