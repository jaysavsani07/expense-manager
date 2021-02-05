import 'package:expense_manager/core/constants.dart';
import 'package:expense_manager/ui/addEntry/addEntry_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:velocity_x/velocity_x.dart';

class AddEntry extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final vm = watch(addEntryModelProvider);
    return ProviderListener<AddEntryViewModel>(
        provider: addEntryModelProvider,
        onChange: (context, model) async {},
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.grey.shade50,
            leading: Icon(Icons.close).onInkTap(() {
              Navigator.pop(context);
            }),
          ),
          body: Column(
            children: [
              vm.amount.text.xl4.bold
                  .make()
                  .centered()
                  .box
                  .p8
                  .white
                  .roundedSM
                  .make()
                  .onInkTap(() {
                    vm.showNumPad();
                  })
                  .p4()
                  .h(context.safePercentHeight * 14),
              16.heightBox,
              vm.isShowNumPad
                  ? AppConstants.keyboard
                      .map((e) => Flexible(
                            flex: 1,
                            child: e
                                .map((e) => Flexible(
                                    flex: 1,
                                    child: e.text.xl2
                                        .make()
                                        .centered()
                                        .box
                                        .height(100)
                                        .width(100)
                                        .make()
                                        .onInkTap(() {
                                      vm.textChange(e);
                                    })))
                                .toList()
                                .row(
                                    axisSize: MainAxisSize.max,
                                    alignment: MainAxisAlignment.spaceBetween),
                          ))
                      .toList()
                      .column(alignment: MainAxisAlignment.end)
                      .h(context.safePercentHeight * 68)
                  : [
                      "Category".text.gray600.start.make(),
                      8.heightBox,
                      GridView(
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                        scrollDirection: Axis.horizontal,
                        children: vm.categoryList
                            .map((category) => [
                                  10.heightBox,
                                  Icon(
                                    category.icon,
                                    color: vm.category == category
                                        ? Vx.black
                                        : category.iconColor,
                                  ),
                                  category.name.text.center
                                      .make()
                                      .pSymmetric(v: 10, h: 4),
                                ]
                                    .column()
                                    .centered()
                                    .box
                                    .width(110)
                                    .height(110)
                                    .color(vm.category == category
                                        ? category.iconColor.withOpacity(0.5)
                                        : Vx.gray300)
                                    .roundedSM
                                    .make()
                                    .onInkTap(() {
                                  vm.categoryChange(category);
                                }).p4())
                            .toList(),
                      ).box.height(235).make(),
                      16.heightBox,
                      [
                        [
                          "Date".text.gray600.start.make(),
                          8.heightBox,
                          [
                            "26.03.19".text.xl.gray600.bold.make().expand(),
                            Icon(Icons.arrow_drop_down)
                          ]
                              .row(
                                  axisSize: MainAxisSize.max,
                                  alignment: MainAxisAlignment.spaceBetween)
                              .box
                              .p8
                              .white
                              .roundedSM
                              .make()
                        ]
                            .column(crossAlignment: CrossAxisAlignment.start)
                            .expand(),
                        8.widthBox,
                        [
                          "Time".text.gray600.start.make(),
                          8.heightBox,
                          [
                            "12:25".text.xl.gray600.bold.make().expand(),
                            Icon(Icons.arrow_drop_down)
                          ]
                              .row(
                                  axisSize: MainAxisSize.max,
                                  alignment: MainAxisAlignment.spaceBetween)
                              .box
                              .p8
                              .white
                              .roundedSM
                              .make()
                        ]
                            .column(crossAlignment: CrossAxisAlignment.start)
                            .expand(),
                      ].row(axisSize: MainAxisSize.max),
                      16.heightBox,
                      "Add a Note".text.gray600.make(),
                      8.heightBox,
                      VxTextField(
                        keyboardType: TextInputType.text,
                        borderRadius: 7.5,
                        borderType: VxTextFieldBorderType.none,
                        fillColor: Vx.white,
                        maxLine: 2,
                        maxLength: 100,
                      )
                    ]
                      .column(crossAlignment: CrossAxisAlignment.start)
                      .pSymmetric(h: 8)
                      .h(context.safePercentHeight * 68),
              16.heightBox,
              "Save"
                  .text
                  .xl
                  .white
                  .make()
                  .centered()
                  .box
                  .purple500
                  .width(double.infinity)
                  .height(56)
                  .make()
                  .onInkTap(() {
                if (vm.isShowNumPad) {
                  vm.hideNumPad();
                } else {
                  vm.addEntry();
                  Navigator.pop(context);
                }
              }).h(context.safePercentHeight * 8),
            ],
          ).box.make().scrollVertical(),
        ));
  }
}
