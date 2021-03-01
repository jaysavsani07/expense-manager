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
    return ProviderListener<AddCategoryViewModel>(
        provider: addCategoryModelProvider(category),
        onChange: (context, model) async {},
        child: Scaffold(
          appBar: AppBar(
            leading: Icon(Icons.close).onInkTap(() {
              Navigator.pop(context);
            }),
            actions: vm.category == null
                ? null
                : [
                    Icon(Icons.delete).p16().onInkTap(() {
                      vm.deleteCategory();
                      Navigator.pop(context);
                    })
                  ],
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                24.heightBox,
                Row(
                  children: [
                    Icon(
                      vm.iconData,
                      size: 36,
                      color: vm.color,
                    ).pSymmetric(h: 24),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        "Name".text.make(),
                        24.heightBox,
                        VxTextField(
                          value: vm.name,
                          keyboardType: TextInputType.text,
                          borderRadius: 7.5,
                          borderType: VxTextFieldBorderType.none,
                          fillColor: context.theme.cardTheme.color,
                          maxLine: 2,
                          textInputAction: TextInputAction.done,
                          maxLength: 20,
                          onChanged: (text) {
                            vm.changeName(text);
                          },
                        ),
                      ],
                    ).pOnly(right: 24).expand(),
                  ],
                ),
                24.heightBox,
                "Icon".text.make().pOnly(left: 24),
                24.heightBox,
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
                24.heightBox,
                "Color".text.make().pOnly(left: 24),
                24.heightBox,
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
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              vm.saveCategory();
              Navigator.pop(context);
            },
            backgroundColor: Vx.black,
            child: Icon(
              Icons.done,
              color: Vx.white,
            ),
          ),
        ));
  }
}
