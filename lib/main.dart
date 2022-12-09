import 'package:expense_manager/core/CrashReportingTree.dart';
import 'package:expense_manager/core/Logger.dart';
import 'package:expense_manager/data/datasource/sharedpref/shared_preference_helper.dart';
import 'package:expense_manager/ui/app/app.dart';
import 'package:fimber/fimber.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kDebugMode) {
    Fimber.plantTree(DebugTree(useColors: true));
    Fimber.plantTree(CrashReportingTree());
  } else {
    Fimber.plantTree(CrashReportingTree());
  }
  await Firebase.initializeApp();
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  final sharedPreferences = await SharedPreferences.getInstance();
  runApp(ProviderScope(
    observers: [Logger()],
    overrides: [
      sharedPreferencesProvider
          .overrideWithValue(SharedPreferencesHelper(prefs: sharedPreferences))
    ],
    child: MyApp(),
  ));
}
