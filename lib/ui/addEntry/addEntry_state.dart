import 'package:expense_manager/core/constants.dart';
import 'package:expense_manager/data/models/category.dart' as cat;
import 'package:expense_manager/data/models/entry.dart';
import 'package:expense_manager/data/models/entry_with_category.dart';
import 'package:expense_manager/data/repository/entry_repository_imp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tuple/tuple.dart';

final addEntryModelProvider = ChangeNotifierProvider.autoDispose.family<
    AddEntryViewModel, Tuple3<EntryType, EntryWithCategory?, cat.Category?>>(
  (ref, entryWithCategory) => AddEntryViewModel(
      entryDataSourceImp: ref.read(repositoryProvider),
      entryType: entryWithCategory.item1,
      entryWithCategory: entryWithCategory.item2,
      category: entryWithCategory.item3),
);

class AddEntryViewModel with ChangeNotifier {
  EntryRepositoryImp entryDataSourceImp;
  EntryWithCategory? entryWithCategory;

  List<cat.Category> expenseCategoryList = [];
  List<cat.Category> incomeCategoryList = [];
  String amount = "";
  cat.Category? category;
  DateTime date = DateTime.now();
  String description = "";
  EntryType entryType;

  AddEntryViewModel({
    required this.entryDataSourceImp,
    this.entryWithCategory,
    required this.category,
    required this.entryType,
  }) {
    this.entryWithCategory = entryWithCategory;
    if (entryWithCategory != null) {
      amount = entryWithCategory!.entry.amount.toString();
      date = entryWithCategory!.entry.modifiedDate;
      category = entryWithCategory!.category;
      description = entryWithCategory!.entry.description;
    }

    entryDataSourceImp.getAllCategory(EntryType.expense).listen((event) {
      expenseCategoryList = event;
      notifyListeners();
    });

    entryDataSourceImp.getAllCategory(EntryType.income).listen((event) {
      incomeCategoryList = event;
      notifyListeners();
    });
  }

  void addUpdateEntry() {
    if (entryWithCategory != null) {
      entryDataSourceImp
          .updateEntry(
              entryType,
              Entry(
                  id: entryWithCategory!.entry.id,
                  amount: double.parse(amount),
                  categoryId: category?.id,
                  modifiedDate: date,
                  description: description))
          .listen((event) {});
    } else {
      entryDataSourceImp
          .addEntry(
              entryType,
              Entry(
                  amount: double.parse(amount),
                  categoryId: category?.id,
                  modifiedDate: date,
                  description: description))
          .listen((event) {});
    }
  }

  void categoryChange(cat.Category category) {
    this.category = category;
    notifyListeners();
  }

  void amountChange(String amount) {
    this.amount = amount;
    notifyListeners();
  }

  void entryTypeChange(EntryType entryType) {
    this.entryType = entryType;
    notifyListeners();
  }

  void changeDate(DateTime dateTime) {
    this.date = DateTime(
        dateTime.year, dateTime.month, dateTime.day, date.hour, date.minute);
    notifyListeners();
  }

  void changeDescription(String description) {
    this.description = description;
    notifyListeners();
  }

  void changeTime(TimeOfDay timeOfDay) {
    this.date = DateTime(
        date.year, date.month, date.day, timeOfDay.hour, timeOfDay.minute);
    notifyListeners();
  }

  @override
  void dispose() {
    expenseCategoryList = [];
    amount = "";
    category = null;
    date = DateTime.now();
    description = "";
    super.dispose();
  }
}
