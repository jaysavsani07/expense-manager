import 'package:expense_manager/data/models/category_with_sum.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dashboardViewModelProvider = ChangeNotifierProvider<DashboardViewModel>(
  (ref) => DashboardViewModel(),
);

class DashboardViewModel with ChangeNotifier {
  List<CategoryWithSum> list = [];
}
