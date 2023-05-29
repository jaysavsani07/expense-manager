import 'package:expense_manager/core/routes.dart';
import 'package:expense_manager/data/models/category.dart';
import 'package:expense_manager/ui/dashboard/dashboard_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tuple/tuple.dart';

final _currentCategory =
    Provider<Category>((ref) => throw UnimplementedError());

class CategoryListView extends ConsumerWidget {
  const CategoryListView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GridView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      shrinkWrap: true,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
      physics: NeverScrollableScrollPhysics(),
      children: [
        ...ref
            .watch(categoryListProvider)
            .list
            .map((category) => ProviderScope(
                overrides: [_currentCategory.overrideWithValue(category)],
                child: const CategoryItem()))
            .toList()
      ],
    );
  }
}

class CategoryItem extends ConsumerWidget {
  const CategoryItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final category = ref.watch(_currentCategory);
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.addEntry,
            arguments: Tuple3(category.entryType, null, category));
      },
      borderRadius: BorderRadius.circular(6),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              category.icon,
              color: category.iconColor,
              size: 20,
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 4, right: 4, bottom: 4, top: 8),
              child: Text(
                category.name,
                style: Theme.of(context)
                    .textTheme
                    .caption!
                    .copyWith(overflow: TextOverflow.ellipsis),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
