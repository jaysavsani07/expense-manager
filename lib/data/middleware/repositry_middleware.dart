import 'package:expense_manager/data/models/category_with_sum.dart';
import 'package:expense_manager/data/models/entry_with_category.dart';
import 'package:expense_manager/data/models/history.dart';
import 'package:expense_manager/ui/app/app_state.dart';
import 'package:expense_manager/data/repository/entry_repository.dart';
import 'package:expense_manager/ui/addEntry/addEntry_action.dart';
import 'package:expense_manager/ui/dashboard/dashboard_action.dart';
import 'package:expense_manager/ui/history/history_action.dart';
import 'package:flutter/cupertino.dart';
import 'package:redux/redux.dart';

class RepositoryMiddleware extends MiddlewareClass<AppState> {
  final EntryRepository repository;

  RepositoryMiddleware({@required this.repository});

  @override
  call(Store<AppState> store, action, next) {
    if (action is AddEntryAction) {
      repository.addNewEntry(action.entry).listen((event) {
        // print("ok1234567 ${event}");
        next(SavedEntryAction(action.entry));
      }, onError: (e) {
        print("ok12345 ${e}");
        next(ExceptionAction(e));
      });
    } else if (action is LoadAllEntryAction) {
      repository.getAllEntryWithCategory().listen(
          (List<CategoryWithSum> event) {
        // print("ok1234567 ${event.toString()}");
        next(AllEntryLoadedAction(list: event));
      }, onError: (e) {
        print("ok12345 ${e}");
        next(ExceptionAction(e));
      });

      repository.getDateWiseAllEntryWithCategory().listen(
          (List<History> event) {
        // print("ok1234567 ${event.toString()}");
        next(HistoryDataChangeAction(event));
      }, onError: (e) {
        print("ok12345 ${e}");
        next(ExceptionAction(e));
      });

      repository.getAllCategory().listen((event) {
        // print("ok1234567 ${event.toString()}");
        next(AllCategoryLoadedAction(categoryList: event));
      }, onError: (e) {
        print("ok12345 ${e}");
        next(ExceptionAction(e));
      });
    }
    next(action);
  }
}
