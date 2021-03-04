import 'package:expense_manager/data/datasource/local/moor/app_database.dart';
import 'package:meta/meta.dart';
import 'package:moor/moor.dart';

@immutable
class Entry {
  final double amount;
  final int id;
  final int categoryName;
  final DateTime modifiedDate;
  final String description;

  Entry(
      {this.id,
      @required this.amount,
      @required this.categoryName,
      @required this.modifiedDate,
      @required this.description});

  Entry copyWith(
      {double amount,
      String categoryName,
      DateTime modifiedDate,
      String description}) {
    return Entry(
        amount: amount ?? this.amount,
        categoryName: categoryName ?? this.categoryName,
        modifiedDate: modifiedDate ?? this.modifiedDate,
        description: description ?? this.description);
  }

  factory Entry.fromEntryEntity(EntryEntityData entityData) {
    return Entry(
        id: entityData.id,
        amount: entityData.amount,
        categoryName: entityData.categoryName,
        modifiedDate: entityData.modifiedDate,
        description: entityData.description);
  }

  EntryEntityCompanion toEntryEntityCompanion() {
    return EntryEntityCompanion(
        id: id == null ? Value.absent() : Value(id),
        amount: Value(amount),
        categoryName: categoryName == null ? Value.absent() :  Value(categoryName),
        modifiedDate: Value(modifiedDate),
        description: Value(description));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Entry &&
          runtimeType == other.runtimeType &&
          amount == other.amount &&
          id == other.id &&
          categoryName == other.categoryName &&
          modifiedDate == other.modifiedDate &&
          description == other.description;

  @override
  int get hashCode =>
      amount.hashCode ^
      id.hashCode ^
      categoryName.hashCode ^
      modifiedDate.hashCode ^
      description.hashCode;

  @override
  String toString() {
    return 'Entry{amount: $amount, id: $id, categoryName: $categoryName, modifiedDate: $modifiedDate, description: $description}';
  }
}
