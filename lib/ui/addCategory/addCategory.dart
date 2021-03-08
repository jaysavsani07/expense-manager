import 'package:dotted_border/dotted_border.dart';
import 'package:expense_manager/core/constants.dart';
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
            color: Colors.blue,
            dashPattern: [5, 5],
            radius: Radius.circular(12),
            borderType: BorderType.RRect,
            child: "New Category"
                .text
                .size(16)
                .medium
                .color(Colors.blue)
                .make()
                .pSymmetric(h: 8, v: 4)),
        actions: [
          "Save"
              .text
              .size(16)
              .bold
              .color(Colors.blue)
              .make()
              .p20()
              .onInkTap(() {
            if (vm.name.isEmptyOrNull) {
              VxToast.show(context,
                  msg: "Pls enter category name", bgColor: Colors.redAccent);
            } else if (vm.name.length < 3 || vm.name.length > 20) {
              VxToast.show(context,
                  msg: "Category name allowed from 3 to 20 characters",
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
                hint: "Tea",
                clear: false,
                onChanged: (text) {
                  vm.changeName(text);
                },
              ).pOnly(right: 24).expand(),
            ],
          ).card.withRounded(value: 6).make(),
          30.heightBox,
          "Icon".text.bold.size(18).start.make(),
          GridView(
            shrinkWrap: true,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            scrollDirection: Axis.horizontal,
            children: AppConstants.iconList
                .map((icon) => Icon(
                      icon,
                      color: Vx.black,
                    ).onInkTap(() {
                      vm.changeIcon(icon);
                    }))
                .toList(),
          ).box.height(150).make(),
          30.heightBox,
          "Color".text.bold.size(18).start.make(),
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
