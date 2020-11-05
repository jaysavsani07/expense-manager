import 'package:expense_manager/core/constants.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'app_database.g.dart';

class EntryEntity extends Table {
  IntColumn get id => integer().autoIncrement()();

  RealColumn get amount => real()();
}

class CategoryEntity extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text().withLength(min: 3, max: 20)();

  TextColumn get icon => text()();

  TextColumn get iconColor => text()();
}

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
    });
  }

  Stream<List<EntryEntityData>> getAllEntry() =>
      select(entryEntity).get().asStream();

  Stream<int> addNewEntry(EntryEntityCompanion entity) =>
      into(entryEntity).insert(entity).asStream();

  Stream<List<CategoryEntityData>> getAllCategory() =>
      select(categoryEntity).get().asStream();

  Stream<int> addNewCategory(CategoryEntityCompanion category) =>
      into(categoryEntity).insert(category).asStream();

  Future createDefaultCategory() async {
    AppConstants.defaultCategoryList.forEach((category) async {
      await addNewCategory(category.toCategoryEntityCompanion()).single;
    });
  }
}
