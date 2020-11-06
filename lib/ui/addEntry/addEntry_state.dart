import 'package:expense_manager/data/models/category.dart';
import 'package:expense_manager/data/models/entry.dart';
import 'package:flutter/material.dart';

@immutable
class AddEntryState {
  final Entry entry;
  final List<Category> categoryList;
  final Exception exception;

  AddEntryState(
      {@required this.entry,
      @required this.categoryList,
      @required this.exception});

  factory AddEntryState.initial() {
    return AddEntryState(
        entry: Entry.initial(), categoryList: [], exception: null);
  }

  AddEntryState copyWith(
      {Entry entry, List<Category> categoryList, Exception exception}) {
    return AddEntryState(
        entry: entry ?? this.entry,
        categoryList: categoryList ?? this.categoryList,
        exception: exception ?? this.exception);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddEntryState &&
          runtimeType == other.runtimeType &&
          entry == other.entry &&
          categoryList == other.categoryList &&
          exception == other.exception;

  @override
  int get hashCode =>
      entry.hashCode ^ categoryList.hashCode ^ exception.hashCode;

  @override
  String toString() {
    return 'AddEntryState{entry: $entry, categoryList: $categoryList, exception: $exception}';
  }
}
