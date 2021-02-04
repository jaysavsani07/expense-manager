import 'package:expense_manager/ui/app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ProviderScope(
    child: MyApp(),
  ));
}
