import 'package:expense_manager/data/datasource/local/model/app_database.dart';
import 'package:flutter/foundation.dart';

class EntryWithCategory {
  final EntryEntityData entry;
  final CategoryEntityData category;

  EntryWithCategory({@required this.entry, @required this.category});

  @override
  String toString() {
    return 'EntryWithCategory{entry: ${entry.toString()}, category: ${category.toString()}';
  }
}
