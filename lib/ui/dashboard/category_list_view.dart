import 'package:expense_manager/core/routes.dart';
import 'package:expense_manager/data/models/category_with_entry_list.dart';
import 'package:expense_manager/ui/dashboard/dashboard_state.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:velocity_x/velocity_x.dart';

final _currentCategory = ScopedProvider<CategoryWithEntryList>(null);

class CategoryListView extends ConsumerWidget {
  const CategoryListView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return GridView(
      shrinkWrap: true,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
      physics: NeverScrollableScrollPhysics(),
      children: [
        ...watch(categoryListProvider)
            .list
            .map((category) => ProviderScope(
                overrides: [_currentCategory.overrideWithValue(category)],
                child: const CategoryItem()))
            .toList()
      ],
    ).pSymmetric(h: 24);
  }
}

class CategoryItem extends ConsumerWidget {
  const CategoryItem({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final category = watch(_currentCategory);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          category.category.icon,
          color: category.category.iconColor,
          size: 20,
        ),
        category.category.name.text.sm.ellipsis.make().p4()
      ],
    )
        .onInkTap(() {
          Navigator.pushNamed(context, AppRoutes.addEntry, arguments: null);
        })
        .centered()
        .card
        .roundedSM
        .make();
  }
}