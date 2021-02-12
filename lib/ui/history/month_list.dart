import 'package:expense_manager/ui/history/history_view_model.dart';
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
                    scrollDirection: Axis.horizontal,
                    children: monthList
                        .map((e) => e.text
                                .color(context.read(monthProvider).state == e
                                    ? Vx.white
                                    : Vx.black)
                                .base
                                .make()
                                .pSymmetric(h: 12, v: 4)
                                .box
                                .color(context.read(monthProvider).state == e
                                    ? Vx.black
                                    : Vx.gray500)
                                .withRounded(value: 4)
                                .margin(EdgeInsets.all(6))
                                .make()
                                .onInkTap(() {
                              context.read(monthProvider).state = e;
                            }))
                        .toList(),
                  ),
              loading: () => SizedBox(),
              error: (e, str) => Text(e.toString()))
          .h(40),
    );
  }
}
