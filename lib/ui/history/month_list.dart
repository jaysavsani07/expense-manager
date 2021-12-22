import 'package:expense_manager/core/app_localization.dart';
import 'package:expense_manager/ui/history/history_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MonthList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(monthListProvider);
    return SingleChildScrollView(
      child: SizedBox(
        height: 48,
        child: vm.when(
          data: (monthList) => ListView(
            shrinkWrap: false,
            padding: EdgeInsets.only(left: 24),
            scrollDirection: Axis.horizontal,
            children: monthList
                .map(
                  (e) => Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                    child: InkWell(
                      onTap: () {
                        ref.read(monthProvider.state).state = e;
                      },
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 9, horizontal: 14),
                        decoration: BoxDecoration(
                          color: ref.watch(monthProvider.state).state == e
                              ? Color(0xff2196F3)
                              : Theme.of(context).dividerColor,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Text(
                          AppLocalization.of(context).getTranslatedVal(e),
                          style: Theme.of(context).textTheme.subtitle2.copyWith(
                                fontSize: 12,
                                color: ref.watch(monthProvider.state).state == e
                                    ? Colors.white
                                    : Color(0xff2196F3),
                              ),
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          loading: () => SizedBox(),
          error: (e, str) => Text(e.toString()),
        ),
      ),
    );
  }
}
