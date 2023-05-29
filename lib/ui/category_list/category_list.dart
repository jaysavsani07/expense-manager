import 'package:dotted_border/dotted_border.dart';
import 'package:expense_manager/core/constants.dart';
import 'package:expense_manager/core/routes.dart';
import 'package:expense_manager/core/app_localization.dart';
import 'package:expense_manager/ui/category_list/category_list_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tuple/tuple.dart';

class CategoryList extends ConsumerWidget {
  final EntryType entryType;

  CategoryList({required this.entryType}) : super();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(categoryListModelProvider(entryType));
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios_rounded)),
        title: DottedBorder(
          color: Theme.of(context).appBarTheme.titleTextStyle!.color!,
          dashPattern: [5, 5],
          radius: Radius.circular(12),
          borderType: BorderType.RRect,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Text(
              AppLocalization.of(context).getTranslatedVal("category_list"),
              style: Theme.of(context).appBarTheme.titleTextStyle,
            ),
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              Navigator.pushNamed(
                context,
                AppRoutes.addCategory,
                arguments: Tuple2(vm.entryType, null),
              );
            },
            borderRadius: BorderRadius.circular(20),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                AppLocalization.of(context).getTranslatedVal("add_new"),
                style: Theme.of(context).textTheme.subtitle2!.copyWith(
                    fontWeight: FontWeight.bold, color: Color(0xff2196F3)),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      vm.entryTypeChange(EntryType.expense);
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                        side: vm.entryType == EntryType.expense
                            ? BorderSide(
                                width: 1,
                                color: Color(0xff2196F3),
                              )
                            : BorderSide.none,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Text(
                          AppLocalization.of(context)
                              .getTranslatedVal("expense"),
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      vm.entryTypeChange(EntryType.income);
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                        side: vm.entryType == EntryType.income
                            ? BorderSide(
                                width: 1,
                                color: Color(0xff2196F3),
                              )
                            : BorderSide.none,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Text(
                          AppLocalization.of(context)
                              .getTranslatedVal("income"),
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: /*Reorderable*/ ListView(
            // onReorder: vm.reorder,
            padding: const EdgeInsets.only(top: 16),
            children: (vm.entryType == EntryType.expense
                    ? vm.expenseCategoryList
                    : vm.incomeCategoryList)
                .map((e) => InkWell(
                      key: ValueKey(e.id),
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.addCategory,
                          arguments: Tuple2(vm.entryType, e),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 14),
                        child: Row(
                          children: [
                            Icon(
                              e.icon,
                              size: 20,
                              color: e.iconColor,
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Text(
                                      e.name,
                                      style:
                                          Theme.of(context).textTheme.subtitle2,
                                    ),
                                  ),
                                  /*Icon(
                                    Icons.drag_handle_outlined,
                                    size: 20,
                                  )*/
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ))
                .toList(),
          ))
        ],
      ),
    );
  }
}
