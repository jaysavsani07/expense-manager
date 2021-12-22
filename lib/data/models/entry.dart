import 'package:expense_manager/data/datasource/local/moor/app_database.dart';
import 'package:meta/meta.dart';
import 'package:moor/moor.dart';

@immutable
class Entry {
  final double amount;
  final int id;
  final int categoryId;
  final DateTime modifiedDate;
  final String description;

  Entry({
    this.id,
    @required this.amount,
    @required this.categoryId,
    @required this.modifiedDate,
    @required this.description,
  });

  Entry copyWith({
    double amount,
    String categoryName,
    DateTime modifiedDate,
    String description,
  }) {
    return Entry(
        amount: amount ?? this.amount,
        categoryId: categoryName ?? this.categoryId,
        modifiedDate: modifiedDate ?? this.modifiedDate,
        description: description ?? this.description);
  }

  factory Entry.fromEntryEntity(EntryEntityData entityData) {
    return Entry(
        id: entityData.id,
        amount: entityData.amount,
        categoryId: entityData.categoryId,
        modifiedDate: entityData.modifiedDate,
        description: entityData.description);
  }

  factory Entry.fromIncomeEntryEntity(IncomeEntryEntityData incomeEntityData) {
    return Entry(
        id: incomeEntityData.id,
        amount: incomeEntityData.amount,
        categoryId: incomeEntityData.categoryId,
        modifiedDate: incomeEntityData.modifiedDate,
        description: incomeEntityData.description);
  }

  EntryEntityCompanion toEntryEntityCompanion() {
    return EntryEntityCompanion(
        id: id == null ? Value.absent() : Value(id),
        amount: Value(amount),
        categoryId: categoryId == null ? Value.absent() : Value(categoryId),
        modifiedDate: Value(modifiedDate),
        description: Value(description));
  }

  IncomeEntryEntityCompanion toIncomeEntryEntityCompanion() {
    return IncomeEntryEntityCompanion(
        id: id == null ? Value.absent() : Value(id),
        amount: Value(amount),
        categoryId: categoryId == null ? Value.absent() : Value(categoryId),
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
          categoryId == other.categoryId &&
          modifiedDate == other.modifiedDate &&
          description == other.description;

  @override
  int get hashCode =>
      amount.hashCode ^
      id.hashCode ^
      categoryId.hashCode ^
      modifiedDate.hashCode ^
      description.hashCode;

  @override
  String toString() {
    return 'Entry{amount: $amount, id: $id, categoryId: $categoryId, modifiedDate: $modifiedDate, description: $description}';
  }
}
