import 'package:dotted_border/dotted_border.dart';
import 'package:expense_manager/core/constants.dart';
import 'package:expense_manager/core/currency_text_input_formatter.dart';
import 'package:expense_manager/core/routes.dart';
import 'package:expense_manager/core/app_localization.dart';
import 'package:expense_manager/data/models/category.dart';
import 'package:expense_manager/data/models/entry_with_category.dart';
import 'package:expense_manager/ui/addEntry/addEntry_state.dart';
import 'package:expense_manager/ui/app/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:tuple/tuple.dart';

class AddEntry extends ConsumerWidget {
  final Tuple3<EntryType, EntryWithCategory, Category> entryWithCategory;

  AddEntry({@required this.entryWithCategory}) : super();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(addEntryModelProvider(entryWithCategory));
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios_rounded)),
        title: DottedBorder(
          color: Theme.of(context).appBarTheme.titleTextStyle.color,
          dashPattern: [5, 5],
          radius: Radius.circular(12),
          borderType: BorderType.RRect,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Text(vm.entryType == EntryType.expense
                ? AppLocalization.of(context).getTranslatedVal("add_expense")
                : AppLocalization.of(context).getTranslatedVal("add_income"),
              style: Theme.of(context).appBarTheme.titleTextStyle,),
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              FocusScope.of(context).unfocus();
              if (vm.amount.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      AppLocalization.of(context)
                          .getTranslatedVal("pls_enter_amount"),
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    backgroundColor: Colors.redAccent,
                  ),
                );
              } else if (double.parse(vm.amount) <= 0.0) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      AppLocalization.of(context)
                          .getTranslatedVal("amount_should_grater_then_zero"),
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    backgroundColor: Colors.redAccent,
                  ),
                );
              } else {
                vm.addUpdateEntry();
                Navigator.pop(context);
              }
            },
            borderRadius: BorderRadius.circular(20),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                AppLocalization.of(context).getTranslatedVal("save"),
                style: Theme.of(context).textTheme.subtitle2.copyWith(
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
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 28),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: TextFormField(
                  initialValue: vm.amount == "0" ? null : vm.amount,
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.done,
                  inputFormatters: [
                    CurrencyTextInputFormatter(),
                  ],
                  onChanged: (text) {
                    vm.amountChange(text);
                  },
                  onFieldSubmitted: (text) {
                    FocusScope.of(context).unfocus();
                  },
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    fillColor: Theme.of(context).cardTheme.color,
                    filled: true,
                    hintText:
                        "${NumberFormat.simpleCurrency(locale: ref.read(appStateNotifier).currency.item1).currencySymbol} 00.00",
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
            SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                AppLocalization.of(context).getTranslatedVal("type"),
                style: Theme.of(context)
                    .textTheme
                    .subtitle2
                    .copyWith(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        vm.entryTypeChange(EntryType.expense);
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                          side: vm.entryType == EntryType.expense
                              ? BorderSide(
                                  width: 1,
                                  color: Color(0xff2196F3),
                                )
                              : BorderSide.none,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Text(
                            AppLocalization.of(context)
                                .getTranslatedVal("expense"),
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        vm.entryTypeChange(EntryType.income);
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                          side: vm.entryType == EntryType.income
                              ? BorderSide(
                                  width: 1,
                                  color: Color(0xff2196F3),
                                )
                              : BorderSide.none,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Text(
                            AppLocalization.of(context)
                                .getTranslatedVal("income"),
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalization.of(context).getTranslatedVal("category"),
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2
                        .copyWith(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.categoryList,
                        arguments: vm.entryType,
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      child: Text(
                        AppLocalization.of(context).getTranslatedVal("edit"),
                        style: Theme.of(context).textTheme.subtitle2.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff2196F3)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 180,
              child: GridView(
                padding: EdgeInsets.only(left: 24),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                scrollDirection: Axis.horizontal,
                children: [
                  ...(vm.entryType == EntryType.expense
                          ? vm.expenseCategoryList
                          : vm.incomeCategoryList)
                      .map((category) => InkWell(
                            onTap: () {
                              vm.categoryChange(category);
                            },
                            borderRadius: BorderRadius.circular(6),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                                side: vm.category == category
                                    ? BorderSide(
                                        width: 1, color: category.iconColor)
                                    : BorderSide.none,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    category.icon,
                                    color: category.iconColor,
                                    size: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 4, right: 4, bottom: 4, top: 8),
                                    child: Text(
                                      category.name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption
                                          .copyWith(
                                              overflow: TextOverflow.ellipsis),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ))
                      .toList()
                ],
              ),
            ),
            SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalization.of(context).getTranslatedVal("date"),
                          style: Theme.of(context).textTheme.subtitle2.copyWith(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        InkWell(
                          onTap: () {
                            _selectDate(context, vm);
                          },
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Theme.of(context).dividerColor,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6)),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Text(
                                    DateFormat('dd/MM/yy').format(vm.date),
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
                                  ),
                                ),
                                Icon(Icons.arrow_drop_down)
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalization.of(context)
                                .getTranslatedVal("time"),
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2
                                .copyWith(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8),
                          InkWell(
                            onTap: () {
                              _selectTime(context, vm);
                            },
                            borderRadius: BorderRadius.all(Radius.circular(6)),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Theme.of(context).dividerColor,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6)),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Text(
                                      DateFormat('HH:mm').format(vm.date),
                                      style:
                                          Theme.of(context).textTheme.bodyText2,
                                    ),
                                  ),
                                  Icon(Icons.arrow_drop_down)
                                ],
                              ),
                            ),
                          )
                        ]),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.only(left: 24),
              child: Text(
                AppLocalization.of(context).getTranslatedVal("note"),
                style: Theme.of(context)
                    .textTheme
                    .subtitle2
                    .copyWith(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: TextFormField(
                initialValue: vm.description,
                keyboardType: TextInputType.text,
                maxLines: 2,
                textInputAction: TextInputAction.done,
                maxLength: 100,
                onChanged: (text) {
                  vm.changeDescription(text);
                },
                onFieldSubmitted: (text) {
                  FocusScope.of(context).unfocus();
                },
                decoration: InputDecoration(
                  fillColor: Theme.of(context).backgroundColor,
                  filled: true,
                  hintText: AppLocalization.of(context)
                      .getTranslatedVal("enter_note_here"),
                  enabledBorder: OutlineInputBorder(
                    gapPadding: 0,
                    borderSide: BorderSide(
                        color: Theme.of(context).dividerColor, width: 1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  focusedBorder: OutlineInputBorder(
                    gapPadding: 0,
                    borderSide: BorderSide(
                        color: Theme.of(context).dividerColor, width: 1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _selectDate(BuildContext context, AddEntryViewModel vm) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: vm.date, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    print(picked);
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
