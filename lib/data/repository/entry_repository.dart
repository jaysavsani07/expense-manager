import 'package:expense_manager/data/models/category.dart';
import 'package:expense_manager/data/models/category_with_entry_list.dart';
import 'package:expense_manager/data/models/category_with_sum.dart';
import 'package:expense_manager/data/models/entry.dart';
import 'package:expense_manager/data/models/entry_list.dart';
import 'package:expense_manager/data/models/history.dart';
import 'package:tuple/tuple.dart';

abstract class EntryRepository {
  Stream<List<String>> getMonthList();

  Stream<List<String>> getMonthListByYear(int year);

  Stream<List<int>> getYearList();

  Stream<int> addEntry(Entry entry);
  Stream<int> addIncomeEntry(Entry entry);

  Stream<bool> updateEntry(Entry entry);
  Stream<bool> updateIncomeEntry(Entry entry);

  Stream<int> deleteEntry(int id);
  Stream<int> deleteIncomeEntry(int id);

  Stream<List<Entry>> getAllEntry();
  Stream<List<Entry>> getAllIncomeEntry();

  Stream<List<EntryList>> getAllEntryByCategory(int categoryName);

  Stream<List<CategoryWithEntryList>> getAllEntryWithCategory(
      DateTime start, DateTime end);

  Stream<List<History>> getAllEntryWithCategoryDateWise(
      DateTime start, DateTime end);

  Stream<List<History>> getAllEntryWithCategoryDateWiseByMonth(
      int month, int year);

  Stream<int> addCategory(Category category);
  Stream<int> addIncomeCategory(Category category);

  Stream<bool> updateCategory(Category category);
  Stream<bool> updateIncomeCategory(Category category);

  Stream<int> deleteCategory(int id);
  Stream<int> deleteIncomeCategory(int id);

  Stream<bool> reorderCategory(int oldIndex, int newIndex);

  Stream<List<Category>> getAllCategory();
  Stream<List<Category>> getAllIncomeCategory();

  Stream<List<CategoryWithSum>> getAllCategoryWithSum();

  Stream<List<CategoryWithSum>> getCategoryDetails(
      Tuple2<String, int> filterType);
}
