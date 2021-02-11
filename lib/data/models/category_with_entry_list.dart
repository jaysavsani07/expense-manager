import 'package:expense_manager/data/datasource/local/moor/app_database.dart';
import 'package:expense_manager/data/models/category.dart';
import 'package:expense_manager/data/models/entry.dart';
import 'package:flutter/material.dart';

class CategoryWithEntryList {
  final Category category;
  final double total;
  final double maxAmount;
  final int numberOfEntry;
  final List<Entry> entry;

  CategoryWithEntryList({
    @required this.category,
    @required this.total,
    @required this.maxAmount,
    @required this.numberOfEntry,
    @required this.entry,
  });

  CategoryWithEntryList copyWith(
      {List<Entry> entry,
      double total,
      double maxAmount,
      int numberOfEntry,
      Category category}) {
    return CategoryWithEntryList(
      category: category ?? this.category,
      total: total ?? this.total,
      maxAmount: maxAmount ?? this.maxAmount,
      numberOfEntry: numberOfEntry ?? this.numberOfEntry,
      entry: entry ?? this.entry,
    );
  }

  @override
  String toString() {
    return 'CategoryWithEntry{category: $category, total: $total, maxAmount: $maxAmount, numberOfEntry: $numberOfEntry, entry: $entry}';
  }
}
