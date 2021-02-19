import 'package:expense_manager/core/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'app_database.g.dart';

class EntryEntity extends Table {
  IntColumn get id => integer().autoIncrement()();

  RealColumn get amount => real()();

  TextColumn get categoryName => text().nullable().customConstraint(
      'NULL REFERENCES category_entity(name) ON DELETE SET NULL')();

  DateTimeColumn get modifiedDate => dateTime()();

  TextColumn get description => text().withLength(max: 100)();
}

class CategoryEntity extends Table {
  IntColumn get id => integer()();

  TextColumn get name => text().withLength(min: 3, max: 20)();

  TextColumn get icon => text()();

  TextColumn get iconColor => text()();

  @override
  Set<Column> get primaryKey => {name};
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

  Stream<List<EntryEntityData>> getAllEntry() {
    return select(entryEntity).get().asStream();
  }

  Stream<List<EntryEntityData>> getAllEntryByCategory(String categoryName) {
    return (select(entryEntity)
          ..where((row) => row.categoryName.equals(categoryName))
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
              categoryEntity.name.equalsExp(entryEntity.categoryName))
        ])
        .watch()
        .map((List<TypedResult> rows) {
          return rows.map((TypedResult row) {
            return EntryWithCategoryData(
                entry: row.readTable(entryEntity),
                category: row.readTable(categoryEntity));
          }).toList();
        });
  }

  Stream<List<EntryWithCategoryData>> getAllEntryWithCategoryByMonth(
      int month) {
    return (select(entryEntity)
          ..where((tbl) => tbl.modifiedDate.month.equals(month))
          ..orderBy([
            (u) => OrderingTerm(
                expression: u.modifiedDate, mode: OrderingMode.desc)
          ]))
        .join([
          leftOuterJoin(categoryEntity,
              categoryEntity.name.equalsExp(entryEntity.categoryName))
        ])
        .watch()
        .map((List<TypedResult> rows) {
          return rows.map((TypedResult row) {
            return EntryWithCategoryData(
                entry: row.readTable(entryEntity),
                category: row.readTable(categoryEntity));
          }).toList();
        });
  }

  Stream<List<CategoryEntityData>> getAllCategory() => (select(categoryEntity)
        ..orderBy(
            [(u) => OrderingTerm(expression: u.id, mode: OrderingMode.asc)]))
      .watch();

  Stream<int> addCategory(CategoryEntityCompanion category) =>
      into(categoryEntity).insert(category).asStream();

  Stream<int> addCategory1(CategoryEntityCompanion category) => customInsert(
      "INSERT INTO category_entity (id, name, icon, icon_color) VALUES ((SELECT IFNULL(MAX(id), 0) + 1 FROM category_entity), '${category.name.value}', '${category.icon.value}', '${category.iconColor.value}');",
      updates: {categoryEntity}).asStream();

  Stream<bool> updateCategory(CategoryEntityCompanion entity) =>
      update(categoryEntity).replace(entity).asStream();

  Stream<int> deleteCategory(int id) =>
      (delete(categoryEntity)..where((tbl) => tbl.id.equals(id)))
          .go()
          .asStream();

  Stream<bool> reorderCategory(int oldIndex, int newIndex) {
    return transaction(() async {
      await (update(categoryEntity)
            ..where((tbl) => tbl.id.equals(oldIndex + 1)))
          .write(CategoryEntityCompanion(id: Value(-1)));
      await (update(categoryEntity)
            ..where((tbl) => tbl.id.equals(newIndex + 1)))
          .write(CategoryEntityCompanion(id: Value(oldIndex + 1)));
      await (update(categoryEntity)..where((tbl) => tbl.id.equals(-1)))
          .write(CategoryEntityCompanion(id: Value(newIndex + 1)));
      return true;
    }).asStream();
  }

  Stream<List<CategoryWithSumData>> getAllCategoryWithSum() {
    return (select(entryEntity).join([])
          ..groupBy([entryEntity.categoryName])
          ..addColumns([entryEntity.amount.sum()]))
        .join([
          innerJoin(categoryEntity,
              categoryEntity.name.equalsExp(entryEntity.categoryName))
        ])
        .watch()
        .map((List<TypedResult> rows) {
          return rows.map((TypedResult row) {
            return CategoryWithSumData(
                total: row.read(entryEntity.amount.sum()),
                category: row.readTable(categoryEntity));
          }).toList();
        });
  }

  Future createDefaultCategory() async {
    AppConstants.defaultCategoryList.forEach((category) async {
      await addCategory1(category.toCategoryEntityCompanion()).single;
    });
  }
}
