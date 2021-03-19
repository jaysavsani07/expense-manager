import 'package:expense_manager/core/CrashReportingTree.dart';
import 'package:expense_manager/core/Logger.dart';
import 'package:expense_manager/data/datasource/sharedpref/shared_preference_helper.dart';
import 'package:expense_manager/ui/app/app.dart';
import 'package:fimber/fimber.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Fimber.plantTree(DebugTree());
  Fimber.plantTree(CrashReportingTree());

  await Firebase.initializeApp();
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  final sharedPreferences = await SharedPreferences.getInstance();
  runApp(ProviderScope(
    observers: [Logger()],
    overrides: [
      sharedPreferencesProvider
          .overrideWithValue(SharedPreferencesHelper(sharedPreferences))
    ],
    child: MyApp(),
  ));
}
