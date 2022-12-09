import 'package:expense_manager/core/constants.dart';
import 'package:expense_manager/core/routes.dart';
import 'package:expense_manager/core/app_localization.dart';
import 'package:expense_manager/data/models/home_tab.dart';
import 'package:expense_manager/ui/dashboard/dashboard.dart';
import 'package:expense_manager/ui/history/history.dart';
import 'package:expense_manager/ui/home/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tuple/tuple.dart';

class HomeScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeViewModel = ref.watch(signInModelProvider);
    return Scaffold(
      body: homeViewModel.activeTab == HomeTab.dashboard
          ? Dashboard()
          : History(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.addEntry,
              arguments: Tuple3(EntryType.expense, null, null));
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
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
                            ? Color(0xff2196F3)
                            : null,
                      ),
                      SizedBox(width: 8),
                      Text(
                        AppLocalization.of(context)
                            .getTranslatedVal("dashboard"),
                        style: Theme.of(context).textTheme.subtitle2!.copyWith(
                            fontSize: 12,
                            color: homeViewModel.activeTab == HomeTab.dashboard
                                ? Color(0xff2196F3)
                                : null),
                      ),
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
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(24)),
                  onTap: () => homeViewModel.changeTab(1),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.history,
                        size: 20,
                        color: homeViewModel.activeTab == HomeTab.history
                            ? Color(0xff2196F3)
                            : null,
                      ),
                      SizedBox(width: 8),
                      Text(
                        AppLocalization.of(context).getTranslatedVal("history"),
                        style: Theme.of(context).textTheme.subtitle2!.copyWith(
                            fontSize: 12,
                            color: homeViewModel.activeTab == HomeTab.history
                                ? Color(0xff2196F3)
                                : null),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
