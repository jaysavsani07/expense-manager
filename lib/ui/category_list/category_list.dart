import 'package:dotted_border/dotted_border.dart';
import 'package:expense_manager/core/routes.dart';
import 'package:expense_manager/data/language/app_localization.dart';
import 'package:expense_manager/ui/category_list/category_list_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:velocity_x/velocity_x.dart';

class CategoryList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final vm = watch(categoryListModelProvider);
    return ProviderListener<CategoryListViewModel>(
        provider: categoryListModelProvider,
        onChange: (context, model) async {},
        child: Scaffold(
          appBar: AppBar(
            leading: Icon(Icons.arrow_back_ios_rounded).onInkTap(() {
              Navigator.pop(context);
            }),
            title: DottedBorder(
                color: Colors.blue,
                dashPattern: [5, 5],
                radius: Radius.circular(12),
                borderType: BorderType.RRect,
                child: AppLocalization.of(context)
                    .getTranslatedVal("category_list")
                    .text
                    .size(16)
                    .medium
                    .color(Colors.blue)
                    .make()
                    .pSymmetric(h: 8, v: 4)),
            actions: [
              AppLocalization.of(context)
                  .getTranslatedVal("add_new")
                  .text
                  .size(16)
                  .bold
                  .color(Colors.blue)
                  .make()
                  .p20()
                  .onInkTap(() {
                Navigator.pushNamed(context, AppRoutes.addCategory,
                    arguments: null);
              })
            ],
          ),
          body: ReorderableListView(
            onReorder: vm.reorder,
            children: vm.categoryList
                .map((e) => InkWell(
                      key: ValueKey(e.id),
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.addCategory,
                            arguments: e);
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
                                  e.name.text.make().pSymmetric(h: 16),
                                  Icon(
                                    Icons.drag_handle_outlined,
                                    size: 20,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ))
                .toList(),
          ).pOnly(top: 20),
        ));
  }
}
