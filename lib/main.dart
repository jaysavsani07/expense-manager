import 'package:expense_manager/data/datasource/local/entry_datasource_imp.dart';
import 'package:expense_manager/data/datasource/local/model/app_database.dart';
import 'package:expense_manager/data/middleware/repositry_middleware.dart';
import 'package:expense_manager/ui/app/app_state.dart';
import 'package:expense_manager/data/repository/entry_repository_imp.dart';
import 'package:expense_manager/ui/app/app.dart';
import 'package:expense_manager/ui/app/app_reducer.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp(
    store: Store<AppState>(
      appReducer,
      middleware: [
        LoggingMiddleware.printer(),
        RepositoryMiddleware(
            repository: EntryRepositoryImp(
                entryDataSourceImp:
                    EntryDataSourceImp(appDatabase: AppDatabase())))
      ],
      initialState: AppState.initial(),
    ),
  ));
}
