import 'package:expense_manager/data/models/category.dart';
import 'package:expense_manager/data/models/entry.dart';

class AddEntryAction {
  final Entry entry;

  AddEntryAction(this.entry);

  @override
  String toString() {
    return 'AddEntryAction{entry: $entry}';
  }
}

class SavedEntryAction {
  final Entry entry;

  SavedEntryAction(this.entry);

  @override
  String toString() {
    return 'SavedEntryAction{entry: $entry}';
  }
}

class AllCategoryLoadedAction {
  final List<Category> categoryList;

  AllCategoryLoadedAction({this.categoryList});

  @override
  String toString() {
    return 'AllCategoryLoaded{categoryList: $categoryList}';
  }
}

class ExceptionAction {
  final Exception exception;

  ExceptionAction(this.exception);

  @override
  String toString() {
    return 'ExceptionAction{exception: $exception}';
  }
}
