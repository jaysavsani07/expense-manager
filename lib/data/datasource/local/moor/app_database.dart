import 'package:expense_manager/core/constants.dart';
import 'package:expense_manager/data/models/category.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:rxdart/rxdart.dart';

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

class EntryWithCategoryData {
  final EntryEntityData entry;
  final CategoryEntityData category;

  EntryWithCategoryData({@required this.entry, @required this.category});

  @override
  String toString() {
    return 'EntryWithCategoryData{entry: ${entry.toString()}, category: ${category.toString()}';
  }
}

class CategoryWithSumData {
  final double total;
  final CategoryEntityData category;

  CategoryWithSumData({@required this.total, @required this.category});

  @override
  String toString() {
    return 'CategoryWithSumData{total: $total, category: $category}';
  }
}

final appDatabaseProvider = Provider((ref) => AppDatabase());

@UseMoor(tables: [EntryEntity, CategoryEntity])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super((FlutterQueryExecutor.inDatabaseFolder(
          path: 'db.sqlite',
          logStatements: true,
        )));

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(onCreate: (Migrator m) async {
      await m.createAll();
      await createDefaultCategory();
    }, beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    });
  }

  Stream<List<int>> getMonthList() {
    return (selectOnly(entryEntity, distinct: true)
          ..addColumns([entryEntity.modifiedDate.month]))
        .map((row) => row.read(entryEntity.modifiedDate.month))
        .watch();
  }

  Stream<List<int>> getMonthListByYear(int year) {
    return customSelect(
        "SELECT DISTINCT CAST(strftime('%m' , entry_entity.modified_date, 'unixepoch') AS INTEGER) AS c1 FROM entry_entity WHERE (CAST(strftime('%Y', modified_date,'unixepoch') AS INTEGER)) = :year;",
        readsFrom: {
          entryEntity
        },
        variables: [
          Variable.withInt(year)
        ]).map((QueryRow row) => row.readInt("c1")).watch();
  }

  Stream<List<int>> getYearList() {
    return (selectOnly(entryEntity, distinct: true)
          ..addColumns([entryEntity.modifiedDate.year]))
        .map((row) => row.read(entryEntity.modifiedDate.year))
        .watch();
  }

  Stream<int> addEntry(EntryEntityCompanion entity) =>
      into(entryEntity).insert(entity).asStream();

  Stream<bool> updateEntry(EntryEntityCompanion entity) =>
      update(entryEntity).replace(entity).asStream();

  Stream<int> deleteEntry(int id) =>
      (delete(entryEntity)..where((tbl) => tbl.id.equals(id))).go().asStream();

  Stream<List<EntryEntityData>> getAllEntry() {
    return select(entryEntity).get().asStream();
  }

  Stream<List<EntryEntityData>> getAllEntryByCategory(int categoryName) {
    return (select(entryEntity)
          ..where((row) => row.categoryId.equals(categoryName))
          ..orderBy([
            (u) => OrderingTerm(
                expression: u.modifiedDate, mode: OrderingMode.desc)
          ]))
        .get()
        .asStream();
  }

  Stream<List<EntryWithCategoryData>> getAllEntryWithCategory(
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
            return EntryWithCategoryData(
                entry: row.readTableOrNull(entryEntity),
                category: row.readTableOrNull(categoryEntity));
          }).toList();
        });
  }

  Stream<List<EntryWithCategoryData>> getAllEntryWithCategoryByMonth(
      int month) {
    return (select(entryEntity)
          ..where((tbl) => tbl.modifiedDate.month.equals(month))
          ..orderBy([(u) => OrderingTerm.desc(u.modifiedDate)]))
        .join([
          leftOuterJoin(categoryEntity,
              categoryEntity.id.equalsExp(entryEntity.categoryId))
        ])
        .watch()
        .map((List<TypedResult> rows) {
          return rows.map((TypedResult row) {
            return EntryWithCategoryData(
                entry: row.readTableOrNull(entryEntity),
                category: row.readTableOrNull(categoryEntity));
          }).toList();
        })
        .map((event) {
          print(event);
          return event;
        });
  }

  Stream<List<CategoryWithSumData>> getAllCategoryWithSumByMonth(int month) {
    return ((select(entryEntity)
              ..where((tbl) => tbl.modifiedDate.month.equals(month)))
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
                total: row.read(entryEntity.amount.sum()),
                category: row.readTableOrNull(categoryEntity));
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
                total: row.read(entryEntity.amount.sum()),
                category: row.readTableOrNull(categoryEntity));
          }).toList();
        });
  }

  Stream<List<CategoryEntityData>> getAllCategory() => (select(categoryEntity)
        ..orderBy([
          (u) => OrderingTerm(expression: u.position, mode: OrderingMode.asc)
        ]))
      .watch();

  Future<List<CategoryEntityData>> getAllCategory1() => (select(categoryEntity)
        ..orderBy([
          (u) => OrderingTerm(expression: u.position, mode: OrderingMode.asc)
        ]))
      .get();

  Stream<int> addCategory(CategoryEntityCompanion category) =>
      into(categoryEntity).insert(category).asStream();

  Stream<int> addCategory1(CategoryEntityCompanion category) => customInsert(
      "INSERT INTO category_entity (position, name, icon, icon_color) VALUES ((SELECT IFNULL(MAX(position), 0) + 1 FROM category_entity), '${category.name.value}', '${category.icon.value}', '${category.iconColor.value}');",
      updates: {categoryEntity}).asStream();

  Stream<bool> updateCategory(CategoryEntityCompanion entity) =>
      update(categoryEntity).replace(entity).asStream();

  Stream<int> deleteCategory(int id) =>
      (delete(categoryEntity)..where((tbl) => tbl.id.equals(id)))
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
      List<Category> categoryList = await getAllCategory1().then(
          (value) => value.map((e) => Category.fromCategoryEntity(e)).toList());
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
      categoryList.forEach((element) async {
        await update(categoryEntity)
            .replace(element.toCategoryEntityCompanion());
        // await updateCategory(element.toCategoryEntityCompanion()).single;
      });

      return true;
    }).asStream();
  }

  Stream<List<CategoryWithSumData>> getAllCategoryWithSum() {
    return (select(entryEntity).join([])
          ..groupBy([entryEntity.categoryId])
          ..addColumns([entryEntity.amount.sum()])
          ..orderBy([OrderingTerm.desc(entryEntity.amount.sum())]))
        .join([
          innerJoin(categoryEntity,
              categoryEntity.id.equalsExp(entryEntity.categoryId))
        ])
        .get()
        .asStream()
        .map((List<TypedResult> rows) {
          return rows.map((TypedResult row) {
            return CategoryWithSumData(
                total: row.read(entryEntity.amount.sum()),
                category: row.readTableOrNull(categoryEntity));
          }).toList();
        });
  }

  Future createDefaultCategory() async {
    return transaction(() async {
      AppConstants.defaultCategoryList.forEach((category) async {
        await addCategory1(category.toCategoryEntityCompanion()).single;
      });
      return true;
    });
  }
}
