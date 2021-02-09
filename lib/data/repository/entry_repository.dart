import 'package:expense_manager/data/models/category.dart';
import 'package:expense_manager/data/models/category_with_sum.dart';
import 'package:expense_manager/data/models/entry.dart';
import 'package:expense_manager/data/models/history.dart';

abstract class EntryRepository {
  Stream<List<Entry>> getAllEntry();

  Stream<int> addNewEntry(Entry entry);
  Stream<bool> updateEntry(Entry entry);

  Stream<List<Category>> getAllCategory();

  Stream<int> addNewCategory(Category category);
  Stream<bool> updateCategory(Category category);
  Stream<int> deleteCategory(int id);

  Stream<List<CategoryWithSum>> getAllEntryWithCategory();

  Stream<List<History>> getDateWiseAllEntryWithCategory();
  Stream<List<History>> getDateWiseAllEntryWithCategoryByMonth(int month);
  Stream<List<String>> getMonthList();

  Stream<bool> reorderCategory(int oldIndex,int newIndex);

}
