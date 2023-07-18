// import 'dart:io';
//
// import 'package:drift/drift.dart';
// import 'package:drift/native.dart';
// import 'package:expense_manager/core/constants.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:path/path.dart' as p;
// import 'package:path_provider/path_provider.dart';
//
// part 'new_app_database.g.dart';
//
// class EntryEntity extends Table {
//   IntColumn get id => integer().autoIncrement()();
//
//   RealColumn get amount => real()();
//
//   IntColumn get categoryId =>
//       integer().nullable().references(CategoryEntity, #id)();
//
//   DateTimeColumn get modifiedDate => dateTime()();
//
//   TextColumn get description => text().withLength(max: 100)();
// }
//
// class CategoryEntity extends Table {
//   IntColumn get id => integer().autoIncrement()();
//
//   IntColumn get position => integer()();
//
//   TextColumn get name => text().withLength(min: 3, max: 20)();
//
//   TextColumn get icon => text().nullable()();
//
//   TextColumn get iconColor => text()();
// }
//
// class IncomeEntryEntity extends Table {
//   IntColumn get id => integer().autoIncrement()();
//
//   RealColumn get amount => real()();
//
//   IntColumn get categoryId =>
//       integer().nullable().references(CategoryEntity, #id)();
//
//   // integer().nullable().customConstraint(
//   //     'NULL REFERENCES income_category_entity(id) ON DELETE SET NULL')();
//
//   DateTimeColumn get modifiedDate => dateTime()();
//
//   TextColumn get description => text().withLength(max: 100)();
// }
//
// class IncomeCategoryEntity extends Table {
//   IntColumn get id => integer().autoIncrement()();
//
//   IntColumn get position => integer()();
//
//   TextColumn get name => text().withLength(min: 3, max: 20)();
//
//   TextColumn get icon => text().nullable()();
//
//   TextColumn get iconColor => text()();
// }
//
// final appDatabaseProvider = Provider((ref) => AppDatabase());
//
// Future<File> get databaseFile async {
//   // We use `path_provider` to find a suitable path to store our data in.
//   final appDir = await getApplicationDocumentsDirectory();
//   final dbPath = p.join(appDir.path, 'todos.db');
//   return File(dbPath);
// }
//
// /// Obtains a database connection for running drift in a Dart VM.
// DatabaseConnection connect() {
//   return DatabaseConnection.delayed(Future(() async {
//     return NativeDatabase.createBackgroundConnection(await databaseFile);
//   }));
// }
//
// @DriftDatabase(tables: [
//   EntryEntity,
//   CategoryEntity,
//   IncomeCategoryEntity,
//   IncomeEntryEntity
// ])
// class AppDatabase extends _$AppDatabase {
//   // AppDatabase()
//   //     : super((SqfliteQueryExecutor.inDatabaseFolder(
//   //         path: 'db.sqlite',
//   //         logStatements: true,
//   //       )));
//
//   AppDatabase() : super(connect());
//
//   @override
//   int get schemaVersion => 3;
//
//   @override
//   MigrationStrategy get migration {
//     return MigrationStrategy(
//       onCreate: (Migrator m) async {
//         await m.createAll();
//         AppConstants.defaultCategoryList.forEach((category) async {
//           await addExpenseCategory(category.toCategoryEntityCompanion()).single;
//         });
//         AppConstants.defaultIncomeCategoryList.forEach((category) async {
//           await addIncomeCategory(category.toIncomeCategoryEntityCompanion())
//               .single;
//         });
//       },
//       beforeOpen: (details) async {
//         await customStatement('PRAGMA foreign_keys = ON');
//       },
//       onUpgrade: (Migrator m, int from, int to) async {
//         if (from == 1) {
//           // await m.createTable(incomeCategoryEntity);
//           // await m.createTable(incomeEntryEntity);
//           // AppConstants.defaultIncomeCategoryList.forEach((category) async {
//           //   await addIncomeCategory(category.toIncomeCategoryEntityCompanion())
//           //       .single;
//           // });
//         }
//       },
//     );
//   }
//
//   Stream<int> addExpenseCategory(CategoryEntityCompanion category) => customInsert(
//       "INSERT INTO category_entity (position, name, icon, icon_color) VALUES ((SELECT IFNULL(MAX(position), 0) + 1 FROM category_entity), '${category.name.value}', '${category.icon.value}', '${category.iconColor.value}');",
//       updates: {categoryEntity}).asStream();
//
//   Stream<int> addIncomeCategory(IncomeCategoryEntityCompanion incomeCategory) =>
//       customInsert(
//           "INSERT INTO income_category_entity (position, name, icon, icon_color) VALUES ((SELECT IFNULL(MAX(position), 0) + 1 FROM income_category_entity), '${incomeCategory.name.value}', '${incomeCategory.icon.value}', '${incomeCategory.iconColor.value}');",
//           updates: {incomeCategoryEntity}).asStream();
//
//   Stream<int> addExpenseEntry(EntryEntityCompanion entity) =>
//       into(entryEntity).insert(entity).asStream();
//
//   Stream<int> addIncomeEntry(IncomeEntryEntityCompanion entity) {
//     return into(incomeEntryEntity).insert(entity).asStream();
//   }
//
//   Stream<bool> updateExpenseEntry(EntryEntityCompanion entity) {
//     return update(entryEntity).replace(entity).asStream();
//   }
//
//   Stream<bool> updateIncomeEntry(IncomeEntryEntityCompanion entity) {
//     return update(incomeEntryEntity).replace(entity).asStream();
//   }
//
//   Stream<int> deleteExpenseEntry(int id) =>
//       (delete(entryEntity)..where((tbl) => tbl.id.equals(id))).go().asStream();
//
//   Stream<int> deleteIncomeEntry(int id) =>
//       (delete(incomeEntryEntity)..where((tbl) => tbl.id.equals(id)))
//           .go()
//           .asStream();
//
//
//   Stream<List<int?>> getExpenseYearList() {
//     return (selectOnly(entryEntity, distinct: true)
//       ..addColumns([entryEntity.modifiedDate.year]))
//         .map((row) => row.read(entryEntity.modifiedDate.year))
//         .watch();
//   }
//
//   Stream<List<int?>> getIncomeYearList() {
//     return (selectOnly(incomeEntryEntity, distinct: true)
//       ..addColumns([incomeEntryEntity.modifiedDate.year]))
//         .map((row) => row.read(incomeEntryEntity.modifiedDate.year))
//         .watch();
//   }
// }
