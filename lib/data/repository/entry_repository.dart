import 'package:expense_manager/data/models/category.dart';
import 'package:expense_manager/data/models/category_with_sum.dart';
import 'package:expense_manager/data/models/entry.dart';
import 'package:expense_manager/data/models/entry_with_category.dart';
import 'package:expense_manager/data/models/history.dart';

abstract class EntryRepository {
  Stream<List<Entry>> getAllEntry();

  Stream<int> addNewEntry(Entry entry);

  Stream<List<Category>> getAllCategory();

  Stream<int> addNewCategory(Category category);

  Stream<List<CategoryWithSum>> getAllEntryWithCategory();

  Stream<List<History>> getDateWiseAllEntryWithCategory();
}
