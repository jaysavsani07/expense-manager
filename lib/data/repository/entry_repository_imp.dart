import 'package:expense_manager/data/datasource/local/entry_datasource_imp.dart';
import 'package:expense_manager/data/models/category.dart';
import 'package:expense_manager/data/models/category_with_sum.dart';
import 'package:expense_manager/data/models/entry.dart';
import 'package:expense_manager/data/models/history.dart';
import 'package:expense_manager/data/repository/entry_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moor/moor.dart';

final repositoryProvider = Provider((ref) =>
    EntryRepositoryImp(entryDataSourceImp: ref.read(dataSourceProvider)));

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
  Stream<bool> updateEntry(Entry entry) {
    return entryDataSourceImp.updateEntry(entry);
  }

  @override
  Stream<int> addNewCategory(Category category) {
    return entryDataSourceImp.addNewCategory(category);
  }

  @override
  Stream<List<Category>> getAllCategory() {
    return entryDataSourceImp.getAllCategory();
  }

  @override
  Stream<bool> updateCategory(Category category) {
    return entryDataSourceImp.updateCategory(category);
  }

  @override
  Stream<List<CategoryWithSum>> getAllEntryWithCategory() {
    return entryDataSourceImp.getAllEntryWithCategory();
  }

  @override
  Stream<List<History>> getDateWiseAllEntryWithCategory() {
    return entryDataSourceImp.getDateWiseAllEntryWithCategory();
  }

  @override
  Stream<bool> reorderCategory(int oldIndex, int newIndex) {
    return entryDataSourceImp.reorderCategory(oldIndex, newIndex);
  }
}
