import 'package:expense_manager/core/routes.dart';
import 'package:expense_manager/ui/categoryList/category_list_state.dart';
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
            backgroundColor: Colors.grey.shade50,
            title: Text("Category list"),
            leading: Icon(Icons.close).onInkTap(() {
              Navigator.pop(context);
            }),
          ),
          body: ReorderableListView(
            onReorder: vm.reorder,
            children: vm.categoryList
                .map((e) => Padding(
                      key: ValueKey(e),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 4),
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25)),
                              color: e.iconColor,
                            ),
                            height: 36,
                            width: 36,
                            child: Icon(
                              e.icon,
                              size: 20,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 8, right: 8, bottom: 4, top: 4),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    e.name,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Icon(
                                    Icons.reorder_outlined,
                                    size: 20,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ).onInkTap(() {
                        Navigator.pushNamed(context, AppRoutes.addCategory,
                            arguments: e);
                      }),
                    ))
                .toList(),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.addCategory,
                  arguments: null);
            },
            child: Icon(Icons.add),
          ),
        ));
  }
}
