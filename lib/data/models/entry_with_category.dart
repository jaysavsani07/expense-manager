import 'package:expense_manager/data/datasource/local/moor/app_database.dart';
import 'package:expense_manager/data/models/category.dart';
import 'package:expense_manager/data/models/entry.dart';
import 'package:flutter/material.dart';

class EntryWithCategory {
  final Entry entry;
  final Category category;

  EntryWithCategory({@required this.entry, @required this.category});

  factory EntryWithCategory.fromEntryWithCategoryEntity(
      EntryWithCategoryData entityData) {
    return EntryWithCategory(
        entry: Entry.fromEntryEntity(entityData.entry),
        category: Category.fromCategoryEntity(entityData.category));
  }

  @override
  String toString() {
    return 'EntryWithCategory{entry: ${entry.toString()}, category: ${category.toString()}';
  }
}

class EntryWithCategoryData {
  final EntryEntityData entry;
  final CategoryEntityData category;

  EntryWithCategoryData({@required this.entry, @required this.category});

  @override
  String toString() {
    return 'EntryWithCategoryData{entry: ${entry.toString()}, category: ${category.toString()}';
  }
}
