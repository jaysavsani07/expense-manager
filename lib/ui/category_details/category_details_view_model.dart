import 'dart:async';

import 'package:expense_manager/data/models/category_with_sum.dart';
import 'package:expense_manager/data/repository/entry_repository_imp.dart';
import 'package:expense_manager/ui/history/history_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tuple/tuple.dart';

final categoryDetailsModelProvider =
    ChangeNotifierProvider.autoDispose<CategoryDetailsViewModel>((ref) {
  Tuple2<String, int> filterType =
      ref.watch(categoryDetailsFilterProvider).state;
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
    StateProvider.autoDispose<Tuple2<String, int>>(
        (ref) => Tuple2("Month", DateTime.now().month));

final categoryDetailsYearListProvider =
    StreamProvider<List<Tuple2<String, int>>>((ref) {
  return ref
      .read(yearListProvider.stream)
      .map((event) => event.map((e) => Tuple2("Year", e)))
      .map((event) => [Tuple2("Month", DateTime.now().month), ...event]);
});

class CategoryDetailsViewModel with ChangeNotifier {
  final EntryRepositoryImp entryDataSourceImp;
  final Tuple2<String, int> filterType;
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
