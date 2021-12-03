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
  Stream<int> addIncomeEntry(Entry entry) {
    return appDatabase.addIncomeEntry(entry.toIncomeEntryEntityCompanion());
  }

  @override
  Stream<bool> updateEntry(Entry entry) {
    return appDatabase.updateEntry(entry.toEntryEntityCompanion());
  }

  @override
  Stream<bool> updateIncomeEntry(Entry entry) {
    return appDatabase.updateIncomeEntry(entry.toIncomeEntryEntityCompanion());
  }

  @override
  Stream<int> deleteEntry(int id) {
    return appDatabase.deleteEntry(id);
  }

  @override
  Stream<int> deleteIncomeEntry(int id) {
    return appDatabase.deleteIncomeEntry(id);
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
  Stream<List<Entry>> getAllIncomeEntry() {
    return appDatabase
        .getAllIncomeEntry()
        .expand((element) => element)
        .map((event) => Entry.fromIncomeEntryEntity(event))
        .toList()
        .asStream();
  }

  @override
  Stream<List<EntryList>> getAllEntryByCategory(int categoryName) {
    return appDatabase
        .getAllEntryByCategory(categoryName)
        .map((event) => event.map((e) => Entry.fromEntryEntity(e)))
        .map((event) => groupBy(event, (Entry e) => e.modifiedDate.toTitle()))
        .map((list) => list.entries
            .map((e) => EntryList(title: e.key, list: e.value))
            .toList());
  }

  @override
  Stream<List<CategoryWithEntryList>> getAllEntryWithCategory(
      DateTime start, DateTime end) {
    return appDatabase
        .getAllEntryWithCategory(start, end)
        .map((event) =>
            event.map((e) => EntryWithCategory.fromEntryWithCategoryEntity(e)))
        .map((event) => groupBy(event, (EntryWithCategory e) => e.category))
        .map((list) => list.entries
            .map((e) => CategoryWithEntryList(
                category: e.key,
                total: e.value.map((e) => e.entry.amount).fold(
                    0, (previousValue, element) => previousValue + element),
                entry: e.value.map((e) => e.entry).toList()))
            .toList());
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
  Stream<List<History>> getAllEntryWithCategoryDateWiseByMonth(
      int month, int year) {
    return appDatabase
        .getAllEntryWithCategoryByMonth(month, year)
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
    return appDatabase.addCategory(category.toCategoryEntityCompanion());
  }

  @override
  Stream<int> addIncomeCategory(Category category) {
    return appDatabase
        .addIncomeCategory(category.toIncomeCategoryEntityCompanion());
  }

  @override
  Stream<bool> updateCategory(Category category) {
    return appDatabase.updateCategory(category.toCategoryEntityCompanion());
  }

  @override
  Stream<bool> updateIncomeCategory(Category category) {
    return appDatabase
        .updateIncomeCategory(category.toIncomeCategoryEntityCompanion());
  }

  @override
  Stream<int> deleteCategory(int id) {
    return appDatabase.deleteCategory(id);
  }

  @override
  Stream<int> deleteIncomeCategory(int id) {
    return appDatabase.deleteIncomeCategory(id);
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
  Stream<List<Category>> getAllIncomeCategory() {
    return appDatabase.getAllIncomeCategory().map((event) =>
        event.map((e) => Category.fromIncomeCategoryEntity(e)).toList());
  }

  @override
  Stream<List<CategoryWithSum>> getAllCategoryWithSum() {
    return appDatabase.getAllCategoryWithSum().map((event) => event
        .map((e) => CategoryWithSum.fromCategoryWithSumEntity(e))
        .toList());
  }

  @override
  Stream<List<CategoryWithSum>> getAllCategoryWithSumByMonth(
      int month, int year) {
    return appDatabase.getAllCategoryWithSumByMonth(month, year).map((event) =>
        event
            .map((e) => CategoryWithSum.fromCategoryWithSumEntity(e))
            .toList());
  }

  @override
  Stream<List<CategoryWithSum>> getAllCategoryWithSumByYear(int year) {
    return appDatabase.getAllCategoryWithSumByYear(year).map((event) => event
        .map((e) => CategoryWithSum.fromCategoryWithSumEntity(e))
        .toList());
  }
}
