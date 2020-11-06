import 'package:expense_manager/data/models/entry.dart';
import 'package:expense_manager/data/models/entry_with_category.dart';

class LoadAllEntryAction {
  @override
  String toString() {
    return 'LoadAllEntry{}';
  }
}

class AllEntryLoadedAction {
  final List<EntryWithCategory> list;

  AllEntryLoadedAction({this.list});

  @override
  String toString() {
    return 'AllEntryLoadedAction{list: $list}';
  }
}
