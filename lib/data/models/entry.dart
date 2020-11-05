import 'package:expense_manager/data/datasource/local/model/app_database.dart';
import 'package:meta/meta.dart';
import 'package:moor/moor.dart';

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

  EntryEntityCompanion toEntryEntityCompanion() {
    return EntryEntityCompanion( amount: Value(amount));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Entry &&
          runtimeType == other.runtimeType &&
          amount == other.amount &&
          id == other.id;

  @override
  int get hashCode => amount.hashCode ^ id.hashCode;

  @override
  String toString() {
    return 'Entry{amount: $amount, id: $id}';
  }
}
