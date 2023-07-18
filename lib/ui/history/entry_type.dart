import 'package:expense_manager/core/app_localization.dart';
import 'package:expense_manager/core/constants.dart';
import 'package:expense_manager/ui/history/history_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EntryTypeView extends ConsumerWidget {
  const EntryTypeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(entryTypeProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                ref.read(entryTypeProvider.notifier).state = EntryType.all;
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                  side: vm == EntryType.all
                      ? BorderSide(
                          width: 1,
                          color: Color(0xff2196F3),
                        )
                      : BorderSide.none,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    AppLocalization.of(context).getTranslatedVal("all"),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                ref.read(entryTypeProvider.notifier).state = EntryType.expense;
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                  side: vm == EntryType.expense
                      ? BorderSide(
                          width: 1,
                          color: Color(0xff2196F3),
                        )
                      : BorderSide.none,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    AppLocalization.of(context).getTranslatedVal("expense"),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                ref.read(entryTypeProvider.notifier).state = EntryType.income;
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                  side: vm == EntryType.income
                      ? BorderSide(
                          width: 1,
                          color: Color(0xff2196F3),
                        )
                      : BorderSide.none,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    AppLocalization.of(context).getTranslatedVal("income"),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
