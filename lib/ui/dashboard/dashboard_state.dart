import 'package:expense_manager/data/models/category_with_sum.dart';
import 'package:expense_manager/data/repository/entry_repository_imp.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dashboardViewModelProvider = ChangeNotifierProvider<DashboardViewModel>(
  (ref) => DashboardViewModel(entryDataSourceImp: ref.read(repositoryProvider)),
);

class DashboardViewModel with ChangeNotifier {
  EntryRepositoryImp entryDataSourceImp;

  List<CategoryWithSum> list = [];

  DashboardViewModel({@required this.entryDataSourceImp}) {
    entryDataSourceImp.getAllEntryWithCategory().listen((event) {
      list = event;
      notifyListeners();
    });
  }
}
