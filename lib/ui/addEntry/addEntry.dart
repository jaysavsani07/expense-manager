import 'package:dotted_border/dotted_border.dart';
import 'package:expense_manager/core/routes.dart';
import 'package:expense_manager/data/language/app_localization.dart';
import 'package:expense_manager/data/models/category.dart';
import 'package:expense_manager/data/models/entry_with_category.dart';
import 'package:expense_manager/ui/addEntry/addEntry_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:intl/intl.dart';
import 'package:tuple/tuple.dart';
import 'package:velocity_x/velocity_x.dart';

class AddEntry extends ConsumerWidget {
  final Tuple2<EntryWithCategory, Category> entryWithCategory;

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
            color: Theme.of(context).appBarTheme.textTheme.headline6.color,
            dashPattern: [5, 5],
            radius: Radius.circular(12),
            borderType: BorderType.RRect,
            child: AppLocalization.of(context)
                .getTranslatedVal("add_expense")
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
            if (vm.amount.isEmptyOrNull) {
              VxToast.show(context,
                  msg: AppLocalization.of(context)
                      .getTranslatedVal("pls_enter_amount"),
                  bgColor: Colors.redAccent);
            } else if (double.parse(vm.amount) == 0.0) {
              VxToast.show(context,
                  msg: AppLocalization.of(context)
                      .getTranslatedVal("amount_should_grater_then_zero"),
                  bgColor: Colors.redAccent);
            } else {
              vm.addEntry();
              Navigator.pop(context);
            }
          })
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          20.heightBox,
          VxTextField(
            value: vm.amount == "0" ? null : vm.amount,
            keyboardType: TextInputType.number,
            borderType: VxTextFieldBorderType.none,
            fillColor: context.theme.cardTheme.color,
            textInputAction: TextInputAction.done,
            onChanged: (text) {
              vm.amountChange(text);
            },
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
            height: 80,
            hint: "${NumberFormat.simpleCurrency().currencySymbol} 00.00",
            textAlign: TextAlign.center,
            clear: false,
          ).card.withRounded(value: 6).make(),
          30.heightBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppLocalization.of(context)
                  .getTranslatedVal("category")
                  .text
                  .size(18)
                  .bold
                  .make(),
              AppLocalization.of(context)
                  .getTranslatedVal("edit")
                  .text
                  .size(16)
                  .bold
                  .color(Color(0xff2196F3))
                  .start
                  .make()
                  .onInkTap(() {
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
                          4.heightBox,
                          category.name.text
                              .textStyle(Theme.of(context).textTheme.caption)
                              .ellipsis
                              .make()
                              .p4()
                        ],
                      )
                          .centered()
                          .card
                          .shape(RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6)),
                              side: vm.category == category?BorderSide(
                                  width: 1, color: category.iconColor):BorderSide.none))
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
              AppLocalization.of(context)
                  .getTranslatedVal("date")
                  .text
                  .size(18)
                  .bold
                  .make(),
              8.heightBox,
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DateFormat('dd/MM/yy')
                      .format(vm.date)
                      .text
                      .size(14)
                      .make()
                      .p8(),
                  Icon(Icons.arrow_drop_down)
                ],
              )
                  .box
                  .border(color: Theme.of(context).dividerColor)
                  .withRounded(value: 6)
                  .make()
                  .onInkTap(() {
                _selectDate(context, vm);
              })
            ]).expand(),
            8.widthBox,
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              AppLocalization.of(context)
                  .getTranslatedVal("time")
                  .text
                  .size(18)
                  .bold
                  .make(),
              8.heightBox,
              Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                    DateFormat('HH:mm')
                        .format(vm.date)
                        .text
                        .size(14)
                        .make()
                        .p8(),
                    Icon(Icons.arrow_drop_down)
                  ])
                  .box
                  .border(color: Theme.of(context).dividerColor)
                  .withRounded(value: 6)
                  .make()
                  .onInkTap(() {
                _selectTime(context, vm);
              })
            ]).expand(),
          ]),
          30.heightBox,
          AppLocalization.of(context)
              .getTranslatedVal("note")
              .text
              .size(18)
              .bold
              .start
              .make(),
          8.heightBox,
          VxTextField(
            value: vm.description,
            keyboardType: TextInputType.text,
            borderRadius: 6,
            hint:
                AppLocalization.of(context).getTranslatedVal("enter_note_here"),
            borderType: VxTextFieldBorderType.roundLine,
            borderColor: Theme.of(context).dividerColor,
            fillColor: context.theme.backgroundColor,
            maxLine: 2,
            textInputAction: TextInputAction.done,
            maxLength: 100,
            onChanged: (text) {
              vm.changeDescription(text);
            },
          ),
        ],
      ).scrollVertical().pSymmetric(h: 24),
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
