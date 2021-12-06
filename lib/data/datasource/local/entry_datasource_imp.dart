import 'package:collection/collection.dart';
import 'package:expense_manager/core/constants.dart';
import 'package:expense_manager/data/datasource/entry_dataSource.dart';
import 'package:expense_manager/data/datasource/local/moor/app_database.dart';
import 'package:expense_manager/data/models/category.dart';
import 'package:expense_manager/data/models/category_with_entry_list.dart';
import 'package:expense_manager/data/models/category_with_sum.dart';
import 'package:expense_manager/data/models/entry.dart';
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
  Stream<List<String>> getExpenseMonthListByYear(int year) {
    return appDatabase
        .getExpenseMonthListByYear(year)
        .map((event) => event.map((e) => AppConstants.monthList[e]).toList());
  }

  @override
  Stream<List<String>> getIncomeMonthListByYear(int year) {
    return appDatabase
        .getIncomeMonthListByYear(year)
        .map((event) => event.map((e) => AppConstants.monthList[e]).toList());
  }

  @override
  Stream<List<String>> getAllMonthListByYear(int year) {
    return appDatabase
        .getAllMonthListByYear(year)
        .map((event) => event.map((e) => AppConstants.monthList[e]).toList());
  }

  @override
  Stream<List<int>> getExpenseYearList() {
    return appDatabase.getExpenseYearList();
  }

  @override
  Stream<List<int>> getIncomeYearList() {
    return appDatabase.getIncomeYearList();
  }

  @override
  Stream<List<int>> getAllYearList() {
    return appDatabase.getAllYearList();
  }

  @override
  Stream<int> addExpenseEntry(Entry entry) {
    return appDatabase.addExpenseEntry(entry.toEntryEntityCompanion());
  }

  @override
  Stream<int> addIncomeEntry(Entry entry) {
    return appDatabase.addIncomeEntry(entry.toIncomeEntryEntityCompanion());
  }

  @override
  Stream<bool> updateExpenseEntry(Entry entry) {
    return appDatabase.updateExpenseEntry(entry.toEntryEntityCompanion());
  }

  @override
  Stream<bool> updateIncomeEntry(Entry entry) {
    return appDatabase.updateIncomeEntry(entry.toIncomeEntryEntityCompanion());
  }

  @override
  Stream<int> deleteExpenseEntry(int id) {
    return appDatabase.deleteExpenseEntry(id);
  }

  @override
  Stream<int> deleteIncomeEntry(int id) {
    return appDatabase.deleteIncomeEntry(id);
  }

  @override
  Stream<List<CategoryWithEntryList>> getAllEntryWithCategory(
      DateTime start, DateTime end) {
    return appDatabase
        .getAllEntryWithCategory(start, end)
        .map((event) => event.map(
            (e) => EntryWithCategory.fromExpenseEntryWithCategoryEntity(e)))
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
  Stream<List<History>> getExpenseEntryWithCategoryDateWiseByMonthAndYear(
      int month, int year) {
    return appDatabase
        .getExpenseEntryWithCategoryByMonthAndYear(month, year)
        .map((event) => groupBy(event,
            (EntryWithCategoryExpenseData e) => e.entry.modifiedDate.toTitle()))
        .map((list) => list.entries
            .map((e) => History(
                title: e.key,
                list: e.value
                    .map((e) =>
                        EntryWithCategory.fromExpenseEntryWithCategoryEntity(e))
                    .toList()))
            .toList());
  }

  @override
  Stream<List<History>> getIncomeEntryWithCategoryDateWiseByMonthAndYear(
      int month, int year) {
    return appDatabase
        .getIncomeEntryWithCategoryByMonthAndYear(month, year)
        .map((event) => groupBy(event,
            (EntryWithCategoryIncomeData e) => e.entry.modifiedDate.toTitle()))
        .map((list) => list.entries
            .map((e) => History(
                title: e.key,
                list: e.value
                    .map((e) =>
                        EntryWithCategory.fromIncomeEntryWithCategoryEntity(e))
                    .toList()))
            .toList());
  }

  @override
  Stream<List<History>> getAllEntryWithCategoryDateWiseByMonthAndYear(
      int month, int year) {
    return appDatabase
        .getAllEntryWithCategoryByMonthAndYear(month, year)
        .map((event) => groupBy(event,
            (EntryWithCategoryAllData e) => e.entry.modifiedDate.toTitle()))
        .map((list) => list.entries
            .map((e) => History(
                title: e.key,
                list: e.value
                    .map((e) =>
                        EntryWithCategory.fromAllEntryWithCategoryEntity(
                            e, e.entryType))
                    .toList()))
            .toList());
  }

  @override
  Stream<int> addExpenseCategory(Category category) {
    return appDatabase.addExpenseCategory(category.toCategoryEntityCompanion());
  }

  @override
  Stream<int> addIncomeCategory(Category category) {
    return appDatabase
        .addIncomeCategory(category.toIncomeCategoryEntityCompanion());
  }

  @override
  Stream<bool> updateExpenseCategory(Category category) {
    return appDatabase
        .updateExpenseCategory(category.toCategoryEntityCompanion());
  }

  @override
  Stream<bool> updateIncomeCategory(Category category) {
    return appDatabase
        .updateIncomeCategory(category.toIncomeCategoryEntityCompanion());
  }

  @override
  Stream<int> deleteExpenseCategory(int id) {
    return appDatabase.deleteExpenseCategory(id);
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
  Stream<List<Category>> getAllExpenseCategory() {
    return appDatabase.getAllExpenseCategory().map(
        (event) => event.map((e) => Category.fromCategoryEntity(e)).toList());
  }

  @override
  Stream<List<Category>> getAllIncomeCategory() {
    return appDatabase.getAllIncomeCategory().map((event) =>
        event.map((e) => Category.fromIncomeCategoryEntity(e)).toList());
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
