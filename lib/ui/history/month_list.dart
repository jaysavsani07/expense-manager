import 'package:expense_manager/ui/history/history_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:velocity_x/velocity_x.dart';

class MonthList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final vm = watch(monthListProvider);
    return SingleChildScrollView(
      child: vm
          .when(
              data: (monthList) => ListView(
                    shrinkWrap: false,
                    padding: EdgeInsets.only(left: 24),
                    scrollDirection: Axis.horizontal,
                    children: monthList
                        .map((e) => e.text
                                .color(context.read(monthProvider).state == e
                                    ? Colors.white
                                    : Colors.blue)
                                .size(12)
                                .medium
                                .make()
                                .pSymmetric(h: 14, v: 9)
                                .box
                                .color(context.read(monthProvider).state == e
                                    ? Colors.blue
                                    : Color(0xffEEEEEE))
                                .rounded
                                .make()
                                .onInkTap(() {
                              context.read(monthProvider).state = e;
                            }).pSymmetric(v: 8,h: 4))
                        .toList(),
                  ),
              loading: () => SizedBox(),
              error: (e, str) => Text(e.toString()))
          .h(48),
    );
  }
}
