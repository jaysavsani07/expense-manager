import 'package:expense_manager/core/constants.dart';
import 'package:expense_manager/data/datasource/local/entry_datasource_imp.dart';
import 'package:expense_manager/data/models/category.dart';
import 'package:expense_manager/data/models/category_with_entry_list.dart';
import 'package:expense_manager/data/models/category_with_sum.dart';
import 'package:expense_manager/data/models/entry.dart';
import 'package:expense_manager/data/models/entry_list.dart';
import 'package:expense_manager/data/models/history.dart';
import 'package:expense_manager/data/repository/entry_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moor/moor.dart';
import 'package:tuple/tuple.dart';

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
  Stream<List<String>> getMonthListByYear(EntryType entryType, int year) {
    switch (entryType) {
      case EntryType.expense:
        return entryDataSourceImp.getExpenseMonthListByYear(year);
        break;
      case EntryType.income:
        return entryDataSourceImp.getIncomeMonthListByYear(year);
        break;
      default:
        return entryDataSourceImp.getAllMonthListByYear(year);
        break;
    }
  }

  @override
  Stream<List<int>> getYearList(EntryType entryType) {
    switch (entryType) {
      case EntryType.expense:
        return entryDataSourceImp.getExpenseYearList();
        break;
      case EntryType.income:
        return entryDataSourceImp.getIncomeYearList();
        break;
      default:
        return entryDataSourceImp.getAllYearList();
        break;
    }
  }

  @override
  Stream<int> addEntry(Entry entry) {
    return entryDataSourceImp.addExpenseEntry(entry);
  }

  @override
  Stream<int> addIncomeEntry(Entry entry) {
    return entryDataSourceImp.addIncomeEntry(entry);
  }

  @override
  Stream<bool> updateEntry(Entry entry) {
    return entryDataSourceImp.updateExpenseEntry(entry);
  }

  @override
  Stream<bool> updateIncomeEntry(Entry entry) {
    return entryDataSourceImp.updateIncomeEntry(entry);
  }

  @override
  Stream<int> deleteEntry(EntryType entryType, int id) {
    if (entryType == EntryType.expense) {
      return entryDataSourceImp.deleteExpenseEntry(id);
    } else {
      return entryDataSourceImp.deleteIncomeEntry(id);
    }
  }

  @override
  Stream<List<Entry>> getAllEntry() {
    return entryDataSourceImp.getAllExpenseEntry();
  }

  @override
  Stream<List<Entry>> getAllIncomeEntry() {
    return entryDataSourceImp.getAllIncomeEntry();
  }

  @override
  Stream<List<EntryList>> getAllEntryByCategory(int categoryName) {
    return entryDataSourceImp.getAllEntryByCategory(categoryName);
  }

  @override
  Stream<List<CategoryWithEntryList>> getAllEntryWithCategory(
      DateTime start, DateTime end) {
    return entryDataSourceImp.getAllEntryWithCategory(start, end);
  }

  @override
  Stream<List<History>> getAllEntryWithCategoryDateWise(
      DateTime start, DateTime end) {
    return entryDataSourceImp.getAllEntryWithCategoryDateWise(start, end);
  }

  @override
  Stream<List<History>> getAllEntryWithCategoryDateWiseByMonthAndYear(
      EntryType entryType, int month, int year) {
    switch (entryType) {
      case EntryType.expense:
        return entryDataSourceImp
            .getExpenseEntryWithCategoryDateWiseByMonthAndYear(month, year);
        break;
      case EntryType.income:
        return entryDataSourceImp
            .getIncomeEntryWithCategoryDateWiseByMonthAndYear(month, year);
        break;
      default:
        return entryDataSourceImp.getAllEntryWithCategoryDateWiseByMonthAndYear(
            month, year);
        break;
    }
  }

  @override
  Stream<int> addCategory(Category category) {
    return entryDataSourceImp.addExpenseCategory(category);
  }

  @override
  Stream<int> addIncomeCategory(Category category) {
    return entryDataSourceImp.addIncomeCategory(category);
  }

  @override
  Stream<bool> updateCategory(Category category) {
    return entryDataSourceImp.updateExpenseCategory(category);
  }

  @override
  Stream<bool> updateIncomeCategory(Category category) {
    return entryDataSourceImp.updateIncomeCategory(category);
  }

  @override
  Stream<int> deleteCategory(int id) {
    return entryDataSourceImp.deleteExpenseCategory(id);
  }

  @override
  Stream<int> deleteIncomeCategory(int id) {
    return entryDataSourceImp.deleteIncomeCategory(id);
  }

  @override
  Stream<bool> reorderCategory(int oldIndex, int newIndex) {
    return entryDataSourceImp.reorderCategory(oldIndex, newIndex);
  }

  @override
  Stream<List<Category>> getAllCategory() {
    return entryDataSourceImp.getAllExpenseCategory();
  }

  @override
  Stream<List<Category>> getAllIncomeCategory() {
    return entryDataSourceImp.getAllIncomeCategory();
  }

  @override
  Stream<List<CategoryWithSum>> getAllCategoryWithSum() {
    return entryDataSourceImp.getAllCategoryWithSum();
  }

  @override
  Stream<List<CategoryWithSum>> getCategoryDetails(
      Tuple2<String, int> filterType) {
    if (filterType.item1 == "Month")
      return entryDataSourceImp.getAllCategoryWithSumByMonth(
          filterType.item2, DateTime.now().year);
    return entryDataSourceImp.getAllCategoryWithSumByYear(filterType.item2);
  }
}
