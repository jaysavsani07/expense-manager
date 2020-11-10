import 'package:expense_manager/data/datasource/entry_dataSource.dart';
import 'package:expense_manager/data/datasource/local/model/app_database.dart';
import 'package:expense_manager/data/models/category.dart';
import 'package:expense_manager/data/models/entry.dart';
import 'package:expense_manager/data/models/entry_with_category.dart';
import 'package:expense_manager/data/models/history.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:moor/moor.dart';
import 'package:expense_manager/extension/datetime_extension.dart';

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

  @override
  Stream<List<EntryWithCategory>> getAllEntryWithCategory() {
    return appDatabase.getAllEntryWithCategory().map((event) => event
        .map((e) => EntryWithCategory.fromEntryWithCategoryEntity(e))
        .toList());
  }

  @override
  Stream<List<History>> getDateWiseAllEntryWithCategory() {
    return appDatabase
        .getDateWiseAllEntryWithCategory()
        .map((List<EntryWithCategoryData> list) {
      Map<String, History> map = Map();
      String title;
      list.forEach((EntryWithCategoryData data) {
        title = data.entry.modifiedDate.toTitle();
        if (map.containsKey(title)) {
          map[title]
              .list
              .add(EntryWithCategory.fromEntryWithCategoryEntity(data));
        } else {
          map[title] = History(
              title: title,
              list: [EntryWithCategory.fromEntryWithCategoryEntity(data)]);
        }
      });
      return map;
    }).map((map) => map.values.toList());
  }
}
