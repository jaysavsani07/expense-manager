import 'package:expense_manager/data/models/history.dart';
import 'package:expense_manager/data/repository/entry_repository_imp.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final historyModelProvider = ChangeNotifierProvider<HistoryViewModel>(
  (ref) => HistoryViewModel(entryDataSourceImp: ref.read(repositoryProvider)),
);

class HistoryViewModel with ChangeNotifier {
  EntryRepositoryImp entryDataSourceImp;

  List<History> list = [];

  HistoryViewModel({@required this.entryDataSourceImp}) {
    entryDataSourceImp.getDateWiseAllEntryWithCategory().listen((event) {
      list = event;
      notifyListeners();
    });
  }
}
