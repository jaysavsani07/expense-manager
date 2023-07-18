import 'package:expense_manager/core/app_localization.dart';
import 'package:expense_manager/core/color_scheme.dart';
import 'package:expense_manager/ui/setting/setting_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MonthlyCycleDateDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 24),
        Text(
          AppLocalization.of(context).getTranslatedVal("month_cycle_date"),
          style: Theme.of(context).textTheme.titleMedium,
        ),
        SizedBox(height: 16),
        Divider(color: Theme.of(context).colorScheme.crossLightColor),
        SizedBox(
          height: 250,
          child: Consumer(
            builder: (context, ref, child) {
              String selected =
                  ref.watch(monthStartDateStateNotifier.notifier).date;
              return ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
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
                  ]
                      .map((e) => InkWell(
                            onTap: () {
                              ref
                                  .watch(monthStartDateStateNotifier.notifier)
                                  .setDate(e);
                              Navigator.pop(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Center(
                                child: Text(
                                  e,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(
                                          fontSize: e == selected ? 24 : 14,
                                          fontWeight: e == selected
                                              ? FontWeight.bold
                                              : FontWeight.w500),
                                ),
                              ),
                            ),
                          ))
                      .toList());
            },
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
