import 'package:expense_manager/core/constants.dart';
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
import 'package:tuple/tuple.dart';

final repositoryProvider = Provider((ref) =>
    EntryRepositoryImp(entryDataSourceImp: ref.read(dataSourceProvider)));

class EntryRepositoryImp extends EntryRepository {
  EntryDataSourceImp entryDataSourceImp;

  EntryRepositoryImp({@required this.entryDataSourceImp});

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
  Stream<int> addEntry(EntryType entryType, Entry entry) {
    if (entryType == EntryType.expense) {
      return entryDataSourceImp.addExpenseEntry(entry);
    } else {
      return entryDataSourceImp.addIncomeEntry(entry);
    }
  }

  @override
  Stream<bool> updateEntry(EntryType entryType, Entry entry) {
    if (entryType == EntryType.expense) {
      return entryDataSourceImp.updateExpenseEntry(entry);
    } else {
      return entryDataSourceImp.updateIncomeEntry(entry);
    }
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
  Stream<List<CategoryWithEntryList>> getAllEntryWithCategory(DateTime start,
      DateTime end) {
    return entryDataSourceImp.getAllEntryWithCategory(start, end);
  }

  @override
  Stream<double> getExpanseSumByDateRange(DateTime start, DateTime end) {
    return entryDataSourceImp.getExpanseSumByDateRange(start, end);
  }

  @override
  Stream<double> getIncomeSumByDateRange(DateTime start, DateTime end) {
    return entryDataSourceImp.getIncomeSumByDateRange(start, end);
  }

  @override
  Stream<double> getTodayExpense() {
    return entryDataSourceImp.getTodayExpense();
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
  Stream<int> addCategory(EntryType entryType, Category category) {
    if (entryType == EntryType.expense) {
      return entryDataSourceImp.addExpenseCategory(category);
    } else {
      return entryDataSourceImp.addIncomeCategory(category);
    }
  }

  @override
  Stream<bool> updateCategory(EntryType entryType, Category category) {
    if (entryType == EntryType.expense) {
      return entryDataSourceImp.updateExpenseCategory(category);
    } else {
      return entryDataSourceImp.updateIncomeCategory(category);
    }
  }

  @override
  Stream<int> deleteCategory(EntryType entryType, int id) {
    if (entryType == EntryType.expense) {
      return entryDataSourceImp.deleteExpenseCategory(id);
    } else {
      return entryDataSourceImp.deleteIncomeCategory(id);
    }
  }

  @override
  Stream<bool> reorderCategory(int oldIndex, int newIndex) {
    return entryDataSourceImp.reorderCategory(oldIndex, newIndex);
  }

  @override
  Stream<List<Category>> getAllCategory(EntryType entryType) {
    switch (entryType) {
      case EntryType.expense:
        return entryDataSourceImp.getAllExpenseCategory();

        break;
      case EntryType.income:
        return entryDataSourceImp.getAllIncomeCategory();
        break;
      default:
        return entryDataSourceImp.getAllCategory();
        break;
    }
  }

  @override
  Stream<List<CategoryWithSum>> getCategoryDetails(
      Tuple2<String, int> filterType) {
    if (filterType.item1 == "Month")
      return entryDataSourceImp.getAllCategoryWithSumByMonth(
          filterType.item2, DateTime
          .now()
          .year);
    return entryDataSourceImp.getAllCategoryWithSumByYear(filterType.item2);
  }
}
