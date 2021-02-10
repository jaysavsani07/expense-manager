import 'package:expense_manager/ui/history/history_list.dart';
import 'package:expense_manager/ui/history/history_viewmodel.dart';
import 'package:expense_manager/ui/history/month_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
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
            DatePicker.showDatePicker(
              context,
              maxDateTime: DateTime(vm.maxYear),
              minDateTime: DateTime(vm.minYear),
              initialDateTime: DateTime(vm.selectedYear),
              onConfirm: (x, y) {
                vm.changeYear(x.year);
              },
              pickerTheme: DateTimePickerTheme(
                  cancel: null, itemTextStyle: TextStyle(fontSize: 20)),
              dateFormat: 'yyyy',
            );
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
