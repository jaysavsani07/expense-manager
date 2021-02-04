import 'package:expense_manager/data/models/history.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final historyModelProvider = ChangeNotifierProvider<HistoryViewModel>(
  (ref) => HistoryViewModel(),
);

class HistoryViewModel with ChangeNotifier {
  List<History> list = [];
}
