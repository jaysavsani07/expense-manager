import 'package:expense_manager/data/datasource/local/entry_datasource_imp.dart';
import 'package:expense_manager/data/models/category.dart';
import 'package:expense_manager/data/models/entry.dart';
import 'package:expense_manager/data/repository/entry_repository.dart';
import 'package:flutter/material.dart';
import 'package:moor/moor.dart';

class EntryRepositoryImp extends EntryRepository {
  EntryDataSourceImp entryDataSourceImp;

  EntryRepositoryImp({@required this.entryDataSourceImp});

  @override
  Stream<List<Entry>> getAllEntry() {
    return entryDataSourceImp.getAllEntry();
  }

  @override
  Stream<int> addNewEntry(Entry entry) {
    return entryDataSourceImp.addNewEntry(entry);
  }

  @override
  Stream<int> addNewCategory(Category category) {
    return entryDataSourceImp.addNewCategory(category);
  }

  @override
  Stream<List<Category>> getAllCategory() {
    return entryDataSourceImp.getAllCategory();
  }
}
