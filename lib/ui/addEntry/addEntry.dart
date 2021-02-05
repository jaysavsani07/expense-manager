import 'package:expense_manager/core/constants.dart';
import 'package:expense_manager/ui/addEntry/addEntry_state.dart';
import 'package:flutter/material.dart';
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
            title: Text("Dashboard"),
          ),
          body: Column(
            children: [
              [
                vm.amount.text.xl4.bold.make().p4(),
                AppConstants.keyboard
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
                    .column()
                    .expand(),
              ].column().expand(),
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
                vm.addEntry();
              }),
            ],
          ),
        ));
  }
}
