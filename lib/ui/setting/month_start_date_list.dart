import 'package:expense_manager/ui/setting/setting_view_model.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter_riverpod/all.dart';

class MonthStartDateList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      final vm = watch(monthStartDateStateNotifier);
      return ListView(
          shrinkWrap: true,
          children: [
            "1",
            "2",
            "3",
            "4",
            "5",
            "6",
            "7",
            "8",
            "9",
            "10",
            "11",
            "12",
            "13",
            "14",
            "15",
            "16",
            "17",
            "18",
            "19",
            "20",
            "21",
            "22",
            "23",
            "24",
            "25",
            "26",
            "27",
            "28",
          ]
              .map((e) => (vm.date == e ? e.text.bold.xl3 : e.text.xl2)
                      .center
                      .make()
                      .p8()
                      .onInkTap(() {
                    context.read(monthStartDateStateNotifier).setDate(e);
                    Navigator.pop(context);
                  }))
              .toList());
    });
  }
}
