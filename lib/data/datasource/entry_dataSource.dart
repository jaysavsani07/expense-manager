import 'package:expense_manager/data/models/entry.dart';

abstract class EntryDataSource {
  Stream<List<Entry>> getAllEntry();

  Stream<int> addNewEntry(Entry entry);
}
