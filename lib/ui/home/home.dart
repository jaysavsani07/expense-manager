import 'package:expense_manager/core/localization.dart';
import 'package:expense_manager/core/routes.dart';
import 'package:expense_manager/data/models/home_tab.dart';
import 'package:expense_manager/ui/dashboard/dashboard.dart';
import 'package:expense_manager/ui/history/history.dart';
import 'package:expense_manager/ui/home/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:tuple/tuple.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final homeViewModel = watch(signInModelProvider);
    return Scaffold(
      body: homeViewModel.activeTab == HomeTab.dashboard
          ? Dashboard()
          : History(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.addEntry,
              arguments: Tuple2(null, null));
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        child: BottomAppBar(
          notchMargin: 8,
          shape: CircularNotchedRectangle(),
          child: Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 60,
                  child: InkWell(
                    onTap: () => homeViewModel.changeTab(0),
                    borderRadius:
                        BorderRadius.only(topRight: Radius.circular(24)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.dashboard,
                          size: 20,
                          color: homeViewModel.activeTab == HomeTab.dashboard
                              ? Colors.blue
                              : null,
                        ),
                        8.widthBox,
                        AppLocalizations.dashboard.text
                            .size(12)
                            .medium
                            .color(homeViewModel.activeTab == HomeTab.dashboard
                                ? Colors.blue
                                : null)
                            .make(),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: 60),
              Expanded(
                child: SizedBox(
                  height: 60,
                  child: InkWell(
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(24)),
                    onTap: () => homeViewModel.changeTab(1),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.history,
                          size: 20,
                          color: homeViewModel.activeTab == HomeTab.history
                              ? Colors.blue
                              : null,
                        ),
                        8.widthBox,
                        AppLocalizations.history.text
                            .size(12)
                            .medium
                            .color(homeViewModel.activeTab == HomeTab.history
                                ? Colors.blue
                                : null)
                            .make()
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
