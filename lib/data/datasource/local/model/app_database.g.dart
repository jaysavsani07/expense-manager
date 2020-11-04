// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class EntryEntityData extends DataClass implements Insertable<EntryEntityData> {
  final int id;
  final double amount;
  EntryEntityData({@required this.id, @required this.amount});
  factory EntryEntityData.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final doubleType = db.typeSystem.forDartType<double>();
    return EntryEntityData(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      amount:
          doubleType.mapFromDatabaseResponse(data['${effectivePrefix}amount']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || amount != null) {
      map['amount'] = Variable<double>(amount);
    }
    return map;
  }

  EntryEntityCompanion toCompanion(bool nullToAbsent) {
    return EntryEntityCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      amount:
          amount == null && nullToAbsent ? const Value.absent() : Value(amount),
    );
  }

  factory EntryEntityData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return EntryEntityData(
      id: serializer.fromJson<int>(json['id']),
      amount: serializer.fromJson<double>(json['amount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'amount': serializer.toJson<double>(amount),
    };
  }

  EntryEntityData copyWith({int id, double amount}) => EntryEntityData(
        id: id ?? this.id,
        amount: amount ?? this.amount,
      );
  @override
  String toString() {
    return (StringBuffer('EntryEntityData(')
          ..write('id: $id, ')
          ..write('amount: $amount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode, amount.hashCode));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is EntryEntityData &&
          other.id == this.id &&
          other.amount == this.amount);
}

class EntryEntityCompanion extends UpdateCompanion<EntryEntityData> {
  final Value<int> id;
  final Value<double> amount;
  const EntryEntityCompanion({
    this.id = const Value.absent(),
    this.amount = const Value.absent(),
  });
  EntryEntityCompanion.insert({
    this.id = const Value.absent(),
    @required double amount,
  }) : amount = Value(amount);
  static Insertable<EntryEntityData> custom({
    Expression<int> id,
    Expression<double> amount,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (amount != null) 'amount': amount,
    });
  }

  EntryEntityCompanion copyWith({Value<int> id, Value<double> amount}) {
    return EntryEntityCompanion(
      id: id ?? this.id,
      amount: amount ?? this.amount,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EntryEntityCompanion(')
          ..write('id: $id, ')
          ..write('amount: $amount')
          ..write(')'))
        .toString();
  }
}

class $EntryEntityTable extends EntryEntity
    with TableInfo<$EntryEntityTable, EntryEntityData> {
  final GeneratedDatabase _db;
  final String _alias;
  $EntryEntityTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _amountMeta = const VerificationMeta('amount');
  GeneratedRealColumn _amount;
  @override
  GeneratedRealColumn get amount => _amount ??= _constructAmount();
  GeneratedRealColumn _constructAmount() {
    return GeneratedRealColumn(
      'amount',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, amount];
  @override
  $EntryEntityTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'entry_entity';
  @override
  final String actualTableName = 'entry_entity';
  @override
  VerificationContext validateIntegrity(Insertable<EntryEntityData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount'], _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EntryEntityData map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return EntryEntityData.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $EntryEntityTable createAlias(String alias) {
    return $EntryEntityTable(_db, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $EntryEntityTable _entryEntity;
  $EntryEntityTable get entryEntity => _entryEntity ??= $EntryEntityTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [entryEntity];
}
