import 'package:moor_flutter/moor_flutter.dart';

part 'app_database.g.dart';

class EntryEntity extends Table {
  IntColumn get id => integer().autoIncrement()();

  RealColumn get amount => real()();
}

@UseMoor(tables: [EntryEntity])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      // Specify the location of the database file
      : super((FlutterQueryExecutor.inDatabaseFolder(
          path: 'db.sqlite',
          // Good for debugging - prints SQL in the console
          logStatements: true,
        )));

  @override
  int get schemaVersion => 1;

  Stream<List<EntryEntityData>> getAllEntry() => select(entryEntity).get().asStream();

  Stream<int> addNewEntry(EntryEntityCompanion entity) =>
      into(entryEntity).insert(entity).asStream();
}
