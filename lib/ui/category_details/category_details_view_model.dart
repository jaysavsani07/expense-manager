import 'package:expense_manager/data/models/category.dart' as cat;
import 'package:expense_manager/data/models/entry_list.dart';
import 'package:expense_manager/data/repository/entry_repository_imp.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final categoryDetailsModelProvider = StreamProvider.autoDispose
    .family<List<EntryList>, String>((ref, categoryName) {
  return ref
      .read(repositoryProvider)
      .getAllEntryByCategory(categoryName)
      .map((event) {
    print(event
        .map((e) => e.list
            .map((e) => e.amount)
            .reduce((value, element) => value + element))
        .reduce((value, element) => value > element ? value : element));
    return event;
  });
});

class CategoryDetailsViewModel with ChangeNotifier {
  EntryRepositoryImp entryDataSourceImp;
  final Reader reader;
  final cat.Category category;
  List<EntryList> categoryList = [];

  CategoryDetailsViewModel({@required this.reader, @required this.category}) {
    entryDataSourceImp.getAllEntryByCategory("").listen((event) {
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
