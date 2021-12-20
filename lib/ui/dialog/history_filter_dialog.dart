import 'package:expense_manager/ui/history/entry_type.dart';
import 'package:expense_manager/ui/history/year_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HistoryFilterDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              EntryTypeView(),
              YearList(),
            ],
          ),
        );
      },
    );
  }
}
