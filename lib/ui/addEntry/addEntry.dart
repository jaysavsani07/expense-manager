import 'package:dotted_border/dotted_border.dart';
import 'package:expense_manager/core/routes.dart';
import 'package:expense_manager/data/models/category.dart';
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
            child: "Add Expense"
                .text
                .lg
                .bold
                .color(Colors.blue)
                .make()
                .pSymmetric(h: 8, v: 4)),
        actions: [
          "Save".text.lg.bold.color(Colors.blue).make().p20().onInkTap(() {
            vm.addEntry();
            Navigator.pop(context);
          })
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          VxTextField(
            value: vm.description,
            keyboardType: TextInputType.number,
            borderRadius: 8,
            borderType: VxTextFieldBorderType.none,
            fillColor: context.theme.cardTheme.color,
            textInputAction: TextInputAction.done,
            onChanged: (text) {
              vm.amountChange(text);
            },
            height: 80,
            hint: "${NumberFormat.simpleCurrency().currencySymbol} 00.00",
            textAlign: TextAlign.center,
            clear: false,
          ).card.roundedSM.make(),
          30.heightBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              "Category".text.bold.base.start.make(),
              "Edit".text.bold.sm.color(Colors.blue).start.make().onInkTap(() {
                Navigator.pushNamed(
                  context,
                  AppRoutes.categoryList,
                );
              })
            ],
          ),
          20.heightBox,
          GridView(
            shrinkWrap: true,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            scrollDirection: Axis.horizontal,
            children: [
              ...vm.categoryList
                  .map((category) => Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            category.icon,
                            color: category.iconColor,
                            size: 20,
                          ),
                          category.name.text.sm.ellipsis.make().p4()
                        ],
                      )
                          .centered()
                          .card
                          .shape(RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7.5)),
                              side: BorderSide(
                                  width: 1,
                                  color: vm.category == category
                                      ? category.iconColor
                                      : Colors.white)))
                          .make()
                          .onInkTap(() {
                        vm.categoryChange(category);
                      }))
                  .toList()
            ],
          ).h(180),
          30.heightBox,
          Row(children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              "Date".text.bold.base.start.make(),
              8.heightBox,
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DateFormat('dd.MM.yy').format(vm.date).text.base.make().p8(),
                  Icon(Icons.arrow_drop_down)
                ],
              ).box.border().roundedSM.make().onInkTap(() {
                _selectDate(context, vm);
              })
            ]).expand(),
            8.widthBox,
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              "Time".text.bold.base.start.make(),
              8.heightBox,
              Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DateFormat('HH:mm').format(vm.date).text.base.make().p8(),
                    Icon(Icons.arrow_drop_down)
                  ]).box.border().roundedSM.make().onInkTap(() {
                _selectTime(context, vm);
              })
            ]).expand(),
          ]),
          30.heightBox,
          "Note".text.bold.base.start.make(),
          8.heightBox,
          VxTextField(
            value: vm.description,
            keyboardType: TextInputType.text,
            borderRadius: 7.5,
            hint: "Enter note here",
            borderType: VxTextFieldBorderType.roundLine,
            borderColor: Colors.black,
            fillColor: context.theme.cardTheme.color,
            maxLine: 2,
            textInputAction: TextInputAction.done,
            maxLength: 100,
            onSubmitted: (text) {
              vm.changeDescription(text);
            },
          ),
        ],
      ).box.make().scrollVertical().pSymmetric(h: 24),
    );
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

// Expanded(child: Column(
// mainAxisAlignment: MainAxisAlignment.end,
// children: AppConstants.keyboard
//     .map((e) => Flexible(
// flex: 1,
// child: Row(
// mainAxisSize: MainAxisSize.max,
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: e
//     .map((e) => Flexible(
// flex: 1,
// child: e.text.xl3
//     .color(Colors.blue)
// .make()
//     .objectCenter()
//     .box
//     .height(100)
// .width(context.screenWidth / 3)
// .make()
//     .onInkTap(() {
// vm.textChange(e);
// })))
// .toList(),
// ),
// ))
// .toList(),
// )),
