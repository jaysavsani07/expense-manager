import 'package:expense_manager/ui/addEntry/addEntry_state.dart';
import 'package:expense_manager/ui/dashboard/dashboard_state.dart';
import 'package:expense_manager/ui/history/history_state.dart';
import 'package:expense_manager/ui/home/home_state.dart';
import 'package:meta/meta.dart';

@immutable
class AppState {
  final HomeState homeState;
  final AddEntryState addEntryState;
  final DashboardState dashboardState;
  final HistoryState historyState;

  AppState(
      {@required this.homeState,
      @required this.addEntryState,
      @required this.dashboardState,
      @required this.historyState});

  factory AppState.initial() => AppState(
      homeState: HomeState.initial(),
      addEntryState: AddEntryState.initial(),
      dashboardState: DashboardState.initial(),
      historyState: HistoryState.initial());

  AppState copyWith(
      {HomeState homeState,
      AddEntryState addEntryState,
      DashboardState dashboardState,
      HistoryState historyState}) {
    return AppState(
        homeState: homeState ?? this.homeState,
        addEntryState: addEntryState ?? this.addEntryState,
        dashboardState: dashboardState ?? this.dashboardState,
        historyState: historyState ?? this.historyState);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          homeState == other.homeState &&
          addEntryState == other.addEntryState &&
          dashboardState == other.dashboardState &&
          historyState == other.historyState;

  @override
  int get hashCode =>
      homeState.hashCode ^
      addEntryState.hashCode ^
      dashboardState.hashCode ^
      historyState.hashCode;

  @override
  String toString() {
    return 'AppState{homeState: $homeState, addEntryState: $addEntryState, dashboardState: $dashboardState, historyState: $historyState}';
  }
}
