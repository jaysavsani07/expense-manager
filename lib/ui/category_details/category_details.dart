import 'package:dotted_border/dotted_border.dart';
import 'package:expense_manager/core/app_localization.dart';
import 'package:expense_manager/core/constants.dart';
import 'package:expense_manager/ui/app/app_state.dart';
import 'package:expense_manager/ui/category_details/category_details_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

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
            color: Theme.of(context).appBarTheme.textTheme.headline6.color,
            dashPattern: [5, 5],
            radius: Radius.circular(12),
            borderType: BorderType.RRect,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Text(AppLocalization.of(context)
                  .getTranslatedVal("total_expense")),
            ),
          ),
        ),
        body: Column(
          children: [
            const TotalAmount(),
            SizedBox(height: 30),
            const CategoryFilterView(),
            SizedBox(height: 20),
            Expanded(child: const CategoryList1())
          ],
        ));
  }
}

class TotalAmount extends ConsumerWidget {
  const TotalAmount({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final totalAmount = ref.watch(categoryDetailsTotalAmountProvider);
    var currency = ref.watch(appStateNotifier).currency.item1;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Center(
            child: Text(
              "${NumberFormat.simpleCurrency(locale: currency, decimalDigits: 0).format(totalAmount)}",
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  .copyWith(fontSize: 32, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}

class CategoryFilterView extends ConsumerWidget {
  const CategoryFilterView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filterType = ref.watch(categoryDetailsFilterProvider.state);
    final yearList = ref.watch(categoryDetailsYearListProvider);
    return yearList.when(
        data: (list) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [...list]
                    .map((e) => Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 4),
                          child: InkWell(
                            onTap: () {
                              ref
                                  .read(categoryDetailsFilterProvider.state)
                                  .state = e;
                            },
                            borderRadius: BorderRadius.circular(15),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 9, horizontal: 14),
                              decoration: BoxDecoration(
                                color: filterType == e
                                    ? Color(0xff2196F3)
                                    : Theme.of(context).dividerColor,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Text(
                                (e.item1 == "Month"
                                        ? AppLocalization.of(context)
                                            .getTranslatedVal(
                                                AppConstants.monthList[e.item2])
                                        : e.item2)
                                    .toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2
                                    .copyWith(
                                      fontSize: 12,
                                      color: filterType == e
                                          ? Colors.white
                                          : Color(0xff2196F3),
                                    ),
                              ),
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ),
        loading: () => SizedBox(),
        error: (e, str) => SizedBox());
  }
}

class CategoryList1 extends ConsumerWidget {
  const CategoryList1({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = ref.watch(categoryDetailsModelProvider).categoryList;
    var currency = ref.watch(appStateNotifier).currency.item1;
    return ListView(
      children: list
          .map((e) => Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                child: Row(
                  children: [
                    Icon(
                      e.category.icon,
                      color: e.category.iconColor,
                      size: 20,
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                e.category.name,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2
                                    .copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: 8),
                              Text(
                                "${NumberFormat.simpleCurrency(locale: currency, decimalDigits: 0).format(e.total)}",
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(width: 8),
                          LinearPercentIndicator(
                            lineHeight: 6,
                            percent: e.total / list.first.total,
                            padding: EdgeInsets.symmetric(horizontal: 4),
                            backgroundColor: Theme.of(context).dividerColor,
                            progressColor: e.category.iconColor,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ))
          .toList(),
    );
  }
}
