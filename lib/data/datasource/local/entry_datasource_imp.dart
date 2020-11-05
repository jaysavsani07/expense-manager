import 'package:expense_manager/data/datasource/entry_dataSource.dart';
import 'package:expense_manager/data/datasource/local/model/app_database.dart';
import 'package:expense_manager/data/models/category.dart';
import 'package:expense_manager/data/models/entry.dart';
import 'package:flutter/cupertino.dart';
import 'package:moor/moor.dart';

class EntryDataSourceImp extends EntryDataSource {
  AppDatabase appDatabase;

  EntryDataSourceImp({@required this.appDatabase});

  @override
  Stream<List<Entry>> getAllEntry() {
    return appDatabase
        .getAllEntry()
        .expand((element) => element)
        .map((event) => Entry.fromEntryEntity(event))
        .toList()
        .asStream();
  }

  @override
  Stream<int> addNewEntry(Entry entry) {
    return appDatabase.addNewEntry(entry.toEntryEntityCompanion());
  }

  @override
  Stream<int> addNewCategory(Category category) {
    return appDatabase.addNewCategory(category.toCategoryEntityCompanion());
  }

  @override
  Stream<List<Category>> getAllCategory() {
    return appDatabase
        .getAllCategory()
        .expand((element) => element)
        .map((event) => Category.fromCategoryEntity(event))
        .toList()
        .asStream();
  }
}
