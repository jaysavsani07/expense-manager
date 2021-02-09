import 'package:expense_manager/data/datasource/local/moor/app_database.dart';
import 'package:expense_manager/data/models/category.dart';
import 'package:expense_manager/data/models/entry_with_category.dart';
import 'package:flutter/material.dart';

class CategoryWithSum {
  final double total;
  final Category category;

  CategoryWithSum({
    @required this.total,
    @required this.category,
  });

  CategoryWithSum copyWith({double total, Category category}) {
    return CategoryWithSum(
        total: total ?? this.total, category: category ?? this.category);
  }

  factory CategoryWithSum.initial() {
    return CategoryWithSum(total: 0, category: null);
  }

  @override
  String toString() {
    return 'CategoryWithSum{total: $total, category: $category}';
  }

  factory CategoryWithSum.fromCategoryWithSumEntity(
      CategoryWithSumData entityData) {
    return CategoryWithSum(
        total: entityData.total,
        category: Category.fromCategoryEntity(entityData.category));
  }

  /*EntryEntityCompanion toEntryEntityCompanion() {
    return EntryEntityCompanion(
        amount: Value(amount),
        categoryName: Value(categoryName),
        modifiedDate: Value(modifiedDate));
  }*/
}
