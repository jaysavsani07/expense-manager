import 'package:expense_manager/core/app_localization.dart';
import 'package:expense_manager/ui/app/app_state.dart';
import 'package:expense_manager/ui/category_details/category_details_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class CategoryListView extends ConsumerWidget {
  const CategoryListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = ref.watch(
        categoryDetailsModelProvider.select((value) => value.categoryList));
    var currency = ref.watch(appStateNotifier).currency.item1;
    return list.when(
        data: (value) => (value.item2.isEmpty && value.item1.isEmpty)
            ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Text(
                  AppLocalization.of(context).getTranslatedVal("no_entry"),
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2!
                      .copyWith(fontSize: 12),
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (value.item1.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Text(
                          AppLocalization.of(context)
                              .getTranslatedVal("income"),
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2!
                              .copyWith(fontSize: 12),
                        ),
                      ),
                    if (value.item1.isNotEmpty)
                      ListView(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: value.item1
                            .map((e) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 24),
                                  child: Row(
                                    children: [
                                      Icon(
                                        e.category!.icon,
                                        color: e.category!.iconColor,
                                        size: 20,
                                      ),
                                      SizedBox(width: 16),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  e.category!.name,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .subtitle2!
                                                      .copyWith(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                ),
                                                SizedBox(width: 8),
                                                Text(
                                                  "${NumberFormat.simpleCurrency(locale: currency, decimalDigits: 0).format(e.total)}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .subtitle2!
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 8),
                                            LinearPercentIndicator(
                                              lineHeight: 6,
                                              percent: e.total /
                                                  value.item1.first.total,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 4),
                                              backgroundColor: Theme.of(context)
                                                  .dividerColor,
                                              progressColor:
                                                  e.category!.iconColor,
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ))
                            .toList(),
                      ),
                    SizedBox(height: 24),
                    if (value.item2.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Text(
                          AppLocalization.of(context)
                              .getTranslatedVal("expense"),
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2!
                              .copyWith(fontSize: 12),
                        ),
                      ),
                    if (value.item2.isNotEmpty)
                      ListView(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: value.item2
                            .map((e) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 24),
                                  child: Row(
                                    children: [
                                      Icon(
                                        e.category!.icon,
                                        color: e.category!.iconColor,
                                        size: 20,
                                      ),
                                      SizedBox(width: 16),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  e.category!.name,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .subtitle2!
                                                      .copyWith(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                ),
                                                SizedBox(width: 8),
                                                Text(
                                                  "${NumberFormat.simpleCurrency(locale: currency, decimalDigits: 0).format(e.total)}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .subtitle2!
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 8),
                                            LinearPercentIndicator(
                                              lineHeight: 6,
                                              percent: e.total /
                                                  value.item2.first.total,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 4),
                                              backgroundColor: Theme.of(context)
                                                  .dividerColor,
                                              progressColor:
                                                  e.category!.iconColor,
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ))
                            .toList(),
                      ),
                  ],
                ),
              ),
        error: (e, str) => Text(str.toString()),
        loading: () => Center(child: CircularProgressIndicator()));
  }
}
