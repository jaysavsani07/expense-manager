import 'package:expense_manager/data/models/entry.dart';
import 'package:flutter/material.dart';

@immutable
class AddEntryState {
  final Entry entry;
  final Exception exception;

  AddEntryState({@required this.entry, @required this.exception});

  factory AddEntryState.initial() {
    return AddEntryState(entry: Entry.initial(), exception: null);
  }

  AddEntryState copyWith({Entry entry, Exception exception}) {
    return AddEntryState(
        entry: entry ?? this.entry, exception: exception ?? this.exception);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddEntryState &&
          runtimeType == other.runtimeType &&
          entry == other.entry &&
          exception == other.exception;

  @override
  int get hashCode => entry.hashCode ^ exception.hashCode;

  @override
  String toString() {
    return 'AddEntryState{entry: $entry, exception: $exception}';
  }
}
