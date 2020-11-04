import 'package:expense_manager/data/models/entry.dart';

class LoadAllEntryAction {
  @override
  String toString() {
    return 'LoadAllEntry{}';
  }
}

class AllEntryLoadedAction {
  final List<Entry> list;

  AllEntryLoadedAction({this.list});

  @override
  String toString() {
    return 'AllEntryLoadedAction{list: $list}';
  }
}
