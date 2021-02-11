import 'package:expense_manager/core/constants.dart';
import 'package:expense_manager/core/routes.dart';
import 'package:expense_manager/data/models/entry.dart';
import 'package:expense_manager/data/models/entry_with_category.dart';
import 'package:expense_manager/ui/addEntry/addEntry_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:intl/intl.dart';
import 'package:velocity_x/velocity_x.dart';

class AddEntry extends ConsumerWidget {
  final EntryWithCategory entryWithCategory;

  AddEntry({@required this.entryWithCategory}) : super();

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final vm = watch(addEntryModelProvider(entryWithCategory));
    return ProviderListener<AddEntryViewModel>(
        provider: addEntryModelProvider(entryWithCategory),
        onChange: (context, model) async {},
        child: Scaffold(
          appBar: AppBar(
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
                  .color(Theme.of(context).cursorColor)
                  .roundedSM
                  .make()
                  .onInkTap(() {
                    vm.showNumPad();
                  })
                  .p4()
                  .h(context.safePercentHeight * 14),
              16.heightBox,
              vm.isShowNumPad
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: AppConstants.keyboard
                          .map((e) => Flexible(
                                flex: 1,
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: e
                                      .map((e) => Flexible(
                                          flex: 1,
                                          child: e.text.xl3.color(Colors.blue)
                                              .make()
                                              .objectCenter()
                                              .box
                                              .height(100)
                                              .width(context.screenWidth / 3)
                                              .make()
                                              .onInkTap(() {
                                            vm.textChange(e);
                                          })))
                                      .toList(),
                                ),
                              ))
                          .toList(),
                    ).h(context.safePercentHeight * 68)
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              "Category".text.gray600.start.make(),
                              Icon(Icons.more_vert_rounded).onInkTap(() {
                                Navigator.pushNamed(
                                  context,
                                  AppRoutes.categoryList,
                                );
                              })
                            ],
                          ),
                          8.heightBox,
                          GridView(
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
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
                                            ? category.iconColor
                                                .withOpacity(0.5)
                                            : Vx.gray300)
                                        .roundedSM
                                        .make()
                                        .onInkTap(() {
                                      vm.categoryChange(category);
                                    }).p4())
                                .toList(),
                          ).box.height(235).make(),
                          16.heightBox,
                          Row(children: [
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  "Date".text.gray600.start.make(),
                                  8.heightBox,
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      DateFormat('dd.MM.yy')
                                          .format(vm.date)
                                          .text
                                          .xl
                                          .gray600
                                          .bold
                                          .make()
                                          .expand(),
                                      Icon(Icons.arrow_drop_down)
                                    ],
                                  ).box.p8.white.roundedSM.make().onInkTap(() {
                                    _selectDate(context, vm);
                                  })
                                ]).expand(),
                            8.widthBox,
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  "Time".text.gray600.start.make(),
                                  8.heightBox,
                                  Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                        DateFormat('HH:mm')
                                            .format(vm.date)
                                            .text
                                            .xl
                                            .gray600
                                            .bold
                                            .make()
                                            .expand(),
                                        Icon(Icons.arrow_drop_down)
                                      ])
                                      .box
                                      .p8
                                      .white
                                      .roundedSM
                                      .make()
                                      .onInkTap(() {
                                    _selectTime(context, vm);
                                  })
                                ]).expand(),
                          ]),
                          16.heightBox,
                          "Add a Note".text.gray600.make(),
                          8.heightBox,
                          VxTextField(
                            value: vm.description,
                            keyboardType: TextInputType.text,
                            borderRadius: 7.5,
                            borderType: VxTextFieldBorderType.none,
                            fillColor: Vx.white,
                            maxLine: 2,
                            textInputAction: TextInputAction.done,
                            maxLength: 100,
                            onSubmitted: (text) {
                              vm.changeDescription(text);
                            },
                          )
                        ]).pSymmetric(h: 8).h(context.safePercentHeight * 68),
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

  _selectDate(BuildContext context, AddEntryViewModel vm) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: vm.date, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != vm.date) {
      vm.changeDate(picked);
    }
  }

  _selectTime(BuildContext context, AddEntryViewModel vm) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(vm.date), // Refer step 1
    );
    if (picked != null && picked != TimeOfDay.fromDateTime(vm.date)) {
      vm.changeTime(picked);
    }
  }
}
