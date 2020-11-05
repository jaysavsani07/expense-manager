import 'package:expense_manager/data/datasource/local/model/app_database.dart';
import 'package:meta/meta.dart';
import 'package:moor/moor.dart';

@immutable
class Entry {
  final double amount;
  final int id;
  final String categoryName;

  Entry({this.id, @required this.amount, @required this.categoryName});

  Entry copyWith({double amount, String categoryName}) {
    return Entry(
        amount: amount ?? this.amount,
        categoryName: categoryName ?? this.categoryName);
  }

  factory Entry.initial() {
    return Entry(amount: 0, categoryName: "");
  }

  factory Entry.fromEntryEntity(EntryEntityData entityData) {
    return Entry(
        id: entityData.id,
        amount: entityData.amount,
        categoryName: entityData.categoryName);
  }

  EntryEntityCompanion toEntryEntityCompanion() {
    return EntryEntityCompanion(
        amount: Value(amount), categoryName: Value(categoryName));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Entry &&
          runtimeType == other.runtimeType &&
          amount == other.amount &&
          id == other.id &&
          categoryName == other.categoryName;

  @override
  int get hashCode => amount.hashCode ^ id.hashCode ^ categoryName.hashCode;

  @override
  String toString() {
    return 'Entry{amount: $amount, id: $id, categoryName: $categoryName}';
  }
}
