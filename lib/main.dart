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
import 'package:stack_trace/stack_trace.dart' as stack_trace;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterError.demangleStackTrace = (StackTrace stack) {
    if (stack is stack_trace.Trace) return stack.vmTrace;
    if (stack is stack_trace.Chain) return stack.toTrace().vmTrace;
    return stack;
  };

  await Firebase.initializeApp();

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

  if (kDebugMode) {
    Fimber.plantTree(DebugTree(useColors: true));
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
  } else {
    Fimber.plantTree(CrashReportingTree());
  }

  // Errors outside of Flutter
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

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


