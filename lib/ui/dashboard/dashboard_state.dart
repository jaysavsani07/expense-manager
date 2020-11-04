import 'package:expense_manager/data/models/entry.dart';
import 'package:flutter/material.dart';

@immutable
class DashboardState {
  final List<Entry> list;
  final Exception exception;

  DashboardState({@required this.list, @required this.exception});

  factory DashboardState.initial() {
    return DashboardState(list: <Entry>[], exception: null);
  }

  DashboardState copyWith({List<Entry> list, Exception exception}) {
    return DashboardState(
        list: list ?? this.list, exception: exception ?? this.exception);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DashboardState &&
          runtimeType == other.runtimeType &&
          list == other.list &&
          exception == other.exception;

  @override
  int get hashCode => list.hashCode ^ exception.hashCode;

  @override
  String toString() {
    return 'AddEntryState{list: $list}';
  }
}
