import 'package:expense_manager/data/models/category.dart';
import 'package:expense_manager/data/models/entry.dart';
import 'package:flutter/material.dart';

class CategoryWithEntryList {
  final Category category;
  final double total;
  final List<Entry> entry;

  CategoryWithEntryList({
    @required this.category,
    @required this.total,
    @required this.entry,
  });

  CategoryWithEntryList copyWith(
      {List<Entry> entry, double total, Category category}) {
    return CategoryWithEntryList(
      category: category ?? this.category,
      total: total ?? this.total,
      entry: entry ?? this.entry,
    );
  }

  @override
  String toString() {
    return 'CategoryWithEntry{category: $category, total: $total, entry: $entry}';
  }
}
