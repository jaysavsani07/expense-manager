// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class EntryEntityData extends DataClass implements Insertable<EntryEntityData> {
  final int id;
  final double amount;
  final int categoryId;
  final DateTime modifiedDate;
  final String description;
  EntryEntityData(
      {@required this.id,
      @required this.amount,
      this.categoryId,
      @required this.modifiedDate,
      @required this.description});
  factory EntryEntityData.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final doubleType = db.typeSystem.forDartType<double>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    final stringType = db.typeSystem.forDartType<String>();
    return EntryEntityData(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      amount:
          doubleType.mapFromDatabaseResponse(data['${effectivePrefix}amount']),
      categoryId: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}category_id']),
      modifiedDate: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}modified_date']),
      description: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}description']),
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
    if (!nullToAbsent || categoryId != null) {
      map['category_id'] = Variable<int>(categoryId);
    }
    if (!nullToAbsent || modifiedDate != null) {
      map['modified_date'] = Variable<DateTime>(modifiedDate);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    return map;
  }

  EntryEntityCompanion toCompanion(bool nullToAbsent) {
    return EntryEntityCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      amount:
          amount == null && nullToAbsent ? const Value.absent() : Value(amount),
      categoryId: categoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(categoryId),
      modifiedDate: modifiedDate == null && nullToAbsent
          ? const Value.absent()
          : Value(modifiedDate),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
    );
  }

  factory EntryEntityData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return EntryEntityData(
      id: serializer.fromJson<int>(json['id']),
      amount: serializer.fromJson<double>(json['amount']),
      categoryId: serializer.fromJson<int>(json['categoryId']),
      modifiedDate: serializer.fromJson<DateTime>(json['modifiedDate']),
      description: serializer.fromJson<String>(json['description']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'amount': serializer.toJson<double>(amount),
      'categoryId': serializer.toJson<int>(categoryId),
      'modifiedDate': serializer.toJson<DateTime>(modifiedDate),
      'description': serializer.toJson<String>(description),
    };
  }

  EntryEntityData copyWith(
          {int id,
          double amount,
          int categoryId,
          DateTime modifiedDate,
          String description}) =>
      EntryEntityData(
        id: id ?? this.id,
        amount: amount ?? this.amount,
        categoryId: categoryId ?? this.categoryId,
        modifiedDate: modifiedDate ?? this.modifiedDate,
        description: description ?? this.description,
      );
  @override
  String toString() {
    return (StringBuffer('EntryEntityData(')
          ..write('id: $id, ')
          ..write('amount: $amount, ')
          ..write('categoryId: $categoryId, ')
          ..write('modifiedDate: $modifiedDate, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          amount.hashCode,
          $mrjc(categoryId.hashCode,
              $mrjc(modifiedDate.hashCode, description.hashCode)))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is EntryEntityData &&
          other.id == this.id &&
          other.amount == this.amount &&
          other.categoryId == this.categoryId &&
          other.modifiedDate == this.modifiedDate &&
          other.description == this.description);
}

class EntryEntityCompanion extends UpdateCompanion<EntryEntityData> {
  final Value<int> id;
  final Value<double> amount;
  final Value<int> categoryId;
  final Value<DateTime> modifiedDate;
  final Value<String> description;
  const EntryEntityCompanion({
    this.id = const Value.absent(),
    this.amount = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.modifiedDate = const Value.absent(),
    this.description = const Value.absent(),
  });
  EntryEntityCompanion.insert({
    this.id = const Value.absent(),
    @required double amount,
    this.categoryId = const Value.absent(),
    @required DateTime modifiedDate,
    @required String description,
  })  : amount = Value(amount),
        modifiedDate = Value(modifiedDate),
        description = Value(description);
  static Insertable<EntryEntityData> custom({
    Expression<int> id,
    Expression<double> amount,
    Expression<int> categoryId,
    Expression<DateTime> modifiedDate,
    Expression<String> description,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (amount != null) 'amount': amount,
      if (categoryId != null) 'category_id': categoryId,
      if (modifiedDate != null) 'modified_date': modifiedDate,
      if (description != null) 'description': description,
    });
  }

  EntryEntityCompanion copyWith(
      {Value<int> id,
      Value<double> amount,
      Value<int> categoryId,
      Value<DateTime> modifiedDate,
      Value<String> description}) {
    return EntryEntityCompanion(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      categoryId: categoryId ?? this.categoryId,
      modifiedDate: modifiedDate ?? this.modifiedDate,
      description: description ?? this.description,
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
    if (categoryId.present) {
      map['category_id'] = Variable<int>(categoryId.value);
    }
    if (modifiedDate.present) {
      map['modified_date'] = Variable<DateTime>(modifiedDate.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EntryEntityCompanion(')
          ..write('id: $id, ')
          ..write('amount: $amount, ')
          ..write('categoryId: $categoryId, ')
          ..write('modifiedDate: $modifiedDate, ')
          ..write('description: $description')
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

  final VerificationMeta _categoryIdMeta = const VerificationMeta('categoryId');
  GeneratedIntColumn _categoryId;
  @override
  GeneratedIntColumn get categoryId => _categoryId ??= _constructCategoryId();
  GeneratedIntColumn _constructCategoryId() {
    return GeneratedIntColumn('category_id', $tableName, true,
        $customConstraints:
            'NULL REFERENCES category_entity(id) ON DELETE SET NULL');
  }

  final VerificationMeta _modifiedDateMeta =
      const VerificationMeta('modifiedDate');
  GeneratedDateTimeColumn _modifiedDate;
  @override
  GeneratedDateTimeColumn get modifiedDate =>
      _modifiedDate ??= _constructModifiedDate();
  GeneratedDateTimeColumn _constructModifiedDate() {
    return GeneratedDateTimeColumn(
      'modified_date',
      $tableName,
      false,
    );
  }

  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  GeneratedTextColumn _description;
  @override
  GeneratedTextColumn get description =>
      _description ??= _constructDescription();
  GeneratedTextColumn _constructDescription() {
    return GeneratedTextColumn('description', $tableName, false,
        maxTextLength: 100);
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, amount, categoryId, modifiedDate, description];
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
    if (data.containsKey('category_id')) {
      context.handle(
          _categoryIdMeta,
          categoryId.isAcceptableOrUnknown(
              data['category_id'], _categoryIdMeta));
    }
    if (data.containsKey('modified_date')) {
      context.handle(
          _modifiedDateMeta,
          modifiedDate.isAcceptableOrUnknown(
              data['modified_date'], _modifiedDateMeta));
    } else if (isInserting) {
      context.missing(_modifiedDateMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description'], _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
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

class CategoryEntityData extends DataClass
    implements Insertable<CategoryEntityData> {
  final int id;
  final int position;
  final String name;
  final String icon;
  final String iconColor;
  CategoryEntityData(
      {@required this.id,
      @required this.position,
      @required this.name,
      @required this.icon,
      @required this.iconColor});
  factory CategoryEntityData.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return CategoryEntityData(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      position:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}position']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      icon: stringType.mapFromDatabaseResponse(data['${effectivePrefix}icon']),
      iconColor: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}icon_color']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || position != null) {
      map['position'] = Variable<int>(position);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || icon != null) {
      map['icon'] = Variable<String>(icon);
    }
    if (!nullToAbsent || iconColor != null) {
      map['icon_color'] = Variable<String>(iconColor);
    }
    return map;
  }

  CategoryEntityCompanion toCompanion(bool nullToAbsent) {
    return CategoryEntityCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      position: position == null && nullToAbsent
          ? const Value.absent()
          : Value(position),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      icon: icon == null && nullToAbsent ? const Value.absent() : Value(icon),
      iconColor: iconColor == null && nullToAbsent
          ? const Value.absent()
          : Value(iconColor),
    );
  }

  factory CategoryEntityData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return CategoryEntityData(
      id: serializer.fromJson<int>(json['id']),
      position: serializer.fromJson<int>(json['position']),
      name: serializer.fromJson<String>(json['name']),
      icon: serializer.fromJson<String>(json['icon']),
      iconColor: serializer.fromJson<String>(json['iconColor']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'position': serializer.toJson<int>(position),
      'name': serializer.toJson<String>(name),
      'icon': serializer.toJson<String>(icon),
      'iconColor': serializer.toJson<String>(iconColor),
    };
  }

  CategoryEntityData copyWith(
          {int id, int position, String name, String icon, String iconColor}) =>
      CategoryEntityData(
        id: id ?? this.id,
        position: position ?? this.position,
        name: name ?? this.name,
        icon: icon ?? this.icon,
        iconColor: iconColor ?? this.iconColor,
      );
  @override
  String toString() {
    return (StringBuffer('CategoryEntityData(')
          ..write('id: $id, ')
          ..write('position: $position, ')
          ..write('name: $name, ')
          ..write('icon: $icon, ')
          ..write('iconColor: $iconColor')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(position.hashCode,
          $mrjc(name.hashCode, $mrjc(icon.hashCode, iconColor.hashCode)))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is CategoryEntityData &&
          other.id == this.id &&
          other.position == this.position &&
          other.name == this.name &&
          other.icon == this.icon &&
          other.iconColor == this.iconColor);
}

class CategoryEntityCompanion extends UpdateCompanion<CategoryEntityData> {
  final Value<int> id;
  final Value<int> position;
  final Value<String> name;
  final Value<String> icon;
  final Value<String> iconColor;
  const CategoryEntityCompanion({
    this.id = const Value.absent(),
    this.position = const Value.absent(),
    this.name = const Value.absent(),
    this.icon = const Value.absent(),
    this.iconColor = const Value.absent(),
  });
  CategoryEntityCompanion.insert({
    this.id = const Value.absent(),
    @required int position,
    @required String name,
    @required String icon,
    @required String iconColor,
  })  : position = Value(position),
        name = Value(name),
        icon = Value(icon),
        iconColor = Value(iconColor);
  static Insertable<CategoryEntityData> custom({
    Expression<int> id,
    Expression<int> position,
    Expression<String> name,
    Expression<String> icon,
    Expression<String> iconColor,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (position != null) 'position': position,
      if (name != null) 'name': name,
      if (icon != null) 'icon': icon,
      if (iconColor != null) 'icon_color': iconColor,
    });
  }

  CategoryEntityCompanion copyWith(
      {Value<int> id,
      Value<int> position,
      Value<String> name,
      Value<String> icon,
      Value<String> iconColor}) {
    return CategoryEntityCompanion(
      id: id ?? this.id,
      position: position ?? this.position,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      iconColor: iconColor ?? this.iconColor,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (position.present) {
      map['position'] = Variable<int>(position.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (icon.present) {
      map['icon'] = Variable<String>(icon.value);
    }
    if (iconColor.present) {
      map['icon_color'] = Variable<String>(iconColor.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoryEntityCompanion(')
          ..write('id: $id, ')
          ..write('position: $position, ')
          ..write('name: $name, ')
          ..write('icon: $icon, ')
          ..write('iconColor: $iconColor')
          ..write(')'))
        .toString();
  }
}

class $CategoryEntityTable extends CategoryEntity
    with TableInfo<$CategoryEntityTable, CategoryEntityData> {
  final GeneratedDatabase _db;
  final String _alias;
  $CategoryEntityTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _positionMeta = const VerificationMeta('position');
  GeneratedIntColumn _position;
  @override
  GeneratedIntColumn get position => _position ??= _constructPosition();
  GeneratedIntColumn _constructPosition() {
    return GeneratedIntColumn(
      'position',
      $tableName,
      false,
    );
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn('name', $tableName, false,
        minTextLength: 3, maxTextLength: 20);
  }

  final VerificationMeta _iconMeta = const VerificationMeta('icon');
  GeneratedTextColumn _icon;
  @override
  GeneratedTextColumn get icon => _icon ??= _constructIcon();
  GeneratedTextColumn _constructIcon() {
    return GeneratedTextColumn(
      'icon',
      $tableName,
      false,
    );
  }

  final VerificationMeta _iconColorMeta = const VerificationMeta('iconColor');
  GeneratedTextColumn _iconColor;
  @override
  GeneratedTextColumn get iconColor => _iconColor ??= _constructIconColor();
  GeneratedTextColumn _constructIconColor() {
    return GeneratedTextColumn(
      'icon_color',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, position, name, icon, iconColor];
  @override
  $CategoryEntityTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'category_entity';
  @override
  final String actualTableName = 'category_entity';
  @override
  VerificationContext validateIntegrity(Insertable<CategoryEntityData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('position')) {
      context.handle(_positionMeta,
          position.isAcceptableOrUnknown(data['position'], _positionMeta));
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('icon')) {
      context.handle(
          _iconMeta, icon.isAcceptableOrUnknown(data['icon'], _iconMeta));
    } else if (isInserting) {
      context.missing(_iconMeta);
    }
    if (data.containsKey('icon_color')) {
      context.handle(_iconColorMeta,
          iconColor.isAcceptableOrUnknown(data['icon_color'], _iconColorMeta));
    } else if (isInserting) {
      context.missing(_iconColorMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CategoryEntityData map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return CategoryEntityData.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $CategoryEntityTable createAlias(String alias) {
    return $CategoryEntityTable(_db, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $EntryEntityTable _entryEntity;
  $EntryEntityTable get entryEntity => _entryEntity ??= $EntryEntityTable(this);
  $CategoryEntityTable _categoryEntity;
  $CategoryEntityTable get categoryEntity =>
      _categoryEntity ??= $CategoryEntityTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [entryEntity, categoryEntity];
}
