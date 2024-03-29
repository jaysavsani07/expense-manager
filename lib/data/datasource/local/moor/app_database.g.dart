// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $CategoryEntityTable extends CategoryEntity
    with TableInfo<$CategoryEntityTable, CategoryEntityData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoryEntityTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _positionMeta =
      const VerificationMeta('position');
  @override
  late final GeneratedColumn<int> position = GeneratedColumn<int>(
      'position', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 3, maxTextLength: 20),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _iconMeta = const VerificationMeta('icon');
  @override
  late final GeneratedColumn<String> icon = GeneratedColumn<String>(
      'icon', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _iconColorMeta =
      const VerificationMeta('iconColor');
  @override
  late final GeneratedColumn<String> iconColor = GeneratedColumn<String>(
      'icon_color', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, position, name, icon, iconColor];
  @override
  String get aliasedName => _alias ?? 'category_entity';
  @override
  String get actualTableName => 'category_entity';
  @override
  VerificationContext validateIntegrity(Insertable<CategoryEntityData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('position')) {
      context.handle(_positionMeta,
          position.isAcceptableOrUnknown(data['position']!, _positionMeta));
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('icon')) {
      context.handle(
          _iconMeta, icon.isAcceptableOrUnknown(data['icon']!, _iconMeta));
    }
    if (data.containsKey('icon_color')) {
      context.handle(_iconColorMeta,
          iconColor.isAcceptableOrUnknown(data['icon_color']!, _iconColorMeta));
    } else if (isInserting) {
      context.missing(_iconColorMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CategoryEntityData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CategoryEntityData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      position: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}position'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      icon: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}icon']),
      iconColor: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}icon_color'])!,
    );
  }

  @override
  $CategoryEntityTable createAlias(String alias) {
    return $CategoryEntityTable(attachedDatabase, alias);
  }
}

class CategoryEntityData extends DataClass
    implements Insertable<CategoryEntityData> {
  final int id;
  final int position;
  final String name;
  final String? icon;
  final String iconColor;
  const CategoryEntityData(
      {required this.id,
      required this.position,
      required this.name,
      this.icon,
      required this.iconColor});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['position'] = Variable<int>(position);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || icon != null) {
      map['icon'] = Variable<String>(icon);
    }
    map['icon_color'] = Variable<String>(iconColor);
    return map;
  }

  CategoryEntityCompanion toCompanion(bool nullToAbsent) {
    return CategoryEntityCompanion(
      id: Value(id),
      position: Value(position),
      name: Value(name),
      icon: icon == null && nullToAbsent ? const Value.absent() : Value(icon),
      iconColor: Value(iconColor),
    );
  }

  factory CategoryEntityData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CategoryEntityData(
      id: serializer.fromJson<int>(json['id']),
      position: serializer.fromJson<int>(json['position']),
      name: serializer.fromJson<String>(json['name']),
      icon: serializer.fromJson<String?>(json['icon']),
      iconColor: serializer.fromJson<String>(json['iconColor']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'position': serializer.toJson<int>(position),
      'name': serializer.toJson<String>(name),
      'icon': serializer.toJson<String?>(icon),
      'iconColor': serializer.toJson<String>(iconColor),
    };
  }

  CategoryEntityData copyWith(
          {int? id,
          int? position,
          String? name,
          Value<String?> icon = const Value.absent(),
          String? iconColor}) =>
      CategoryEntityData(
        id: id ?? this.id,
        position: position ?? this.position,
        name: name ?? this.name,
        icon: icon.present ? icon.value : this.icon,
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
  int get hashCode => Object.hash(id, position, name, icon, iconColor);
  @override
  bool operator ==(Object other) =>
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
  final Value<String?> icon;
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
    required int position,
    required String name,
    this.icon = const Value.absent(),
    required String iconColor,
  })  : position = Value(position),
        name = Value(name),
        iconColor = Value(iconColor);
  static Insertable<CategoryEntityData> custom({
    Expression<int>? id,
    Expression<int>? position,
    Expression<String>? name,
    Expression<String>? icon,
    Expression<String>? iconColor,
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
      {Value<int>? id,
      Value<int>? position,
      Value<String>? name,
      Value<String?>? icon,
      Value<String>? iconColor}) {
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

class $EntryEntityTable extends EntryEntity
    with TableInfo<$EntryEntityTable, EntryEntityData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EntryEntityTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
      'amount', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _categoryIdMeta =
      const VerificationMeta('categoryId');
  @override
  late final GeneratedColumn<int> categoryId = GeneratedColumn<int>(
      'category_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints:
          'NULL REFERENCES category_entity(id) ON DELETE SET NULL');
  static const VerificationMeta _modifiedDateMeta =
      const VerificationMeta('modifiedDate');
  @override
  late final GeneratedColumn<DateTime> modifiedDate = GeneratedColumn<DateTime>(
      'modified_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, amount, categoryId, modifiedDate, description];
  @override
  String get aliasedName => _alias ?? 'entry_entity';
  @override
  String get actualTableName => 'entry_entity';
  @override
  VerificationContext validateIntegrity(Insertable<EntryEntityData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
          _categoryIdMeta,
          categoryId.isAcceptableOrUnknown(
              data['category_id']!, _categoryIdMeta));
    }
    if (data.containsKey('modified_date')) {
      context.handle(
          _modifiedDateMeta,
          modifiedDate.isAcceptableOrUnknown(
              data['modified_date']!, _modifiedDateMeta));
    } else if (isInserting) {
      context.missing(_modifiedDateMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EntryEntityData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EntryEntityData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}amount'])!,
      categoryId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}category_id']),
      modifiedDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}modified_date'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
    );
  }

  @override
  $EntryEntityTable createAlias(String alias) {
    return $EntryEntityTable(attachedDatabase, alias);
  }
}

class EntryEntityData extends DataClass implements Insertable<EntryEntityData> {
  final int id;
  final double amount;
  final int? categoryId;
  final DateTime modifiedDate;
  final String description;
  const EntryEntityData(
      {required this.id,
      required this.amount,
      this.categoryId,
      required this.modifiedDate,
      required this.description});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['amount'] = Variable<double>(amount);
    if (!nullToAbsent || categoryId != null) {
      map['category_id'] = Variable<int>(categoryId);
    }
    map['modified_date'] = Variable<DateTime>(modifiedDate);
    map['description'] = Variable<String>(description);
    return map;
  }

  EntryEntityCompanion toCompanion(bool nullToAbsent) {
    return EntryEntityCompanion(
      id: Value(id),
      amount: Value(amount),
      categoryId: categoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(categoryId),
      modifiedDate: Value(modifiedDate),
      description: Value(description),
    );
  }

  factory EntryEntityData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EntryEntityData(
      id: serializer.fromJson<int>(json['id']),
      amount: serializer.fromJson<double>(json['amount']),
      categoryId: serializer.fromJson<int?>(json['categoryId']),
      modifiedDate: serializer.fromJson<DateTime>(json['modifiedDate']),
      description: serializer.fromJson<String>(json['description']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'amount': serializer.toJson<double>(amount),
      'categoryId': serializer.toJson<int?>(categoryId),
      'modifiedDate': serializer.toJson<DateTime>(modifiedDate),
      'description': serializer.toJson<String>(description),
    };
  }

  EntryEntityData copyWith(
          {int? id,
          double? amount,
          Value<int?> categoryId = const Value.absent(),
          DateTime? modifiedDate,
          String? description}) =>
      EntryEntityData(
        id: id ?? this.id,
        amount: amount ?? this.amount,
        categoryId: categoryId.present ? categoryId.value : this.categoryId,
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
  int get hashCode =>
      Object.hash(id, amount, categoryId, modifiedDate, description);
  @override
  bool operator ==(Object other) =>
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
  final Value<int?> categoryId;
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
    required double amount,
    this.categoryId = const Value.absent(),
    required DateTime modifiedDate,
    required String description,
  })  : amount = Value(amount),
        modifiedDate = Value(modifiedDate),
        description = Value(description);
  static Insertable<EntryEntityData> custom({
    Expression<int>? id,
    Expression<double>? amount,
    Expression<int>? categoryId,
    Expression<DateTime>? modifiedDate,
    Expression<String>? description,
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
      {Value<int>? id,
      Value<double>? amount,
      Value<int?>? categoryId,
      Value<DateTime>? modifiedDate,
      Value<String>? description}) {
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

class $IncomeCategoryEntityTable extends IncomeCategoryEntity
    with TableInfo<$IncomeCategoryEntityTable, IncomeCategoryEntityData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $IncomeCategoryEntityTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _positionMeta =
      const VerificationMeta('position');
  @override
  late final GeneratedColumn<int> position = GeneratedColumn<int>(
      'position', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 3, maxTextLength: 20),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _iconMeta = const VerificationMeta('icon');
  @override
  late final GeneratedColumn<String> icon = GeneratedColumn<String>(
      'icon', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _iconColorMeta =
      const VerificationMeta('iconColor');
  @override
  late final GeneratedColumn<String> iconColor = GeneratedColumn<String>(
      'icon_color', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, position, name, icon, iconColor];
  @override
  String get aliasedName => _alias ?? 'income_category_entity';
  @override
  String get actualTableName => 'income_category_entity';
  @override
  VerificationContext validateIntegrity(
      Insertable<IncomeCategoryEntityData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('position')) {
      context.handle(_positionMeta,
          position.isAcceptableOrUnknown(data['position']!, _positionMeta));
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('icon')) {
      context.handle(
          _iconMeta, icon.isAcceptableOrUnknown(data['icon']!, _iconMeta));
    }
    if (data.containsKey('icon_color')) {
      context.handle(_iconColorMeta,
          iconColor.isAcceptableOrUnknown(data['icon_color']!, _iconColorMeta));
    } else if (isInserting) {
      context.missing(_iconColorMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  IncomeCategoryEntityData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return IncomeCategoryEntityData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      position: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}position'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      icon: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}icon']),
      iconColor: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}icon_color'])!,
    );
  }

  @override
  $IncomeCategoryEntityTable createAlias(String alias) {
    return $IncomeCategoryEntityTable(attachedDatabase, alias);
  }
}

class IncomeCategoryEntityData extends DataClass
    implements Insertable<IncomeCategoryEntityData> {
  final int id;
  final int position;
  final String name;
  final String? icon;
  final String iconColor;
  const IncomeCategoryEntityData(
      {required this.id,
      required this.position,
      required this.name,
      this.icon,
      required this.iconColor});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['position'] = Variable<int>(position);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || icon != null) {
      map['icon'] = Variable<String>(icon);
    }
    map['icon_color'] = Variable<String>(iconColor);
    return map;
  }

  IncomeCategoryEntityCompanion toCompanion(bool nullToAbsent) {
    return IncomeCategoryEntityCompanion(
      id: Value(id),
      position: Value(position),
      name: Value(name),
      icon: icon == null && nullToAbsent ? const Value.absent() : Value(icon),
      iconColor: Value(iconColor),
    );
  }

  factory IncomeCategoryEntityData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return IncomeCategoryEntityData(
      id: serializer.fromJson<int>(json['id']),
      position: serializer.fromJson<int>(json['position']),
      name: serializer.fromJson<String>(json['name']),
      icon: serializer.fromJson<String?>(json['icon']),
      iconColor: serializer.fromJson<String>(json['iconColor']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'position': serializer.toJson<int>(position),
      'name': serializer.toJson<String>(name),
      'icon': serializer.toJson<String?>(icon),
      'iconColor': serializer.toJson<String>(iconColor),
    };
  }

  IncomeCategoryEntityData copyWith(
          {int? id,
          int? position,
          String? name,
          Value<String?> icon = const Value.absent(),
          String? iconColor}) =>
      IncomeCategoryEntityData(
        id: id ?? this.id,
        position: position ?? this.position,
        name: name ?? this.name,
        icon: icon.present ? icon.value : this.icon,
        iconColor: iconColor ?? this.iconColor,
      );
  @override
  String toString() {
    return (StringBuffer('IncomeCategoryEntityData(')
          ..write('id: $id, ')
          ..write('position: $position, ')
          ..write('name: $name, ')
          ..write('icon: $icon, ')
          ..write('iconColor: $iconColor')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, position, name, icon, iconColor);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is IncomeCategoryEntityData &&
          other.id == this.id &&
          other.position == this.position &&
          other.name == this.name &&
          other.icon == this.icon &&
          other.iconColor == this.iconColor);
}

class IncomeCategoryEntityCompanion
    extends UpdateCompanion<IncomeCategoryEntityData> {
  final Value<int> id;
  final Value<int> position;
  final Value<String> name;
  final Value<String?> icon;
  final Value<String> iconColor;
  const IncomeCategoryEntityCompanion({
    this.id = const Value.absent(),
    this.position = const Value.absent(),
    this.name = const Value.absent(),
    this.icon = const Value.absent(),
    this.iconColor = const Value.absent(),
  });
  IncomeCategoryEntityCompanion.insert({
    this.id = const Value.absent(),
    required int position,
    required String name,
    this.icon = const Value.absent(),
    required String iconColor,
  })  : position = Value(position),
        name = Value(name),
        iconColor = Value(iconColor);
  static Insertable<IncomeCategoryEntityData> custom({
    Expression<int>? id,
    Expression<int>? position,
    Expression<String>? name,
    Expression<String>? icon,
    Expression<String>? iconColor,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (position != null) 'position': position,
      if (name != null) 'name': name,
      if (icon != null) 'icon': icon,
      if (iconColor != null) 'icon_color': iconColor,
    });
  }

  IncomeCategoryEntityCompanion copyWith(
      {Value<int>? id,
      Value<int>? position,
      Value<String>? name,
      Value<String?>? icon,
      Value<String>? iconColor}) {
    return IncomeCategoryEntityCompanion(
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
    return (StringBuffer('IncomeCategoryEntityCompanion(')
          ..write('id: $id, ')
          ..write('position: $position, ')
          ..write('name: $name, ')
          ..write('icon: $icon, ')
          ..write('iconColor: $iconColor')
          ..write(')'))
        .toString();
  }
}

class $IncomeEntryEntityTable extends IncomeEntryEntity
    with TableInfo<$IncomeEntryEntityTable, IncomeEntryEntityData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $IncomeEntryEntityTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
      'amount', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _categoryIdMeta =
      const VerificationMeta('categoryId');
  @override
  late final GeneratedColumn<int> categoryId = GeneratedColumn<int>(
      'category_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints:
          'NULL REFERENCES income_category_entity(id) ON DELETE SET NULL');
  static const VerificationMeta _modifiedDateMeta =
      const VerificationMeta('modifiedDate');
  @override
  late final GeneratedColumn<DateTime> modifiedDate = GeneratedColumn<DateTime>(
      'modified_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, amount, categoryId, modifiedDate, description];
  @override
  String get aliasedName => _alias ?? 'income_entry_entity';
  @override
  String get actualTableName => 'income_entry_entity';
  @override
  VerificationContext validateIntegrity(
      Insertable<IncomeEntryEntityData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
          _categoryIdMeta,
          categoryId.isAcceptableOrUnknown(
              data['category_id']!, _categoryIdMeta));
    }
    if (data.containsKey('modified_date')) {
      context.handle(
          _modifiedDateMeta,
          modifiedDate.isAcceptableOrUnknown(
              data['modified_date']!, _modifiedDateMeta));
    } else if (isInserting) {
      context.missing(_modifiedDateMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  IncomeEntryEntityData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return IncomeEntryEntityData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}amount'])!,
      categoryId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}category_id']),
      modifiedDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}modified_date'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
    );
  }

  @override
  $IncomeEntryEntityTable createAlias(String alias) {
    return $IncomeEntryEntityTable(attachedDatabase, alias);
  }
}

class IncomeEntryEntityData extends DataClass
    implements Insertable<IncomeEntryEntityData> {
  final int id;
  final double amount;
  final int? categoryId;
  final DateTime modifiedDate;
  final String description;
  const IncomeEntryEntityData(
      {required this.id,
      required this.amount,
      this.categoryId,
      required this.modifiedDate,
      required this.description});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['amount'] = Variable<double>(amount);
    if (!nullToAbsent || categoryId != null) {
      map['category_id'] = Variable<int>(categoryId);
    }
    map['modified_date'] = Variable<DateTime>(modifiedDate);
    map['description'] = Variable<String>(description);
    return map;
  }

  IncomeEntryEntityCompanion toCompanion(bool nullToAbsent) {
    return IncomeEntryEntityCompanion(
      id: Value(id),
      amount: Value(amount),
      categoryId: categoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(categoryId),
      modifiedDate: Value(modifiedDate),
      description: Value(description),
    );
  }

  factory IncomeEntryEntityData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return IncomeEntryEntityData(
      id: serializer.fromJson<int>(json['id']),
      amount: serializer.fromJson<double>(json['amount']),
      categoryId: serializer.fromJson<int?>(json['categoryId']),
      modifiedDate: serializer.fromJson<DateTime>(json['modifiedDate']),
      description: serializer.fromJson<String>(json['description']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'amount': serializer.toJson<double>(amount),
      'categoryId': serializer.toJson<int?>(categoryId),
      'modifiedDate': serializer.toJson<DateTime>(modifiedDate),
      'description': serializer.toJson<String>(description),
    };
  }

  IncomeEntryEntityData copyWith(
          {int? id,
          double? amount,
          Value<int?> categoryId = const Value.absent(),
          DateTime? modifiedDate,
          String? description}) =>
      IncomeEntryEntityData(
        id: id ?? this.id,
        amount: amount ?? this.amount,
        categoryId: categoryId.present ? categoryId.value : this.categoryId,
        modifiedDate: modifiedDate ?? this.modifiedDate,
        description: description ?? this.description,
      );
  @override
  String toString() {
    return (StringBuffer('IncomeEntryEntityData(')
          ..write('id: $id, ')
          ..write('amount: $amount, ')
          ..write('categoryId: $categoryId, ')
          ..write('modifiedDate: $modifiedDate, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, amount, categoryId, modifiedDate, description);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is IncomeEntryEntityData &&
          other.id == this.id &&
          other.amount == this.amount &&
          other.categoryId == this.categoryId &&
          other.modifiedDate == this.modifiedDate &&
          other.description == this.description);
}

class IncomeEntryEntityCompanion
    extends UpdateCompanion<IncomeEntryEntityData> {
  final Value<int> id;
  final Value<double> amount;
  final Value<int?> categoryId;
  final Value<DateTime> modifiedDate;
  final Value<String> description;
  const IncomeEntryEntityCompanion({
    this.id = const Value.absent(),
    this.amount = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.modifiedDate = const Value.absent(),
    this.description = const Value.absent(),
  });
  IncomeEntryEntityCompanion.insert({
    this.id = const Value.absent(),
    required double amount,
    this.categoryId = const Value.absent(),
    required DateTime modifiedDate,
    required String description,
  })  : amount = Value(amount),
        modifiedDate = Value(modifiedDate),
        description = Value(description);
  static Insertable<IncomeEntryEntityData> custom({
    Expression<int>? id,
    Expression<double>? amount,
    Expression<int>? categoryId,
    Expression<DateTime>? modifiedDate,
    Expression<String>? description,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (amount != null) 'amount': amount,
      if (categoryId != null) 'category_id': categoryId,
      if (modifiedDate != null) 'modified_date': modifiedDate,
      if (description != null) 'description': description,
    });
  }

  IncomeEntryEntityCompanion copyWith(
      {Value<int>? id,
      Value<double>? amount,
      Value<int?>? categoryId,
      Value<DateTime>? modifiedDate,
      Value<String>? description}) {
    return IncomeEntryEntityCompanion(
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
    return (StringBuffer('IncomeEntryEntityCompanion(')
          ..write('id: $id, ')
          ..write('amount: $amount, ')
          ..write('categoryId: $categoryId, ')
          ..write('modifiedDate: $modifiedDate, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  late final $CategoryEntityTable categoryEntity = $CategoryEntityTable(this);
  late final $EntryEntityTable entryEntity = $EntryEntityTable(this);
  late final $IncomeCategoryEntityTable incomeCategoryEntity =
      $IncomeCategoryEntityTable(this);
  late final $IncomeEntryEntityTable incomeEntryEntity =
      $IncomeEntryEntityTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [categoryEntity, entryEntity, incomeCategoryEntity, incomeEntryEntity];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules(
        [
          WritePropagation(
            on: TableUpdateQuery.onTableName('category_entity',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('entry_entity', kind: UpdateKind.update),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('income_category_entity',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('income_entry_entity', kind: UpdateKind.update),
            ],
          ),
        ],
      );
}
