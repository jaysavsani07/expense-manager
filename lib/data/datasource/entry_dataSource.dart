import 'package:expense_manager/data/models/category.dart';
import 'package:expense_manager/data/models/category_with_entry_list.dart';
import 'package:expense_manager/data/models/category_with_sum.dart';
import 'package:expense_manager/data/models/entry.dart';
import 'package:expense_manager/data/models/entry_list.dart';
import 'package:expense_manager/data/models/history.dart';

abstract class EntryDataSource {
  Stream<List<String>> getMonthList();

  Stream<List<String>> getExpenseMonthListByYear(int year);
  Stream<List<String>> getIncomeMonthListByYear(int year);
  Stream<List<String>> getAllMonthListByYear(int year);

  Stream<List<int>> getExpenseYearList();
  Stream<List<int>> getIncomeYearList();
  Stream<List<int>> getAllYearList();

  Stream<int> addExpenseEntry(Entry entry);
  Stream<int> addIncomeEntry(Entry entry);

  Stream<bool> updateExpenseEntry(Entry entry);
  Stream<bool> updateIncomeEntry(Entry entry);

  Stream<int> deleteExpenseEntry(int id);
  Stream<int> deleteIncomeEntry(int id);

  Stream<List<Entry>> getAllExpenseEntry();
  Stream<List<Entry>> getAllIncomeEntry();

  Stream<List<EntryList>> getAllEntryByCategory(int categoryName);

  Stream<List<CategoryWithEntryList>> getAllEntryWithCategory(
      DateTime start, DateTime end);

  Stream<List<History>> getAllEntryWithCategoryDateWise(
      DateTime start, DateTime end);

  Stream<List<History>> getExpenseEntryWithCategoryDateWiseByMonthAndYear(
      int month, int year);
  Stream<List<History>> getIncomeEntryWithCategoryDateWiseByMonthAndYear(
      int month, int year);
  Stream<List<History>> getAllEntryWithCategoryDateWiseByMonthAndYear(
      int month, int year);

  Stream<int> addExpenseCategory(Category category);
  Stream<int> addIncomeCategory(Category category);

  Stream<bool> updateExpenseCategory(Category category);
  Stream<bool> updateIncomeCategory(Category category);

  Stream<int> deleteExpenseCategory(int id);
  Stream<int> deleteIncomeCategory(int id);

  Stream<bool> reorderCategory(int oldIndex, int newIndex);

  Stream<List<Category>> getAllExpenseCategory();
  Stream<List<Category>> getAllIncomeCategory();

  Stream<List<CategoryWithSum>> getAllCategoryWithSum();

  Stream<List<CategoryWithSum>> getAllCategoryWithSumByMonth(
      int month, int year);

  Stream<List<CategoryWithSum>> getAllCategoryWithSumByYear(int year);
}
