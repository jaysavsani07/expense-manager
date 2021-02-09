import 'package:expense_manager/ui/history/history_list.dart';
import 'package:expense_manager/ui/history/month_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:velocity_x/velocity_x.dart';

class History1 extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Column(
      children: [
        MonthList(),
        HistoryList(),
      ],
    );
  }
}
