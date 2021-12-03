import 'dart:async';

import 'package:expense_manager/core/constants.dart';
import 'package:expense_manager/data/models/category.dart' as cat;
import 'package:expense_manager/data/repository/entry_repository_imp.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final categoryListModelProvider =
    ChangeNotifierProvider.autoDispose.family<CategoryListViewModel, EntryType>(
  (ref, entryType) => CategoryListViewModel(
      entryDataSourceImp: ref.read(repositoryProvider), entryType: entryType),
);

class CategoryListViewModel with ChangeNotifier {
  EntryRepositoryImp entryDataSourceImp;
  List<cat.Category> expenseCategoryList = [];
  List<cat.Category> incomeCategoryList = [];
  StreamSubscription _expenseSubscription;
  StreamSubscription _incomeSubscription;
  EntryType entryType;

  CategoryListViewModel({
    @required this.entryDataSourceImp,
    @required this.entryType,
  }) {
    _expenseSubscription = entryDataSourceImp.getAllCategory().listen((event) {
      expenseCategoryList = event;
      notifyListeners();
    });
    _incomeSubscription =
        entryDataSourceImp.getAllIncomeCategory().listen((event) {
      incomeCategoryList = event;
      notifyListeners();
    });
  }

  void entryTypeChange(EntryType entryType) {
    this.entryType = entryType;
    notifyListeners();
  }

  void reorder(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    if (oldIndex != newIndex) {
      var x = expenseCategoryList[oldIndex];
      expenseCategoryList.removeAt(oldIndex);
      expenseCategoryList.insert(newIndex, x);
      notifyListeners();
      entryDataSourceImp
          .reorderCategory(oldIndex + 1, newIndex + 1)
          .listen((event) {});
    }
  }

  @override
  void dispose() {
    expenseCategoryList = [];
    incomeCategoryList = [];
    _expenseSubscription.cancel();
    _incomeSubscription.cancel();
    super.dispose();
  }
}
