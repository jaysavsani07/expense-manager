import 'package:expense_manager/core/constants.dart';
import 'package:expense_manager/data/datasource/local/moor/app_database.dart';
import 'package:expense_manager/data/models/category.dart';
import 'package:expense_manager/data/models/entry.dart';

class EntryWithCategory {
  final Entry entry;
  final Category category;
  final EntryType entryType;

  EntryWithCategory({
    required this.entry,
    required this.category,
    required this.entryType,
  });

  factory EntryWithCategory.fromExpenseEntryWithCategoryEntity(
      EntryWithCategoryExpenseData entityData) {
    return EntryWithCategory(
        entry: Entry.fromEntryEntity(entityData.entry!),
        category: Category.fromExpenseCategoryEntity(entityData.category),
        entryType: EntryType.expense);
  }

  factory EntryWithCategory.fromIncomeEntryWithCategoryEntity(
      EntryWithCategoryIncomeData entityData) {
    return EntryWithCategory(
        entry: Entry.fromIncomeEntryEntity(entityData.entry!),
        category: Category.fromIncomeCategoryEntity(entityData.category),
        entryType: EntryType.income);
  }

  factory EntryWithCategory.fromAllEntryWithCategoryEntity(
      EntryWithCategoryAllData entityData, int entryType) {
    return EntryWithCategory(
        entry: Entry.fromEntryEntity(entityData.entry),
        category: Category.fromExpenseCategoryEntity(entityData.category),
        entryType: EntryType.values[entryType]);
  }

  @override
  String toString() {
    return 'EntryWithCategory{entryType: $entryType, entry: ${entry.toString()}, category: ${category.toString()}';
  }
}

class EntryWithCategoryAllData {
  final EntryEntityData entry;
  final CategoryEntityData category;
  final int entryType;

  EntryWithCategoryAllData({
    required this.entry,
    required this.category,
    required this.entryType,
  });

  @override
  String toString() {
    return 'EntryWithCategoryAllData{entry: ${entry.toString()}, category: ${category.toString()}, entryType: $entryType';
  }
}

class EntryWithCategoryExpenseData {
  final EntryEntityData? entry;
  final CategoryEntityData? category;

  EntryWithCategoryExpenseData({required this.entry, required this.category});

  @override
  String toString() {
    return 'EntryWithCategoryExpenseData{entry: ${entry.toString()}, category: ${category.toString()}';
  }
}

class EntryWithCategoryIncomeData {
  final IncomeEntryEntityData? entry;
  final IncomeCategoryEntityData? category;

  EntryWithCategoryIncomeData({required this.entry, required this.category});

  @override
  String toString() {
    return 'EntryWithCategoryIncomeData{entry: ${entry.toString()}, category: ${category.toString()}';
  }
}
