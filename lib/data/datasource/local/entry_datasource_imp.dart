import 'package:collection/collection.dart';
import 'package:expense_manager/core/constants.dart';
import 'package:expense_manager/data/datasource/entry_dataSource.dart';
import 'package:expense_manager/data/datasource/local/moor/app_database.dart';
import 'package:expense_manager/data/models/category.dart';
import 'package:expense_manager/data/models/category_with_entry_list.dart';
import 'package:expense_manager/data/models/category_with_sum.dart';
import 'package:expense_manager/data/models/entry.dart';
import 'package:expense_manager/data/models/entry_list.dart';
import 'package:expense_manager/data/models/entry_with_category.dart';
import 'package:expense_manager/data/models/history.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moor/moor.dart';
import 'package:expense_manager/extension/datetime_extension.dart';

final dataSourceProvider = Provider(
    (ref) => EntryDataSourceImp(appDatabase: ref.read(appDatabaseProvider)));

class EntryDataSourceImp extends EntryDataSource {
  AppDatabase appDatabase;

  EntryDataSourceImp({@required this.appDatabase});

  @override
  Stream<List<String>> getMonthList() {
    return appDatabase
        .getMonthList()
        .map((event) => event.map((e) => AppConstants.monthList[e]).toList());
  }

  @override
  Stream<List<String>> getMonthListByYear(int year) {
    return appDatabase
        .getMonthListByYear(year)
        .map((event) => event.map((e) => AppConstants.monthList[e]).toList());
  }

  @override
  Stream<List<int>> getYearList() {
    return appDatabase.getYearList();
  }

  @override
  Stream<int> addEntry(Entry entry) {
    return appDatabase.addEntry(entry.toEntryEntityCompanion());
  }

  @override
  Stream<bool> updateEntry(Entry entry) {
    return appDatabase.updateEntry(entry.toEntryEntityCompanion());
  }

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
  Stream<List<EntryList>> getAllEntryByCategory(int categoryName) {
    return appDatabase
        .getAllEntryByCategory(categoryName)
        .map((List<EntryEntityData> list) {
      Map<String, EntryList> map = Map();
      String title;
      list.forEach((EntryEntityData data) {
        title = data.modifiedDate.toTitle();
        if (map.containsKey(title)) {
          map[title].list.add(Entry.fromEntryEntity(data));
        } else {
          map[title] =
              EntryList(title: title, list: [Entry.fromEntryEntity(data)]);
        }
      });
      return map;
    }).map((map) => map.values.toList());
  }

  @override
  Stream<List<CategoryWithEntryList>> getAllEntryWithCategory(
      DateTime start, DateTime end) {
    return appDatabase
        .getAllEntryWithCategory(start, end)
        .map((event) =>
            event.map((e) => EntryWithCategory.fromEntryWithCategoryEntity(e)))
        .map((event) {
      Map<String, CategoryWithEntryList> map = Map();

      event.forEach((element) {
        if (map.containsKey(element.category.name)) {
          map[element.category.name].entry.add(element.entry);
        } else {
          map[element.category.name] = CategoryWithEntryList(
              category: element.category,
              total: element.entry.amount,
              entry: [element.entry]);
        }
      });
      return map;
    }).map((map) => map.values.toList());
  }

  @override
  Stream<List<History>> getAllEntryWithCategoryDateWise(
      DateTime start, DateTime end) {
    return appDatabase
        .getAllEntryWithCategory(start, end)
        .map((event) => groupBy(
            event, (EntryWithCategoryData e) => e.entry.modifiedDate.toTitle()))
        .map((list) => list.entries
            .map((e) => History(
                title: e.key,
                list: e.value
                    .map(
                        (e) => EntryWithCategory.fromEntryWithCategoryEntity(e))
                    .toList()))
            .toList());
  }

  @override
  Stream<List<History>> getAllEntryWithCategoryDateWiseByMonth(int month) {
    return appDatabase
        .getAllEntryWithCategoryByMonth(month)
        .map((event) => groupBy(
            event, (EntryWithCategoryData e) => e.entry.modifiedDate.toTitle()))
        .map((list) => list.entries
            .map((e) => History(
                title: e.key,
                list: e.value
                    .map(
                        (e) => EntryWithCategory.fromEntryWithCategoryEntity(e))
                    .toList()))
            .toList());
  }

  @override
  Stream<int> addCategory(Category category) {
    return appDatabase.addCategory1(category.toCategoryEntityCompanion());
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
  Stream<bool> reorderCategory(int oldIndex, int newIndex) {
    return appDatabase.reorderCategory(oldIndex, newIndex);
  }

  @override
  Stream<List<Category>> getAllCategory() {
    return appDatabase.getAllCategory().map(
        (event) => event.map((e) => Category.fromCategoryEntity(e)).toList());
  }

  @override
  Stream<List<CategoryWithSum>> getAllCategoryWithSum() {
    return appDatabase.getAllCategoryWithSum().map((event) => event
        .map((e) => CategoryWithSum.fromCategoryWithSumEntity(e))
        .toList());
  }

  @override
  Stream<List<CategoryWithSum>> getAllLastMonthCategoryWithSum() {
    return appDatabase.getAllLastMonthCategoryWithSum().map((event) => event
        .map((e) => CategoryWithSum.fromCategoryWithSumEntity(e))
        .toList());
  }

  @override
  Stream<List<CategoryWithSum>> getAllLastYearCategoryWithSum() {
    return appDatabase.getAllLastYearCategoryWithSum().map((event) => event
        .map((e) => CategoryWithSum.fromCategoryWithSumEntity(e))
        .toList());
  }
}
