import 'package:expense_manager/data/models/home_tab.dart';
import 'package:flutter/cupertino.dart';

@immutable
class HomeState {
  final HomeTab activeTab;

  HomeState({@required this.activeTab});

  factory HomeState.initial() {
    return HomeState(activeTab: HomeTab.dashboard);
  }

  HomeState copyWith({HomeTab activeTab}) {
    return HomeState(activeTab: activeTab ?? this.activeTab);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HomeState &&
          runtimeType == other.runtimeType &&
          activeTab == other.activeTab;

  @override
  int get hashCode => activeTab.hashCode;

  @override
  String toString() {
    return 'HomeState{activeTab: $activeTab}';
  }
}
