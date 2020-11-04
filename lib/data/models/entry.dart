import 'package:expense_manager/data/datasource/local/model/app_database.dart';
import 'package:meta/meta.dart';

@immutable
class Entry {
  final double amount;
  final int id;

  Entry({@required this.amount, this.id});

  Entry copyWith({double amount}) {
    return Entry(amount: amount ?? this.amount);
  }

  factory Entry.initial() {
    return Entry(amount: 0);
  }

  factory Entry.fromEntryEntity(EntryEntityData entityData) {
    return Entry(amount: entityData.amount, id: entityData.id);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Entry &&
          runtimeType == other.runtimeType &&
          amount == other.amount;

  @override
  int get hashCode => amount.hashCode;

  @override
  String toString() {
    return 'Entry{amount: $amount}';
  }
}
