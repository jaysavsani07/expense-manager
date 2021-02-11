import 'package:expense_manager/ui/history/history_list.dart';
import 'package:expense_manager/ui/history/history_viewmodel.dart';
import 'package:expense_manager/ui/history/month_list.dart';
import 'package:expense_manager/ui/history/year_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:velocity_x/velocity_x.dart';

class History extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final vm = watch(historyViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade50,
        title: "History".text.xl3.make(),
        actions: [
          Icon(Icons.calendar_today_rounded).p16().onInkTap(() {
            showModalBottomSheet(
                context: context,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                builder: (builder) => YearList(yearList: vm.yearList));
          })
        ],
      ),
      body: Column(
        children: [
          MonthList(),
          HistoryList(),
        ],
      ),
    );
  }
}
