import 'package:expense_manager/ui/history/history_action.dart';
import 'package:expense_manager/ui/history/history_state.dart';
import 'package:redux/redux.dart';

final historyReducer = combineReducers<HistoryState>([
  TypedReducer<HistoryState, HistoryDataChangeAction>(
      _historyDataChangeReducer),
]);

HistoryState _historyDataChangeReducer(
    HistoryState state, HistoryDataChangeAction action) {
  return state.copyWith(list: action.list);
}
