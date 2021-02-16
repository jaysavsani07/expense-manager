import 'package:expense_manager/data/datasource/sharedpref/shared_preference_helper.dart';
import 'package:expense_manager/ui/app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();
  runApp(ProviderScope(
    overrides: [
      sharedPreferencesProvider
          .overrideWithValue(SharedPreferencesHelper(sharedPreferences))
    ],
    child: MyApp(),
  ));
}
