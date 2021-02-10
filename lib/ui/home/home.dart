import 'package:expense_manager/core/keys.dart';
import 'package:expense_manager/core/localization.dart';
import 'package:expense_manager/core/routes.dart';
import 'package:expense_manager/data/models/home_tab.dart';
import 'package:expense_manager/ui/dashboard/dashboard.dart';
import 'package:expense_manager/ui/history/history.dart';
import 'package:expense_manager/ui/home/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final homeViewModel = watch(signInModelProvider);
    return ProviderListener<HomeViewModel>(
      provider: signInModelProvider,
      onChange: (context, model) async {},
      child: Scaffold(
        body: homeViewModel.activeTab == HomeTab.dashboard
            ? Dashboard()
            : History(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.addEntry, arguments: null);
          },
          backgroundColor: Vx.black,
          child: Icon(
            Icons.add,
            color: Vx.white,
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: HomeTab.values.indexOf(homeViewModel.activeTab),
          onTap: homeViewModel.changeTab,
          items: HomeTab.values.map((tab) {
            return BottomNavigationBarItem(
              icon: Icon(
                tab == HomeTab.dashboard ? Icons.home : Icons.history,
                key: tab == HomeTab.dashboard
                    ? AppKeys.todoTab
                    : AppKeys.statsTab,
              ),
              label: tab == HomeTab.dashboard
                  ? AppLocalizations.dashboard
                  : AppLocalizations.history,
            );
          }).toList(),
        ),
      ),
    );
  }
}
