import 'dart:async';

import 'package:expense_manager/data/models/category.dart' as cat;
import 'package:expense_manager/data/repository/entry_repository_imp.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final categoryListModelProvider =
    ChangeNotifierProvider.autoDispose<CategoryListViewModel>(
  (ref) =>
      CategoryListViewModel(entryDataSourceImp: ref.read(repositoryProvider)),
);

class CategoryListViewModel with ChangeNotifier {
  EntryRepositoryImp entryDataSourceImp;
  List<cat.Category> categoryList = [];
  StreamSubscription _subscription;

  CategoryListViewModel({@required this.entryDataSourceImp}) {
    _subscription = entryDataSourceImp.getAllCategory().listen((event) {
      categoryList = event;
      notifyListeners();
    });
  }

  void reorder(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    if (oldIndex != newIndex) {
      var x = categoryList[oldIndex];
      categoryList.removeAt(oldIndex);
      categoryList.insert(newIndex, x);
      notifyListeners();
      entryDataSourceImp
          .reorderCategory(oldIndex + 1, newIndex + 1)
          .listen((event) {});
    }
  }

  @override
  void dispose() {
    categoryList = [];
    _subscription.cancel();
    super.dispose();
  }
}
