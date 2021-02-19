import 'package:expense_manager/core/routes.dart';
import 'package:expense_manager/data/models/category.dart';
import 'package:expense_manager/data/models/entry_list.dart';
import 'package:expense_manager/ui/category_details/category_details_view_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:intl/intl.dart';
import 'package:velocity_x/velocity_x.dart';

class CategoryDetails extends ConsumerWidget {
  final Category category;

  CategoryDetails({@required this.category}) : super();

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final vm = watch(categoryDetailsModelProvider(category.name));
    return Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.close).onInkTap(() {
            Navigator.pop(context);
          }),
        ),
        body: vm.when(
            data: (list) => Column(
                  children: [
                    // LineChart(LineChartData(
                    //   lineTouchData: LineTouchData(enabled: false),
                    //   gridData: FlGridData(show: false),
                    //   titlesData: FlTitlesData(show: false),
                    //   borderData: FlBorderData(show: false),
                    //   minX: 0,
                    //   maxX: list.length.toDouble(),
                    //   minY: 0,
                    //   maxY: list
                    //       .map((e) => e.list
                    //           .map((e) => e.amount)
                    //           .reduce((value, element) => value + element))
                    //       .reduce((value, element) =>
                    //           value > element ? value : element),
                    //   lineBarsData: [
                    //     LineChartBarData(
                    //       spots:
                    //        list.asMap()
                    //             .entries
                    //             .map((e) => FlSpot(
                    //                 e.key.toDouble(),
                    //                 e.value.list.map((e) => e.amount).reduce(
                    //                     (value, element) => value + element)))
                    //             .toList()
                    //       ,
                    //       isCurved: true,
                    //       colors: [category.iconColor],
                    //       barWidth: 2,
                    //       isStrokeCapRound: true,
                    //       dotData: FlDotData(show: false),
                    //     ),
                    //   ],
                    // )).wh(context.percentWidth*100,context.percentHeight*25).p(16),
                    24.heightBox,
                    Row(
                      children: [
                        Icon(
                          category.icon,
                          size: 36,
                          color: category.iconColor,
                        ).pSymmetric(h: 24),
                        category.name.text.xl2.bold.make(),
                      ],
                    ),
                    24.heightBox,
                    ListView(
                      shrinkWrap: true,
                      children: list
                          .map((EntryList entry) => Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  entry.title.text.light.make(),
                                  8.heightBox,
                                  ListView(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    children: entry.list
                                        .map((e) => Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    category.name.text.bold.base
                                                        .make(),
                                                    "${NumberFormat.simpleCurrency().currencySymbol}${e.amount.toString().replaceAll(RegExp(r"([.]*0)(?!.*\d)"), "")}"
                                                        .text
                                                        .lg
                                                        .make()
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    DateFormat('d MMM')
                                                        .format(e.modifiedDate)
                                                        .text
                                                        .make(),
                                                    Icon(
                                                      Icons.circle,
                                                      size: 8,
                                                    ).pSymmetric(h: 4),
                                                    DateFormat.Hm()
                                                        .format(e.modifiedDate)
                                                        .text
                                                        .make(),
                                                  ],
                                                ),
                                              ],
                                            )
                                                .pSymmetric(h: 8, v: 8)
                                                .pSymmetric(v: 4)
                                                .onInkTap(() {
                                              Navigator.pushNamed(
                                                  context, AppRoutes.addEntry,
                                                  arguments: e);
                                            }))
                                        .toList(),
                                  )
                                ],
                              ).pSymmetric(h: 16, v: 12))
                          .toList(),
                    ).expand(),
                  ],
                ),
            loading: () => CircularProgressIndicator(),
            error: (e, str) => Text(e.toString())));
  }
}
