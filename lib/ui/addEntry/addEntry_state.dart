import 'package:expense_manager/core/constants.dart';
import 'package:expense_manager/data/models/category.dart' as cat;
import 'package:expense_manager/data/models/entry.dart';
import 'package:expense_manager/data/repository/entry_repository_imp.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final addEntryModelProvider = ChangeNotifierProvider<AddEntryViewModel>(
  (ref) => AddEntryViewModel(entryDataSourceImp: ref.read(repositoryProvider)),
);

class AddEntryViewModel with ChangeNotifier {
  EntryRepositoryImp entryDataSourceImp;

  List<cat.Category> categoryList = [];
  String amount = "0";
  cat.Category category = AppConstants.otherCategory;
  bool isShowNumPad = true;

  AddEntryViewModel({@required this.entryDataSourceImp}) {
    entryDataSourceImp.getAllCategory().listen((event) {
      categoryList = event;
      print(event);
      notifyListeners();
    });
  }

  void addEntry() {
    entryDataSourceImp
        .addNewEntry(Entry(
            amount: double.parse(amount),
            categoryName: category.name,
            modifiedDate: DateTime.now()))
        .listen((event) {});
  }

  void showNumPad() {
    if (!isShowNumPad) {
      isShowNumPad = true;
      notifyListeners();
    }
  }

  void hideNumPad() {
    if (isShowNumPad) {
      isShowNumPad = false;
      notifyListeners();
    }
  }

  void categoryChange(cat.Category category) {
    this.category = category;
    notifyListeners();
  }

  void textChange(String text) {
    if (text == "<-")
      backPress();
    else if (text == ".")
      dotPress();
    else
      numberPress(text);
  }

  void numberPress(String text) {
    if (amount == "0") {
      amount = text;
    } else {
      amount = amount + text;
    }
    notifyListeners();
  }

  void backPress() {
    if (amount.length > 1) {
      amount = amount.substring(0, amount.length - 1);
    } else {
      amount = "0";
    }
    notifyListeners();
  }

  void dotPress() {
    if (!amount.contains(".")) {
      amount = amount + ".";
      notifyListeners();
    }
  }

  @override
  void dispose() {
    categoryList = [];
    amount = "0";
    category = AppConstants.otherCategory;
    isShowNumPad = true;
    super.dispose();
  }
}
