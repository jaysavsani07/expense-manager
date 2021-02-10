import 'package:expense_manager/ui/history/history_list.dart';
import 'package:expense_manager/ui/history/month_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:velocity_x/velocity_x.dart';

class History extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade50,
        title: "History".text.xl3.make(),
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
