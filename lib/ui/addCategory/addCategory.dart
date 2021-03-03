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
                .lg
                .bold
                .color(Colors.blue)
                .make()
                .pSymmetric(h: 8, v: 4)),
        actions: [
          "Save".text.lg.bold.color(Colors.blue).make().p20().onInkTap(() {
            vm.saveCategory();
            Navigator.pop(context);
          })
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                hint: "Tea",
                onChanged: (text) {
                  vm.changeName(text);
                },
              ).pOnly(right: 24).expand(),
            ],
          ).card.roundedSM.make(),
          30.heightBox,
          "Icon".text.bold.base.start.make(),
          GridView(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3),
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
          "Color".text.bold.base.start.make(),
          GridView(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3),
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
