import 'package:expense_manager/data/datasource/local/model/app_database.dart';
import 'package:expense_manager/data/models/category.dart';
import 'package:expense_manager/data/models/entry.dart';
import 'package:flutter/material.dart';

class EntryWithCategory {
  final Entry entry;
  final Category category;

  EntryWithCategory({@required this.entry, @required this.category});

  factory EntryWithCategory.fromEntryEntity(EntryWithCategoryData entityData) {
    return EntryWithCategory(
        entry: Entry.fromEntryEntity(entityData.entry),
        category: Category.fromCategoryEntity(entityData.category));
  }

  @override
  String toString() {
    return 'EntryWithCategory{entry: ${entry.toString()}, category: ${category.toString()}';
  }
}
