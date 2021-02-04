import 'package:expense_manager/data/models/home_tab.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final signInModelProvider = ChangeNotifierProvider<HomeViewModel>(
  (ref) => HomeViewModel(),
);

class HomeViewModel with ChangeNotifier {
  HomeTab activeTab = HomeTab.dashboard;

  changeTab(int index) {
    if (index == 0) {
      activeTab = HomeTab.dashboard;
    } else {
      activeTab = HomeTab.history;
    }
    notifyListeners();
  }
}
