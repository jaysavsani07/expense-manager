import 'package:expense_manager/core/constants.dart';
import 'package:expense_manager/data/datasource/entry_dataSource.dart';
import 'package:expense_manager/data/datasource/local/moor/app_database.dart';
import 'package:expense_manager/data/models/category.dart';
import 'package:expense_manager/data/models/category_with_sum.dart';
import 'package:expense_manager/data/models/entry.dart';
import 'package:expense_manager/data/models/entry_with_category.dart';
import 'package:expense_manager/data/models/history.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moor/moor.dart';
import 'package:expense_manager/extension/datetime_extension.dart';

final dataSourceProvider = Provider(
        (ref) =>
        EntryDataSourceImp(appDatabase: ref.read(appDatabaseProvider)));

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
  Stream<bool> updateEntry(Entry entry) {
    return appDatabase.updateEntry(entry.toEntryEntityCompanion());
  }

  @override
  Stream<int> addNewCategory(Category category) {
    return appDatabase.addNewCategory1(category.toCategoryEntityCompanion());
  }

  @override
  Stream<bool> updateCategory(Category category) {
    return appDatabase.updateCategory(category.toCategoryEntityCompanion());
  }

  @override
  Stream<int> deleteCategory(int id) {
    return appDatabase.deleteCategory(id);
  }

  @override
  Stream<List<Category>> getAllCategory() {
    return appDatabase.getAllCategory().map(
            (event) =>
            event.map((e) => Category.fromCategoryEntity(e)).toList());
  }

  @override
  Stream<List<CategoryWithSum>> getAllEntryWithCategory() {
    return appDatabase.getAllEntryWithCategory().map((event) =>
        event
            .map((e) => CategoryWithSum.fromCategoryWithSumEntity(e))
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

  @override
  Stream<List<History>> getDateWiseAllEntryWithCategoryByMonth(int month) {
    return appDatabase
        .getDateWiseAllEntryWithCategoryByMonth(month)
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

  @override
  Stream<List<String>> getMonthList() {
    return appDatabase
        .getMonthList()
        .map((event) => event.map((e) => AppConstants.monthList[e]).toList());
  }

  @override
  Stream<bool> reorderCategory(int oldIndex, int newIndex) {
    return appDatabase.reorderCategory(oldIndex, newIndex);
  }
}
