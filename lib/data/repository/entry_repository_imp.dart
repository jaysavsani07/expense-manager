import 'package:expense_manager/data/datasource/local/entry_datasource_imp.dart';
import 'package:expense_manager/data/models/category.dart';
import 'package:expense_manager/data/models/category_with_entry_list.dart';
import 'package:expense_manager/data/models/category_with_sum.dart';
import 'package:expense_manager/data/models/entry.dart';
import 'package:expense_manager/data/models/history.dart';
import 'package:expense_manager/data/repository/entry_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moor/moor.dart';

final repositoryProvider = Provider((ref) =>
    EntryRepositoryImp(entryDataSourceImp: ref.read(dataSourceProvider)));

class EntryRepositoryImp extends EntryRepository {
  EntryDataSourceImp entryDataSourceImp;

  EntryRepositoryImp({@required this.entryDataSourceImp});

  @override
  Stream<List<String>> getMonthList() {
    return entryDataSourceImp.getMonthList();
  }

  @override
  Stream<List<String>> getMonthListByYear(int year) {
    return entryDataSourceImp.getMonthListByYear(year);
  }

  @override
  Stream<List<int>> getYearList() {
    return entryDataSourceImp.getYearList();
  }

  @override
  Stream<int> addEntry(Entry entry) {
    return entryDataSourceImp.addEntry(entry);
  }

  @override
  Stream<bool> updateEntry(Entry entry) {
    return entryDataSourceImp.updateEntry(entry);
  }

  @override
  Stream<List<Entry>> getAllEntry() {
    return entryDataSourceImp.getAllEntry();
  }

  @override
  Stream<List<CategoryWithEntryList>> getAllEntryWithCategory( DateTime start, DateTime end) {
    return entryDataSourceImp.getAllEntryWithCategory(start, end);
  }

  @override
  Stream<List<History>> getAllEntryWithCategoryDateWise( DateTime start, DateTime end) {
    return entryDataSourceImp.getAllEntryWithCategoryDateWise(start, end);
  }

  @override
  Stream<List<History>> getAllEntryWithCategoryDateWiseByMonth(int month) {
    return entryDataSourceImp.getAllEntryWithCategoryDateWiseByMonth(month);
  }

  @override
  Stream<int> addCategory(Category category) {
    return entryDataSourceImp.addCategory(category);
  }

  @override
  Stream<bool> updateCategory(Category category) {
    return entryDataSourceImp.updateCategory(category);
  }

  @override
  Stream<int> deleteCategory(int id) {
    return entryDataSourceImp.deleteCategory(id);
  }

  @override
  Stream<bool> reorderCategory(int oldIndex, int newIndex) {
    return entryDataSourceImp.reorderCategory(oldIndex, newIndex);
  }

  @override
  Stream<List<Category>> getAllCategory() {
    return entryDataSourceImp.getAllCategory();
  }

  @override
  Stream<List<CategoryWithSum>> getAllCategoryWithSum() {
    return entryDataSourceImp.getAllCategoryWithSum();
  }
}
