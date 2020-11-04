import 'package:expense_manager/ui/addEntry/addEntry_state.dart';
import 'package:expense_manager/ui/dashboard/dashboard_state.dart';
import 'package:expense_manager/ui/home/home_state.dart';
import 'package:meta/meta.dart';

@immutable
class AppState {
  final HomeState homeState;
  final AddEntryState addEntryState;
  final DashboardState dashboardState;

  AppState(
      {@required this.homeState,
      @required this.addEntryState,
      @required this.dashboardState});

  factory AppState.initial() => AppState(
      homeState: HomeState.initial(),
      addEntryState: AddEntryState.initial(),
      dashboardState: DashboardState.initial());

  AppState copyWith(
      {HomeState homeState,
      AddEntryState addEntryState,
      DashboardState dashboardState}) {
    return AppState(
        homeState: homeState ?? this.homeState,
        addEntryState: addEntryState ?? this.addEntryState,
        dashboardState: dashboardState ?? this.dashboardState);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          homeState == other.homeState &&
          addEntryState == other.addEntryState &&
          dashboardState == other.dashboardState;

  @override
  int get hashCode =>
      homeState.hashCode ^ addEntryState.hashCode ^ dashboardState.hashCode;

  @override
  String toString() {
    return 'AppState{homeState: $homeState, addEntryState: $addEntryState, dashboardState: $dashboardState}';
  }
}
