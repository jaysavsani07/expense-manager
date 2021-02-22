import 'package:expense_manager/core/constants.dart';
import 'package:expense_manager/data/datasource/local/moor/app_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:expense_manager/extension/string_extension.dart';
import 'package:expense_manager/extension/icon_data_extension.dart';
import 'package:moor/moor.dart';

@immutable
class Category {
  final int id;
  final String name;
  final IconData icon;
  final Color iconColor;
  final bool isSelected;

  Category(
      {this.id,
      @required this.name,
      @required this.icon,
      @required this.iconColor,
      this.isSelected});

  Category copyWith({String name, IconData icon, Color iconColor}) {
    return Category(
        name: name, icon: icon, iconColor: iconColor, isSelected: false);
  }

  factory Category.fromCategoryEntity(CategoryEntityData categoryEntityData) {
    return Category(
        id: categoryEntityData?.id,
        name: categoryEntityData?.name ?? AppConstants.otherCategory.name,
        icon: categoryEntityData?.icon?.jsonToIconData() ??
            AppConstants.otherCategory.icon,
        iconColor: categoryEntityData?.iconColor != null
            ? Color(int.parse(categoryEntityData?.iconColor))
            : AppConstants.otherCategory.iconColor);
  }

  CategoryEntityCompanion toCategoryEntityCompanion() {
    return CategoryEntityCompanion(
        id: id == null ? Value.absent() : Value(id),
        name: Value(name),
        icon: Value(icon.iconDataToJson()),
        iconColor:
            Value("0x${iconColor.value.toRadixString(16).padLeft(8, '0')}"));
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
    return 'Category{name: $name, icon: $icon, iconColor: $iconColor}';
  }
}
