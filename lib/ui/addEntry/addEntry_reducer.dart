import 'package:expense_manager/ui/addEntry/addEntry_action.dart';
import 'package:expense_manager/ui/addEntry/addEntry_state.dart';
import 'package:redux/redux.dart';

final addEntryReducer = combineReducers<AddEntryState>([
  TypedReducer<AddEntryState, AddEntryAction>(_addEntryReducer),
  TypedReducer<AddEntryState, SavedEntryAction>(_savedEntryExceptionReducer),
  TypedReducer<AddEntryState, ExceptionAction>(_addEntryExceptionReducer),
]);

AddEntryState _addEntryReducer(
    AddEntryState addEntryState, AddEntryAction action) {
  return addEntryState;
}

AddEntryState _savedEntryExceptionReducer(
    AddEntryState addEntryState, SavedEntryAction action) {
  return addEntryState.copyWith(entry: action.entry);
}

AddEntryState _addEntryExceptionReducer(
    AddEntryState addEntryState, ExceptionAction action) {
  return addEntryState.copyWith(exception: action.exception);
}
