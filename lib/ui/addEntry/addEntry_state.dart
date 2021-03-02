import 'package:expense_manager/core/constants.dart';
import 'package:expense_manager/data/models/category.dart' as cat;
import 'package:expense_manager/data/models/entry.dart';
import 'package:expense_manager/data/models/entry_with_category.dart';
import 'package:expense_manager/data/repository/entry_repository_imp.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final addEntryModelProvider =
    ChangeNotifierProvider.family<AddEntryViewModel, EntryWithCategory>(
  (ref, entryWithCategory) => AddEntryViewModel(
      entryDataSourceImp: ref.read(repositoryProvider),
      entryWithCategory: entryWithCategory),
);

class AddEntryViewModel with ChangeNotifier {
  EntryRepositoryImp entryDataSourceImp;
  EntryWithCategory entryWithCategory;

  List<cat.Category> categoryList = [];
  String amount = "0";
  cat.Category category;
  DateTime date = DateTime.now();
  String description = "";

  AddEntryViewModel(
      {@required this.entryDataSourceImp, @required this.entryWithCategory}) {
    this.entryWithCategory = entryWithCategory;
    if (entryWithCategory != null) {
      amount = entryWithCategory.entry.amount.toString();
      date = entryWithCategory.entry.modifiedDate;
      category = entryWithCategory.category;
      description = entryWithCategory.entry.description;
    }
    entryDataSourceImp.getAllCategory().listen((event) {
      categoryList = event;
      notifyListeners();
    });
  }

  void addEntry() {
    if (entryWithCategory != null) {
      entryDataSourceImp
          .updateEntry(Entry(
              id: entryWithCategory.entry.id,
              amount: double.parse(amount),
              categoryName: category.name,
              modifiedDate: date,
              description: description))
          .listen((event) {});
    } else {
      entryDataSourceImp
          .addEntry(Entry(
              amount: double.parse(amount),
              categoryName: category?.name,
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
    categoryList = [];
    amount = "0";
    category = AppConstants.otherCategory;
    date = DateTime.now();
    description = "";
    super.dispose();
  }
}
