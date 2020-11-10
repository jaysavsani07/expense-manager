import 'package:expense_manager/data/models/history.dart';

class HistoryDataChangeAction {
  final List<History> list;

  HistoryDataChangeAction(this.list);

  @override
  String toString() {
    return 'HistoryDataChangeAction{list: $list}';
  }
}
