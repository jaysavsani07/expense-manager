import 'package:expense_manager/core/app_localization.dart';
import 'package:expense_manager/ui/history/history_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';

class YearList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      final vm = watch(yearListProvider);
      return SizedBox(
        height: 200,
        child: vm.when(
          data: (yearList) => yearList.isEmpty
              ? SizedBox(
                  height: 200,
                  child: Center(
                    child: Text(AppLocalization.of(context)
                        .getTranslatedVal("no_entry_added")),
                  ),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: yearList.length,
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      context.read(yearProvider).state = yearList[index];
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        yearList[index].toString(),
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            .copyWith(fontSize: 26),
                      ),
                    ),
                  ),
                ),
          loading: () => CircularProgressIndicator(),
          error: (e, str) => Center(child: Text(e.toString())),
        ),
      );
    });
  }
}
