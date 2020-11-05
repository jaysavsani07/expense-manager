import 'package:expense_manager/data/models/category.dart';
import 'package:expense_manager/data/models/entry.dart';

abstract class EntryRepository {
  Stream<List<Entry>> getAllEntry();

  Stream<int> addNewEntry(Entry entry);

  Stream<List<Category>> getAllCategory();

  Stream<int> addNewCategory(Category category);
}
