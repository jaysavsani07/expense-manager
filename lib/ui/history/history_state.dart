import 'package:expense_manager/data/models/history.dart';
import 'package:flutter/material.dart';

@immutable
class HistoryState {
  final List<History> list;

  HistoryState({@required this.list});

  factory HistoryState.initial() {
    return HistoryState(list: []);
  }

  HistoryState copyWith({List<History> list}) {
    return HistoryState(list: list ?? this.list);
  }

}
