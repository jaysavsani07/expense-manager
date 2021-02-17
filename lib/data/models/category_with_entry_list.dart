import 'package:expense_manager/data/models/category.dart';
import 'package:expense_manager/data/models/entry.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CategoryWithEntryList {
  final Category category;
  final double total;
  final double maxY;
  final double maxX;
  final List<Entry> entry;

  CategoryWithEntryList({
    @required this.category,
    @required this.total,
    @required this.maxY,
    @required this.maxX,
    @required this.entry,
  });

  CategoryWithEntryList copyWith(
      {List<Entry> entry,
      double total,
      double maxY,
      double maxX,
      Category category}) {
    return CategoryWithEntryList(
      category: category ?? this.category,
      total: total ?? this.total,
      maxY: maxY ?? this.maxY,
      maxX: maxX ?? this.maxX,
      entry: entry ?? this.entry,
    );
  }

  List<FlSpot> toFlSpotList() {
    return [
      ...this
          .entry
          .asMap()
          .entries
          .map((e) => FlSpot(e.key.toDouble(), e.value.amount))
          .toList(),
      if (this.entry.length < this.maxX)
        for (int i = this.entry.length; i < this.maxX; i++)
          FlSpot(i.toDouble(), 0)
    ];
  }

  @override
  String toString() {
    return 'CategoryWithEntry{category: $category, total: $total, maxAmount: $maxY, numberOfEntry: $maxX, entry: $entry}';
  }
}
