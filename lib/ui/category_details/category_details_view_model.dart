import 'dart:async';

import 'package:expense_manager/core/constants.dart';
import 'package:expense_manager/data/models/category_with_sum.dart';
import 'package:expense_manager/data/repository/entry_repository_imp.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final categoryDetailsModelProvider =
    ChangeNotifierProvider.autoDispose<CategoryDetailsViewModel>((ref) {
  String filterType = ref.watch(categoryDetailsFilterProvider).state;
  return CategoryDetailsViewModel(
      entryDataSourceImp: ref.read(repositoryProvider), filterType: filterType);
});

final categoryDetailsTotalAmountProvider = Provider.autoDispose<double>((ref) {
  return ref
      .watch(categoryDetailsModelProvider)
      .categoryList
      .map((e) => e.total)
      .fold(0.0, (previousValue, element) => previousValue + element);
});

final categoryDetailsFilterProvider =
    StateProvider.autoDispose<String>((ref) => "This Month");

class CategoryDetailsViewModel with ChangeNotifier {
  final EntryRepositoryImp entryDataSourceImp;
  final String filterType;
  List<CategoryWithSum> categoryList = [];
  StreamSubscription _subscription;

  CategoryDetailsViewModel(
      {@required this.entryDataSourceImp, @required this.filterType}) {
    _subscription =
        entryDataSourceImp.getCategoryDetails(filterType).listen((event) {
      categoryList = event;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    categoryList = [];
    _subscription.cancel();
    super.dispose();
  }
}
