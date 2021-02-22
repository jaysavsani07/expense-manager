import 'package:expense_manager/data/models/entry_with_category.dart';
import 'package:flutter/material.dart';

class History {
  final String title;
  final List<EntryWithCategory> list;

  History({
    @required this.title,
    @required this.list,
  });

  History copyWith({String title, List<EntryWithCategory> list}) {
    return History(title: title ?? this.title, list: list ?? this.list);
  }

  @override
  String toString() {
    return 'History{title: $title, list: $list}';
  }

/*factory History.fromEntryEntity(EntryEntityData entityData) {
    return History(id: entityData.id, amount: entityData.amount);
  }

  EntryEntityCompanion toEntryEntityCompanion() {
    return EntryEntityCompanion(
        amount: Value(amount),
        categoryName: Value(categoryName),
        modifiedDate: Value(modifiedDate));
  }*/

}
