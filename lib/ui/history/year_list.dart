import 'package:expense_manager/core/app_localization.dart';
import 'package:expense_manager/ui/history/history_view_model.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter_riverpod/all.dart';

class YearList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      final vm = watch(yearListProvider);
      return vm
          .when(
              data: (yearList) => yearList.isEmpty
                  ? Text(AppLocalization.of(context)
                          .getTranslatedVal("no_entry_added"))
                      .centered()
                      .h(200)
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: yearList.length,
                      itemBuilder: (context, index) => yearList[index]
                              .toString()
                              .text
                              .xl2
                              .center
                              .make()
                              .p8()
                              .onInkTap(() {
                            context.read(yearProvider).state = yearList[index];
                            Navigator.pop(context);
                          })),
              loading: () => CircularProgressIndicator(),
              error: (e, str) => Text(e.toString()).centered())
          .h(200);
    });
  }
}
