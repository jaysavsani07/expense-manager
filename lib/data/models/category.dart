import 'package:expense_manager/core/constants.dart';
import 'package:expense_manager/data/datasource/local/moor/app_database.dart';
import 'package:expense_manager/extension/icon_data_extension.dart';
import 'package:expense_manager/extension/string_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:drift/drift.dart';

@immutable
class Category {
  final int? id;
  final int? position;
  final String name;
  final IconData icon;
  final Color iconColor;
  final EntryType? entryType;

  Category({
    this.id,
    this.position,
    required this.name,
    required this.icon,
    required this.iconColor,
    this.entryType,
  });

  Category copyWith({
    int? id,
    int? position,
    String? name,
    IconData? icon,
    Color? iconColor,
  }) {
    return Category(
      id: id ?? this.id,
      position: position ?? this.position,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      iconColor: iconColor ?? this.iconColor,
    );
  }

  factory Category.fromExpenseCategoryEntity(
      CategoryEntityData? categoryEntityData) {
    return Category(
        id: categoryEntityData?.id,
        position: categoryEntityData?.position,
        name: categoryEntityData?.name ?? AppConstants.otherCategory.name,
        icon: categoryEntityData?.icon?.jsonToIconData() ??
            AppConstants.otherCategory.icon,
        iconColor: categoryEntityData?.iconColor != null
            ? Color(int.parse(categoryEntityData!.iconColor))
            : AppConstants.otherCategory.iconColor);
  }

  factory Category.fromIncomeCategoryEntity(
    IncomeCategoryEntityData? incomeCategoryEntityData,
  ) {
    return Category(
        id: incomeCategoryEntityData?.id,
        position: incomeCategoryEntityData?.position,
        name: incomeCategoryEntityData?.name ?? AppConstants.otherCategory.name,
        icon: incomeCategoryEntityData?.icon?.jsonToIconData() ??
            AppConstants.otherCategory.icon,
        iconColor: incomeCategoryEntityData?.iconColor != null
            ? Color(int.parse(incomeCategoryEntityData!.iconColor))
            : AppConstants.otherCategory.iconColor);
  }

  factory Category.fromAllCategoryEntity(
    CategoryEntityData? categoryEntityData,
    int entryType,
  ) {
    return Category(
        id: categoryEntityData?.id,
        position: categoryEntityData?.position,
        name: categoryEntityData?.name ?? AppConstants.otherCategory.name,
        icon: categoryEntityData?.icon?.jsonToIconData() ??
            AppConstants.otherCategory.icon,
        iconColor: categoryEntityData?.iconColor != null
            ? Color(int.parse(categoryEntityData!.iconColor))
            : AppConstants.otherCategory.iconColor,
        entryType: EntryType.values[entryType]);
  }

  CategoryEntityCompanion toCategoryEntityCompanion() {
    return CategoryEntityCompanion(
        id: id == null ? Value.absent() : Value(id!),
        position: position == null ? Value.absent() : Value(position!),
        name: Value(name),
        icon: Value(icon.iconDataToJson()),
        iconColor:
            Value("0x${iconColor.value.toRadixString(16).padLeft(8, '0')}"));
  }

  IncomeCategoryEntityCompanion toIncomeCategoryEntityCompanion() {
    return IncomeCategoryEntityCompanion(
        id: id == null ? Value.absent() : Value(id!),
        position: position == null ? Value.absent() : Value(position!),
        name: Value(name),
        icon: Value(icon.iconDataToJson()),
        iconColor:
            Value("0x${iconColor.value.toRadixString(16).padLeft(8, '0')}"));
  }

  CategoryEntityData toCategoryEntityData() {
    return CategoryEntityData(
        id: id!,
        position: position!,
        name: name,
        icon: icon.iconDataToJson(),
        iconColor: "0x${iconColor.value.toRadixString(16).padLeft(8, '0')}");
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Category &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          icon == other.icon &&
          iconColor == other.iconColor;

  @override
  int get hashCode => name.hashCode ^ icon.hashCode ^ iconColor.hashCode;

  @override
  String toString() {
    return 'Category{id: $id,name: $position,position: $name, icon: $icon, iconColor: $iconColor}';
  }
}
