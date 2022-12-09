import 'package:expense_manager/core/constants.dart';
import 'package:expense_manager/data/models/category.dart';
import 'package:expense_manager/data/models/category_with_sum.dart';
import 'package:expense_manager/data/models/entry_with_category.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:tuple/tuple.dart';

part 'app_database.g.dart';

class EntryEntity extends Table {
  IntColumn get id => integer().autoIncrement()();

  RealColumn get amount => real()();

  IntColumn get categoryId => integer().nullable().customConstraint(
      'NULL REFERENCES category_entity(id) ON DELETE SET NULL')();

  DateTimeColumn get modifiedDate => dateTime()();

  TextColumn get description => text().withLength(max: 100)();
}

class CategoryEntity extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get position => integer()();

  TextColumn get name => text().withLength(min: 3, max: 20)();

  TextColumn get icon => text()();

  TextColumn get iconColor => text()();
}

class IncomeEntryEntity extends Table {
  IntColumn get id => integer().autoIncrement()();

  RealColumn get amount => real()();

  IntColumn get categoryId => integer().nullable().customConstraint(
      'NULL REFERENCES income_category_entity(id) ON DELETE SET NULL')();

  DateTimeColumn get modifiedDate => dateTime()();

  TextColumn get description => text().withLength(max: 100)();
}

class IncomeCategoryEntity extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get position => integer()();

  TextColumn get name => text().withLength(min: 3, max: 20)();

  TextColumn get icon => text()();

  TextColumn get iconColor => text()();
}

final appDatabaseProvider = Provider((ref) => AppDatabase());

@UseMoor(tables: [
  EntryEntity,
  CategoryEntity,
  IncomeCategoryEntity,
  IncomeEntryEntity
])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super((FlutterQueryExecutor.inDatabaseFolder(
          path: 'db.sqlite',
          logStatements: true,
        )));

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(onCreate: (Migrator m) async {
      await m.createAll();
      AppConstants.defaultCategoryList.forEach((category) async {
        await addExpenseCategory(category.toCategoryEntityCompanion()).single;
      });
      AppConstants.defaultIncomeCategoryList.forEach((category) async {
        await addIncomeCategory(category.toIncomeCategoryEntityCompanion())
            .single;
      });
    }, beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    }, onUpgrade: (Migrator m, int from, int to) async {
      if (from == 1) {
        await m.createTable(incomeCategoryEntity);
        await m.createTable(incomeEntryEntity);
        AppConstants.defaultIncomeCategoryList.forEach((category) async {
          await addIncomeCategory(category.toIncomeCategoryEntityCompanion())
              .single;
        });
      }
    });
  }

  Stream<List<int>> getExpenseMonthListByYear(int year) {
    return customSelect(
        "SELECT DISTINCT CAST(strftime('%m' , entry_entity.modified_date, 'unixepoch') AS INTEGER) AS c1 FROM entry_entity WHERE (CAST(strftime('%Y', modified_date,'unixepoch') AS INTEGER)) = :year;",
        readsFrom: {
          entryEntity
        },
        variables: [
          Variable.withInt(year)
        ]).map((QueryRow row) => row.read<int>("c1")).watch();
  }

  Stream<List<int>> getIncomeMonthListByYear(int year) {
    return customSelect(
        "SELECT DISTINCT CAST(strftime('%m' , income_entry_entity.modified_date, 'unixepoch') AS INTEGER) AS c1 FROM income_entry_entity WHERE (CAST(strftime('%Y', modified_date,'unixepoch') AS INTEGER)) = :year;",
        readsFrom: {
          incomeEntryEntity
        },
        variables: [
          Variable.withInt(year)
        ]).map((QueryRow row) => row.read<int>("c1")).watch();
  }

  Stream<List<int>> getAllMonthListByYear(int year) {
    return customSelect(
        "SELECT DISTINCT CAST(strftime('%m' , income_entry_entity.modified_date, 'unixepoch') AS INTEGER) AS c1 FROM income_entry_entity WHERE (CAST(strftime('%Y', modified_date,'unixepoch') AS INTEGER)) = :year UNION SELECT DISTINCT CAST(strftime('%m' , entry_entity.modified_date, 'unixepoch') AS INTEGER) AS c1 FROM entry_entity WHERE (CAST(strftime('%Y', modified_date,'unixepoch') AS INTEGER)) = :year  ORDER BY c1 DESC;",
        readsFrom: {
          incomeEntryEntity,
          entryEntity
        },
        variables: [
          Variable.withInt(year)
        ]).map((QueryRow row) => row.read<int>("c1")).watch();
  }

  Stream<List<int?>> getExpenseYearList() {
    return (selectOnly(entryEntity, distinct: true)
          ..addColumns([entryEntity.modifiedDate.year]))
        .map((row) => row.read(entryEntity.modifiedDate.year))
        .watch();
  }

  Stream<List<int?>> getIncomeYearList() {
    return (selectOnly(incomeEntryEntity, distinct: true)
          ..addColumns([incomeEntryEntity.modifiedDate.year]))
        .map((row) => row.read(incomeEntryEntity.modifiedDate.year))
        .watch();
  }

  Stream<List<int>> getAllYearList() {
    return customSelect(
        "SELECT DISTINCT CAST(strftime('%Y', entry_entity.modified_date, 'unixepoch') AS INTEGER) AS c0 FROM entry_entity UNION SELECT DISTINCT CAST(strftime('%Y', income_entry_entity.modified_date, 'unixepoch') AS INTEGER) AS c0 FROM income_entry_entity ORDER BY c0 DESC;",
        readsFrom: {
          incomeEntryEntity,
          entryEntity
        }).map((QueryRow row) => row.read<int>("c0")).watch();
  }

  Stream<int> addExpenseEntry(EntryEntityCompanion entity) =>
      into(entryEntity).insert(entity).asStream();

  Stream<int> addIncomeEntry(IncomeEntryEntityCompanion entity) {
    return into(incomeEntryEntity).insert(entity).asStream();
  }

  Stream<bool> updateExpenseEntry(EntryEntityCompanion entity) {
    return update(entryEntity).replace(entity).asStream();
  }

  Stream<bool> updateIncomeEntry(IncomeEntryEntityCompanion entity) {
    Fimber.e(entity.id.value.toString());
    return update(incomeEntryEntity).replace(entity).asStream();
  }

  Stream<int> deleteExpenseEntry(int id) =>
      (delete(entryEntity)..where((tbl) => tbl.id.equals(id))).go().asStream();

  Stream<int> deleteIncomeEntry(int id) =>
      (delete(incomeEntryEntity)..where((tbl) => tbl.id.equals(id)))
          .go()
          .asStream();

  Stream<List<EntryWithCategoryExpenseData>> getAllEntryWithCategory(
      DateTime start, DateTime end) {
    return (select(entryEntity)
          ..where((row) => row.modifiedDate.isBetweenValues(start, end))
          ..orderBy([
            (u) => OrderingTerm(
                expression: u.modifiedDate, mode: OrderingMode.desc)
          ]))
        .join([
          leftOuterJoin(categoryEntity,
              categoryEntity.id.equalsExp(entryEntity.categoryId))
        ])
        .watch()
        .map((List<TypedResult> rows) {
          return rows.map((TypedResult row) {
            return EntryWithCategoryExpenseData(
                entry: row.readTableOrNull(entryEntity),
                category: row.readTableOrNull(categoryEntity));
          }).toList();
        });
  }

  Stream<double> getExpanseSumByDateRange(DateTime start, DateTime end) {
    return (select(entryEntity)
          ..where((row) => row.modifiedDate.isBetweenValues(start, end)))
        .watch()
        .map((event) => event
            .map((e) => e.amount)
            .toList()
            .fold(0, (previous, element) => previous + element));
  }

  Stream<double> getIncomeSumByDateRange(DateTime start, DateTime end) {
    return (select(incomeEntryEntity)
          ..where((row) => row.modifiedDate.isBetweenValues(start, end)))
        .watch()
        .map((event) => event
            .map((e) => e.amount)
            .toList()
            .fold(0, (previous, element) => previous + element));
  }

  Stream<double> getTodayExpense() {
    return (select(entryEntity)
          ..where((row) {
            return row.modifiedDate.year.equalsExp(currentDate.year) &
                row.modifiedDate.month.equalsExp(currentDate.month) &
                row.modifiedDate.day.equalsExp(currentDate.day);
          }))
        .watch()
        .map((event) => event
            .map((e) => e.amount)
            .toList()
            .fold(0, (previous, element) => previous + element));
  }

  Stream<List<EntryWithCategoryExpenseData>>
      getExpenseEntryWithCategoryByMonthAndYear(int month, int year) {
    return (select(entryEntity)
          ..where((tbl) =>
              tbl.modifiedDate.month.equals(month) &
              tbl.modifiedDate.year.equals(year))
          ..orderBy([(u) => OrderingTerm.desc(u.modifiedDate)]))
        .join([
          leftOuterJoin(categoryEntity,
              categoryEntity.id.equalsExp(entryEntity.categoryId))
        ])
        .watch()
        .map((List<TypedResult> rows) {
          return rows.map((TypedResult row) {
            return EntryWithCategoryExpenseData(
                entry: row.readTableOrNull(entryEntity),
                category: row.readTableOrNull(categoryEntity));
          }).toList();
        });
  }

  Stream<List<EntryWithCategoryAllData>> getAllEntryWithCategoryByMonthAndYear(
      int month, int year) {
    return customSelect(
      "SELECT 0 AS \"entry_type\", entry_entity.id AS \"entry_entity.id\", entry_entity.amount AS \"entry_entity.amount\", entry_entity.category_id AS \"entry_entity.category_id\", entry_entity.modified_date AS \"entry_entity.modified_date\", entry_entity.description AS \"entry_entity.description\", category_entity.id AS \"category_entity.id\", category_entity.position AS \"category_entity.position\", category_entity.name AS \"category_entity.name\", category_entity.icon AS \"category_entity.icon\", category_entity.icon_color AS \"category_entity.icon_color\" FROM entry_entity LEFT OUTER JOIN category_entity ON category_entity.id = entry_entity.category_id WHERE (CAST(strftime('%m', entry_entity.modified_date, 'unixepoch') AS INTEGER)) = ? AND (CAST(strftime('%Y', entry_entity.modified_date, 'unixepoch') AS INTEGER)) = ? UNION SELECT 1 AS \"entry_type\", income_entry_entity.id AS \"entry_entity.id\", income_entry_entity.amount AS \"entry_entity.amount\", income_entry_entity.category_id AS \"entry_entity.category_id\", income_entry_entity.modified_date AS \"entry_entity.modified_date\", income_entry_entity.description AS \"entry_entity.description\", income_category_entity.id AS \"category_entity.id\", income_category_entity.position AS \"category_entity.position\", income_category_entity.name AS \"category_entity.name\", income_category_entity.icon AS \"category_entity.icon\", income_category_entity.icon_color AS \"category_entity.icon_color\" FROM income_entry_entity LEFT OUTER JOIN income_category_entity ON income_category_entity.id = income_entry_entity.category_id WHERE (CAST(strftime('%m', income_entry_entity.modified_date, 'unixepoch') AS INTEGER)) = ? AND (CAST(strftime('%Y', income_entry_entity.modified_date, 'unixepoch') AS INTEGER)) = ? ORDER BY modified_date DESC;",
      variables: [
        Variable.withInt(month),
        Variable.withInt(year),
        Variable.withInt(month),
        Variable.withInt(year),
      ],
      readsFrom: {
        incomeEntryEntity,
        entryEntity,
        incomeCategoryEntity,
        categoryEntity,
      },
    ).watch().map((event) {
      return event.map((e) {
        return EntryWithCategoryAllData(
            entry:
                EntryEntityData.fromData(e.data, this, prefix: "entry_entity."),
            category: CategoryEntityData.fromData(e.data, this,
                prefix: "category_entity."),
            entryType: e.read<int>("entry_type"));
      }).toList();
    });
  }

  Stream<List<EntryWithCategoryIncomeData>>
      getIncomeEntryWithCategoryByMonthAndYear(int month, int year) {
    return (select(incomeEntryEntity)
          ..where((tbl) =>
              tbl.modifiedDate.month.equals(month) &
              tbl.modifiedDate.year.equals(year))
          ..orderBy([(u) => OrderingTerm.desc(u.modifiedDate)]))
        .join([
          leftOuterJoin(incomeCategoryEntity,
              incomeCategoryEntity.id.equalsExp(incomeEntryEntity.categoryId))
        ])
        .watch()
        .map((List<TypedResult> rows) {
          return rows.map((TypedResult row) {
            return EntryWithCategoryIncomeData(
                entry: row.readTableOrNull(incomeEntryEntity),
                category: row.readTableOrNull(incomeCategoryEntity));
          }).toList();
        });
  }

  Stream<List<CategoryWithSumData>> getAllCategoryWithSumByMonth(
      int month, int year) {
    return ((select(entryEntity)
              ..where((tbl) =>
                  tbl.modifiedDate.month.equals(month) &
                  tbl.modifiedDate.year.equals(year)))
            .join([])
          ..groupBy([entryEntity.categoryId])
          ..addColumns([entryEntity.amount.sum()])
          ..orderBy([OrderingTerm.desc(entryEntity.amount.sum())]))
        .join([
          leftOuterJoin(categoryEntity,
              categoryEntity.id.equalsExp(entryEntity.categoryId))
        ])
        .get()
        .asStream()
        .map((List<TypedResult> rows) {
          return rows.map((TypedResult row) {
            return CategoryWithSumData(
                total:
                    row.read(coalesce([entryEntity.amount.sum(), Constant(0)])),
                category: row.readTableOrNull(categoryEntity));
          }).toList();
        });
  }

  Stream<List<EntryWithCategoryAllData>> getAllEntryWithCategoryByYear(
      int year) {
    return customSelect(
        "SELECT *, 0 AS entry_type FROM entry_entity LEFT OUTER JOIN category_entity ON category_entity.id = entry_entity.category_id WHERE (CAST(strftime('%Y', entry_entity.modified_date, 'unixepoch') AS INTEGER)) =? UNION SELECT *, 1 AS entry_type FROM income_entry_entity LEFT OUTER JOIN income_category_entity ON income_category_entity.id = income_entry_entity.category_id WHERE (CAST(strftime('%Y', income_entry_entity.modified_date, 'unixepoch') AS INTEGER)) =? ORDER BY income_entry_entity.modified_date ASC;",
        variables: [
          Variable.withInt(year),
          Variable.withInt(year),
        ]).watch().map((event) {
      return event.map((e) {
        return EntryWithCategoryAllData(
            entry: EntryEntityData.fromData(e.data, this),
            category: CategoryEntityData.fromData(e.data, this),
            entryType: e.read<int>("entry_type"));
      }).toList();
    });
  }

  Stream<List<CategoryWithSumData>> getAllCategoryWithSumByYear(int year) {
    return ((select(entryEntity)
              ..where((tbl) => tbl.modifiedDate.year.equals(year)))
            .join([])
          ..groupBy([entryEntity.categoryId])
          ..addColumns([entryEntity.amount.sum()])
          ..orderBy([OrderingTerm.desc(entryEntity.amount.sum())]))
        .join([
          leftOuterJoin(categoryEntity,
              categoryEntity.id.equalsExp(entryEntity.categoryId))
        ])
        .get()
        .asStream()
        .map((List<TypedResult> rows) {
          return rows.map((TypedResult row) {
            return CategoryWithSumData(
                total: row.read(coalesce([entryEntity.amount.sum(),Constant(0)])),
                category: row.readTableOrNull(categoryEntity));
          }).toList();
        });
  }

  Stream<List<CategoryEntityData>> getAllExpenseCategory() =>
      (select(categoryEntity)
            ..orderBy([
              (u) =>
                  OrderingTerm(expression: u.position, mode: OrderingMode.asc)
            ]))
          .watch();

  Stream<List<IncomeCategoryEntityData>> getAllIncomeCategory() =>
      (select(incomeCategoryEntity)
            ..orderBy([
              (u) =>
                  OrderingTerm(expression: u.position, mode: OrderingMode.asc)
            ]))
          .watch();

  Stream<List<Tuple2<CategoryEntityData, int>>> getAllCategory() {
    return customSelect(
        "SELECT *, 1 AS entry_type FROM income_category_entity UNION SELECT *, 0 AS entry_type FROM category_entity ORDER BY name ASC;",
        readsFrom: {incomeCategoryEntity, categoryEntity}).watch().map((event) {
      return event.map((e) {
        return Tuple2(CategoryEntityData.fromData(e.data, this),
            e.read<int>("entry_type"));
      }).toList();
    });
  }

  Future<List<CategoryEntityData>> getExpenseCategoryFeature() =>
      (select(categoryEntity)
            ..orderBy([
              (u) =>
                  OrderingTerm(expression: u.position, mode: OrderingMode.asc)
            ]))
          .get();

  Stream<int> addExpenseCategory(CategoryEntityCompanion category) => customInsert(
      "INSERT INTO category_entity (position, name, icon, icon_color) VALUES ((SELECT IFNULL(MAX(position), 0) + 1 FROM category_entity), '${category.name.value}', '${category.icon.value}', '${category.iconColor.value}');",
      updates: {categoryEntity}).asStream();

  Stream<int> addIncomeCategory(IncomeCategoryEntityCompanion incomeCategory) =>
      customInsert(
          "INSERT INTO income_category_entity (position, name, icon, icon_color) VALUES ((SELECT IFNULL(MAX(position), 0) + 1 FROM income_category_entity), '${incomeCategory.name.value}', '${incomeCategory.icon.value}', '${incomeCategory.iconColor.value}');",
          updates: {incomeCategoryEntity}).asStream();

  Stream<bool> updateExpenseCategory(CategoryEntityCompanion entity) =>
      update(categoryEntity).replace(entity).asStream();

  Stream<bool> updateIncomeCategory(IncomeCategoryEntityCompanion entity) =>
      update(incomeCategoryEntity).replace(entity).asStream();

  Stream<int> deleteExpenseCategory(int id) =>
      (delete(categoryEntity)..where((tbl) => tbl.id.equals(id)))
          .go()
          .asStream();

  Stream<int> deleteIncomeCategory(int id) =>
      (delete(incomeCategoryEntity)..where((tbl) => tbl.id.equals(id)))
          .go()
          .asStream();

  Stream<bool> reorderCategory(int oldIndex, int newIndex) {
    /*getAllCategory1()
        .then((value) =>
            value.map((e) => Category.fromCategoryEntity(e)).toList())
        .asStream()
        .map((event) {
          List<Category> categoryList = event;
          Fimber.e(
              "Pre ${categoryList.map((e) => "${e.name[0]} ${e.position}").toList()}");
          for (int i = 0; i < categoryList.length; i++) {
            if (categoryList[i].position == oldIndex) {
              categoryList[i] = categoryList[i].copyWith(position: -1);
            }
          }
          Fimber.e(
              "Old ${categoryList.map((e) => "${e.name[0]} ${e.position}").toList()}");
          if (oldIndex > newIndex) {
            for (int i = 0; i < categoryList.length; i++) {
              if (categoryList[i].position >= newIndex) {
                categoryList[i] = categoryList[i]
                    .copyWith(position: categoryList[i].position + 1);
              }
            }
          } else {
            for (int i = 0; i < categoryList.length; i++) {
              if (categoryList[i].position > oldIndex &&
                  categoryList[i].position <= newIndex) {
                categoryList[i] = categoryList[i]
                    .copyWith(position: categoryList[i].position - 1);
              }
            }
          }
          Fimber.e(
              "New ${categoryList.map((e) => "${e.name[0]} ${e.position}").toList()}");
          for (int i = 0; i < categoryList.length; i++) {
            if (categoryList[i].position == -1) {
              categoryList[i] = categoryList[i].copyWith(position: newIndex);
            }
          }
          Fimber.e(
              "Old2 ${categoryList.map((e) => "${e.name[0]} ${e.position}").toList()}");
          return categoryList;
        })
        .map(
            (event) => event.map((e) => e.toCategoryEntityCompanion()).toList())
        .flatMap((value) => batch((b) {
              b.update(categoryEntity, value);
            }).asStream());*/
    return transaction(() async {
      Fimber.e("$oldIndex $newIndex");
      List<Category> categoryList = await getExpenseCategoryFeature().then(
          (value) =>
              value.map((e) => Category.fromExpenseCategoryEntity(e)).toList());
      Fimber.e(
          "Pre ${categoryList.map((e) => "${e.name[0]} ${e.position}").toList()}");
      for (int i = 0; i < categoryList.length; i++) {
        if (categoryList[i].position == oldIndex) {
          categoryList[i] = categoryList[i].copyWith(position: -1);
        }
      }
      Fimber.e(
          "Old ${categoryList.map((e) => "${e.name[0]} ${e.position}").toList()}");
      if (oldIndex > newIndex) {
        for (int i = 0; i < categoryList.length; i++) {
          if (categoryList[i].position! >= newIndex) {
            categoryList[i] = categoryList[i]
                .copyWith(position: categoryList[i].position! + 1);
          }
        }
      } else {
        for (int i = 0; i < categoryList.length; i++) {
          if (categoryList[i].position! > oldIndex &&
              categoryList[i].position! <= newIndex) {
            categoryList[i] = categoryList[i]
                .copyWith(position: categoryList[i].position! - 1);
          }
        }
      }
      Fimber.e(
          "New ${categoryList.map((e) => "${e.name[0]} ${e.position}").toList()}");
      for (int i = 0; i < categoryList.length; i++) {
        if (categoryList[i].position == -1) {
          categoryList[i] = categoryList[i].copyWith(position: newIndex);
        }
      }
      Fimber.e(
          "Old2 ${categoryList.map((e) => "${e.name[0]} ${e.position}").toList()}");
      categoryList.forEach((element) async {
        await update(categoryEntity)
            .replace(element.toCategoryEntityCompanion());
        // await updateCategory(element.toCategoryEntityCompanion()).single;
      });

      return true;
    }).asStream();
  }
}
