import 'package:dotted_border/dotted_border.dart';
import 'package:expense_manager/core/constants.dart';
import 'package:expense_manager/core/app_localization.dart';
import 'package:expense_manager/data/models/category.dart';
import 'package:expense_manager/ui/addCategory/addCategory_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tuple/tuple.dart';

class AddCategory extends ConsumerWidget {
  final Tuple2<EntryType, Category> tuple2;

  AddCategory({required this.tuple2}) : super();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(addCategoryModelProvider(tuple2));
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios_rounded),
        ),
        title: DottedBorder(
          color: Theme.of(context).appBarTheme.titleTextStyle!.color!,
          dashPattern: [5, 5],
          radius: Radius.circular(12),
          borderType: BorderType.RRect,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Text(
              AppLocalization.of(context).getTranslatedVal("new_category"),
              style: Theme.of(context).appBarTheme.titleTextStyle,
            ),
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              FocusScope.of(context).unfocus();
              if (vm.name.trim().isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      AppLocalization.of(context)
                          .getTranslatedVal("pls_enter_category_name"),
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    backgroundColor: Colors.redAccent,
                  ),
                );
              } else if (vm.name.trim().length < 3 ||
                  vm.name.trim().length > 20) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      AppLocalization.of(context).getTranslatedVal(
                          "category_name_allowed_from_3_to_20_characters"),
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    backgroundColor: Colors.redAccent,
                  ),
                );
              } else {
                vm.addUpdateCategory();
                Navigator.pop(context);
              }
            },
            borderRadius: BorderRadius.circular(20),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                AppLocalization.of(context).getTranslatedVal("save"),
                style: Theme.of(context).textTheme.subtitle2!.copyWith(
                    fontWeight: FontWeight.bold, color: Color(0xff2196F3)),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6)),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Icon(
                        vm.iconData,
                        color: vm.color,
                        size: 30,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 24),
                        child: TextFormField(
                          initialValue: vm.name,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          onChanged: (text) {
                            vm.changeName(text);
                          },
                          onFieldSubmitted: (text) {
                            FocusScope.of(context).unfocus();
                          },
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w700),
                          decoration: InputDecoration(
                            fillColor: Theme.of(context).cardTheme.color,
                            filled: true,
                            hintText: AppLocalization.of(context)
                                .getTranslatedVal("tea"),
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                              left: 8,
                              right: 8,
                              top: 30,
                              bottom: 30,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                AppLocalization.of(context).getTranslatedVal("icon"),
                style: Theme.of(context)
                    .textTheme
                    .subtitle2!
                    .copyWith(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 150,
              child: GridView(
                shrinkWrap: true,
                padding: EdgeInsets.only(left: 24),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                scrollDirection: Axis.horizontal,
                children: (vm.entryType == EntryType.expense
                        ? AppConstants.expenseIconList
                        : AppConstants.incomeIconList)
                    .map((icon) => InkWell(
                          onTap: () {
                            vm.changeIcon(icon);
                          },
                          child: Icon(
                            icon,
                          ),
                        ))
                    .toList(),
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                AppLocalization.of(context).getTranslatedVal("color"),
                style: Theme.of(context)
                    .textTheme
                    .subtitle2!
                    .copyWith(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 170,
              child: GridView(
                shrinkWrap: true,
                padding: EdgeInsets.only(left: 24),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                scrollDirection: Axis.horizontal,
                children: (vm.entryType == EntryType.expense
                        ? AppConstants.expenseIconColorList
                        : AppConstants.incomeIconColorList)
                    .map((color) => InkWell(
                          onTap: () {
                            vm.changeColor(color);
                          },
                          child: Icon(
                            Icons.circle,
                            size: 36,
                            color: color,
                          ),
                        ))
                    .toList(),
              ),
            ),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
