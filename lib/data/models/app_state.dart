import 'package:expense_manager/data/models/home_tab.dart';
import 'package:meta/meta.dart';

@immutable
class AppState {
  final bool isLoading;
  final HomeTab activeTab;

  AppState({this.isLoading = false, this.activeTab = HomeTab.dashboard});

  factory AppState.loading() => AppState(isLoading: true);

  AppState copyWith({bool isLoading, HomeTab activeTab}) {
    return AppState(
      isLoading: isLoading ?? this.isLoading,
      activeTab: activeTab ?? this.activeTab,
    );
  }

  @override
  int get hashCode => isLoading.hashCode ^ activeTab.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          isLoading == other.isLoading &&
          activeTab == other.activeTab;

  @override
  String toString() {
    return 'AppState{isLoading: $isLoading, activeTab: $activeTab}';
  }
}
