import 'package:expense_manager/data/models/entry.dart';
import 'package:flutter/material.dart';

class EntryList {
  final String title;
  final List<Entry> list;

  EntryList({
    @required this.title,
    @required this.list,
  });

  EntryList copyWith({String title, List<Entry> list}) {
    return EntryList(title: title ?? this.title, list: list ?? this.list);
  }

  @override
  String toString() {
    return 'EntryList{title: $title, list: $list}';
  }
}
