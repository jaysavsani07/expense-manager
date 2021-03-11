import 'package:dotted_border/dotted_border.dart';
import 'package:expense_manager/core/constants.dart';
import 'package:expense_manager/data/language/app_localization.dart';
import 'package:expense_manager/data/models/category.dart';
import 'package:expense_manager/ui/addCategory/addCategory_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:velocity_x/velocity_x.dart';

class AddCategory extends ConsumerWidget {
  final Category category;

  AddCategory({@required this.category}) : super();

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final vm = watch(addCategoryModelProvider(category));
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back_ios_rounded).onInkTap(() {
          Navigator.pop(context);
        }),
        title: DottedBorder(
            color: Theme.of(context).appBarTheme.textTheme.headline6.color,
            dashPattern: [5, 5],
            radius: Radius.circular(12),
            borderType: BorderType.RRect,
            child: AppLocalization.of(context)
                .getTranslatedVal("new_category")
                .text
                .make()
                .pSymmetric(h: 8, v: 4)),
        actions: [
          AppLocalization.of(context)
              .getTranslatedVal("save")
              .text
              .size(16)
              .bold
              .color(Color(0xff2196F3))
              .make()
              .p20()
              .onInkTap(() {
            if (vm.name.isEmptyOrNull) {
              VxToast.show(context,
                  msg: AppLocalization.of(context)
                      .getTranslatedVal("pls_enter_category_name"),
                  bgColor: Colors.redAccent);
            } else if (vm.name.length < 3 || vm.name.length > 20) {
              VxToast.show(context,
                  msg: AppLocalization.of(context).getTranslatedVal(
                      "category_name_allowed_from_3_to_20_characters"),
                  bgColor: Colors.redAccent);
            } else {
              vm.saveCategory();
              Navigator.pop(context);
            }
          })
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          20.heightBox,
          Row(
            children: [
              Icon(
                vm.iconData,
                color: vm.color,
                size: 30,
              ).pSymmetric(h: 24),
              VxTextField(
                value: vm.name,
                keyboardType: TextInputType.text,
                borderRadius: 8,
                borderType: VxTextFieldBorderType.none,
                fillColor: context.theme.cardTheme.color,
                textInputAction: TextInputAction.done,
                height: 80,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                hint: AppLocalization.of(context).getTranslatedVal("tea"),
                clear: false,
                onChanged: (text) {
                  vm.changeName(text);
                },
              ).pOnly(right: 24).expand(),
            ],
          ).card.withRounded(value: 6).make(),
          30.heightBox,
          AppLocalization.of(context)
              .getTranslatedVal("icon")
              .text
              .bold
              .size(18)
              .start
              .make(),
          GridView(
            shrinkWrap: true,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            scrollDirection: Axis.horizontal,
            children: AppConstants.iconList
                .map((icon) => Icon(
                      icon,
                    ).onInkTap(() {
                      vm.changeIcon(icon);
                    }))
                .toList(),
          ).box.height(150).make(),
          30.heightBox,
          AppLocalization.of(context)
              .getTranslatedVal("color")
              .text
              .bold
              .size(18)
              .start
              .make(),
          GridView(
            shrinkWrap: true,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            scrollDirection: Axis.horizontal,
            children: AppConstants.iconColorList
                .map((color) => Icon(
                      Icons.circle,
                      size: 36,
                      color: color,
                    ).onInkTap(() {
                      vm.changeColor(color);
                    }))
                .toList(),
          ).box.height(170).make(),
          24.heightBox,
        ],
      ).scrollVertical().pSymmetric(h: 24),
    );
  }
}
