import 'package:dotted_border/dotted_border.dart';
import 'package:expense_manager/core/app_localization.dart';
import 'package:expense_manager/core/constants.dart';
import 'package:expense_manager/ui/category_details/bar_chart_view.dart';
import 'package:expense_manager/ui/category_details/category_details_view_model.dart';
import 'package:expense_manager/ui/category_details/category_list_view.dart';
import 'package:expense_manager/ui/dialog/category_details_filter_dialog.dart';
import 'package:expense_manager/ui/dialog/common_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios_rounded),
          ),
          title: DottedBorder(
            color: Theme.of(context).appBarTheme.titleTextStyle.color,
            dashPattern: [5, 5],
            radius: Radius.circular(12),
            borderType: BorderType.RRect,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Text(AppLocalization.of(context)
                  .getTranslatedVal("statistics"),
                style: Theme.of(context).appBarTheme.titleTextStyle,
              ),
            ),
          ),
          actions: [
            InkWell(
              onTap: () {
                showGeneralDialog(
                    context: context,
                    barrierDismissible: true,
                    barrierLabel: "categoryDetails",
                    transitionDuration: Duration(milliseconds: 200),
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        CommonAlertDialog(child: CategoryDetailsFilterDialog()),
                    transitionBuilder:
                        (context, animation, secondaryAnimation, child) =>
                            Transform.scale(
                              scale: animation.value,
                              alignment: Alignment(0.83, -0.83),
                              child: child,
                            ));
              },
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Icon(
                  Icons.filter_list_rounded,
                ),
              ),
            )
          ],
        ),
        body: Column(
          children: [
            SizedBox(height: 20),
            BarChartView(),
            SizedBox(height: 20),
            MonthListView(),
            SizedBox(height: 10),
            Expanded(child: CategoryListView())
          ],
        ));
  }
}

class MonthListView extends ConsumerWidget {
  const MonthListView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final monthList = ref
        .watch(categoryDetailsModelProvider.select((value) => value.monthList));
    return SizedBox(
      height: 48,
      child: ListView(
        shrinkWrap: false,
        padding: EdgeInsets.only(left: 24),
        scrollDirection: Axis.horizontal,
        children: monthList
            .map(
                (e) => Padding(
              padding:
              const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
              child: InkWell(
                onTap: () {
                  ref.read(categoryDetailsModelProvider).changeMonth(e);
                },
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 9, horizontal: 14),
                  decoration: BoxDecoration(
                    color: ref.watch(categoryDetailsModelProvider
                        .select((value) => value.month)) ==
                        e
                        ? Color(0xff2196F3)
                        : Theme.of(context).dividerColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    AppLocalization.of(context)
                        .getTranslatedVal(AppConstants.monthList[e]),
                    style: Theme.of(context).textTheme.subtitle2.copyWith(
                      fontSize: 12,
                      color: ref.watch(categoryDetailsModelProvider
                          .select((value) => value.month)) ==
                          e
                          ? Colors.white
                          : Color(0xff2196F3),
                    ),
                  ),
                ),
              ),
            )
        )
            .toList(),
      ),
    );
  }
}

class YearListView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(yearListStreamProvider);

    return SizedBox(
      height: 48,
      child: vm.when(
        data: (yearList) => ListView(
          shrinkWrap: false,
          padding: EdgeInsets.only(left: 24),
          scrollDirection: Axis.horizontal,
          children: yearList
              .map(
                (e) => Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                  child: InkWell(
                    onTap: () {
                      ref.read(selectedYearProvider.state).state = e;
                    },
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 9, horizontal: 14),
                      decoration: BoxDecoration(
                        color: ref.watch(selectedYearProvider.state).state == e
                            ? Color(0xff2196F3)
                            : Theme.of(context).dividerColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        e.toString(),
                        style: Theme.of(context).textTheme.subtitle2.copyWith(
                              fontSize: 12,
                              color:
                                  ref.watch(selectedYearProvider.state).state ==
                                          e
                                      ? Colors.white
                                      : Color(0xff2196F3),
                            ),
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
        loading: () => CircularProgressIndicator(),
        error: (e, str) => Center(child: Text(e.toString())),
      ),
    );
  }
}

class QuarterListView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(categoryDetailsModelProvider);

    return SizedBox(
      height: 48,
      child: ListView(
        shrinkWrap: false,
        padding: EdgeInsets.only(left: 24),
        scrollDirection: Axis.horizontal,
        children: vm.quarterList.entries.toList().reversed
            .map((e) => Padding(
            padding:
            const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
            child: InkWell(
              onTap: () {
                vm.changeQuarter(e.key);
              },
              borderRadius: BorderRadius.circular(15),
              child: Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 9, horizontal: 14),
                decoration: BoxDecoration(
                  color: vm.quarterlyType == e.key
                      ? Color(0xff2196F3)
                      : Theme.of(context).dividerColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  "Q${e.key.index+1}",
                  style: Theme.of(context).textTheme.subtitle2.copyWith(
                    fontSize: 12,
                    color:
                    vm.quarterlyType  ==
                        e.key
                        ? Colors.white
                        : Color(0xff2196F3),
                  ),
                ),
              ),
            ),
          ),
        )
            .toList(),
      ),
    );
  }
}
