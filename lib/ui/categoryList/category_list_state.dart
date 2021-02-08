import 'package:expense_manager/data/models/category.dart' as cat;
import 'package:expense_manager/data/repository/entry_repository_imp.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final categoryListModelProvider = ChangeNotifierProvider<CategoryListViewModel>(
  (ref) =>
      CategoryListViewModel(entryDataSourceImp: ref.read(repositoryProvider)),
);

class CategoryListViewModel with ChangeNotifier {
  EntryRepositoryImp entryDataSourceImp;
  List<cat.Category> categoryList = [];

  CategoryListViewModel({@required this.entryDataSourceImp}) {
    entryDataSourceImp.getAllCategory().listen((event) {
      categoryList = event;
      notifyListeners();
    });
  }

  void reorder(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    entryDataSourceImp.reorderCategory(oldIndex, newIndex).listen((event) {
      notifyListeners();
    });
  }

  @override
  void dispose() {
    categoryList = [];
    super.dispose();
  }
}
