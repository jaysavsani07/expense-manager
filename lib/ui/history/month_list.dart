import 'package:expense_manager/ui/history/month_list_viewmodel.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter/widgets.dart';
import 'package:velocity_x/velocity_x.dart';

class MonthList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final vm = watch(monthListViewModelProvider);
    return SingleChildScrollView(
      child: ListView(
        shrinkWrap: false,
        scrollDirection: Axis.horizontal,
        children: vm.monthList
            .map((e) => e.text
            .color(vm.selectedMonth == e ? Vx.white : Vx.black)
            .base
            .make()
            .pSymmetric(h: 12, v: 4)
            .box
            .color(vm.selectedMonth == e ? Vx.black : Vx.gray500)
            .withRounded(value: 4)
            .margin(EdgeInsets.all(6))
            .make()
            .onInkTap(() {
          vm.changeMonth(e);
        }))
            .toList(),
      ).h(40),
    );
  }
}
