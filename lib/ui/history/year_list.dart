import 'package:expense_manager/ui/history/history_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class YearList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(yearListProvider);

    return SizedBox(
      height: 48,
      child: vm.when(
        data: (yearList) => ListView(
          shrinkWrap: false,
          padding: EdgeInsets.only(left: 24),
          scrollDirection: Axis.horizontal,
          children: yearList
              .map(
                (e) => Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                  child: InkWell(
                    onTap: () {
                      ref.read(yearProvider.state).state = e;
                    },
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 9, horizontal: 14),
                      decoration: BoxDecoration(
                        color: ref.watch(yearProvider.state).state == e
                            ? Color(0xff2196F3)
                            : Theme.of(context).dividerColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        e.toString(),
                        style: Theme.of(context).textTheme.subtitle2.copyWith(
                              fontSize: 12,
                              color: ref.watch(yearProvider.state).state == e
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
        loading: () => CircularProgressIndicator(),
        error: (e, str) => Center(child: Text(e.toString())),
      ),
    );
  }
}
