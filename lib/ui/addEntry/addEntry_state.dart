import 'package:expense_manager/data/models/category.dart' as category;
import 'package:expense_manager/data/models/entry.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final addEntryModelProvider = ChangeNotifierProvider<AddEntryViewModel>(
  (ref) => AddEntryViewModel(),
);

class AddEntryViewModel with ChangeNotifier {
  Entry entry = Entry(amount: 10, categoryName: "abc", modifiedDate: null);
  List<category.Category> categoryList = [];
}
