import 'package:expense_manager/data/models/category.dart';
import 'package:expense_manager/data/models/category_with_entry_list.dart';
import 'package:expense_manager/data/models/category_with_sum.dart';
import 'package:expense_manager/data/models/entry.dart';
import 'package:expense_manager/data/models/history.dart';

abstract class EntryDataSource {
  Stream<List<String>> getMonthList();

  Stream<List<String>> getMonthListByYear(int year);

  Stream<List<int>> getYearList();

  Stream<int> addEntry(Entry entry);

  Stream<bool> updateEntry(Entry entry);

  Stream<List<Entry>> getAllEntry();

  Stream<List<CategoryWithEntryList>> getAllEntryWithCategory();
  Stream<List<History>> getAllEntryWithCategoryDateWise();

  Stream<List<History>> getAllEntryWithCategoryDateWiseByMonth(int month);

  Stream<int> addCategory(Category category);

  Stream<bool> updateCategory(Category category);

  Stream<int> deleteCategory(int id);

  Stream<bool> reorderCategory(int oldIndex, int newIndex);

  Stream<List<Category>> getAllCategory();

  Stream<List<CategoryWithSum>> getAllCategoryWithSum();
}
