import 'package:expense_manager/core/routes.dart';
import 'package:expense_manager/core/app_localization.dart';
import 'package:expense_manager/ui/app/app_state.dart';
import 'package:expense_manager/ui/dashboard/dashboard_state.dart';
import 'package:expense_manager/ui/dashboard/pie_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:tuple/tuple.dart';

class CategoryChartView extends ConsumerWidget {
  const CategoryChartView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(categoryPieChartVisibilityProvider.state);
    return Visibility(
      visible: !vm.state,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 24, top: 30, bottom: 20),
            child: Text(
              AppLocalization.of(context).getTranslatedVal("total_expense"),
              style: Theme.of(context)
                  .textTheme
                  .subtitle2
                  .copyWith(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const CategoryPieChartView(),
        ],
      ),
    );
  }
}

class CategoryPieChartView extends ConsumerWidget {
  const CategoryPieChartView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(categoryPieChartProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, AppRoutes.categoryDetails);
        },
        borderRadius: BorderRadius.circular(6),
        child: Card(
          color: Theme.of(context).primaryColor,
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                vm.isEmpty
                    ? SizedBox()
                    : Expanded(
                        child: SizedBox(
                        height: 140,
                        width: 140,
                        child: PieChart(
                          dataMap: [
                            ...vm.map((e) => Tuple2(e.value, e.color)).toList()
                          ],
                          animationDuration: Duration(milliseconds: 800),
                          chartLegendSpacing: 16,
                          chartRadius:
                              MediaQuery.of(context).size.width / 3.2 > 300
                                  ? 300
                                  : MediaQuery.of(context).size.width / 3.2,
                          initialAngleInDegree: 0,
                          centerText: const TotalAmount(),
                          ringStrokeWidth: 12,
                          emptyColor: Colors.grey,
                        ),
                      )),
                SizedBox(width: 24),
                CategoryPieChatListView()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CategoryPieChatListView extends ConsumerWidget {
  const CategoryPieChatListView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(categoryPieChartListProvider);
    return Expanded(
      child: SizedBox(
          height: 140,
          child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            children: vm
                .map((list) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.circle,
                            size: 10,
                            color: list.iconColor,
                          ),
                          SizedBox(width: 4),
                          Text(
                            list.name,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                .copyWith(overflow: TextOverflow.ellipsis),
                          ),
                        ],
                      ),
                    ))
                .toList(),
          )),
    );
  }
}

class TotalAmount extends ConsumerWidget {
  const TotalAmount({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final totalExpense = ref.watch(totalExpenseProvider);
    String currency = ref.watch(appStateNotifier).currency.item1;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          AppLocalization.of(context).getTranslatedVal("last_month"),
          style: Theme.of(context).textTheme.caption,
        ),
        FittedBox(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              "${NumberFormat.simpleCurrency(locale: currency, decimalDigits: 0).format(totalExpense)}",
              style: Theme.of(context)
                  .textTheme
                  .subtitle2
                  .copyWith(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        )
      ],
    );
  }
}
