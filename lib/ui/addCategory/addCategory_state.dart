import 'package:expense_manager/core/constants.dart';
import 'package:expense_manager/data/models/category.dart' as cat;
import 'package:expense_manager/data/repository/entry_repository_imp.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final addCategoryModelProvider =
    ChangeNotifierProvider.autoDispose.family<AddCategoryViewModel, cat.Category>(
  (ref, category) => AddCategoryViewModel(
      entryDataSourceImp: ref.read(repositoryProvider), category: category),
);

class AddCategoryViewModel with ChangeNotifier {
  EntryRepositoryImp entryDataSourceImp;
  cat.Category category;
  String name;
  IconData iconData;
  Color color;

  AddCategoryViewModel(
      {@required this.entryDataSourceImp, @required this.category}) {
    if (category == null) {
      name = "";
      iconData = AppConstants.otherCategory.icon;
      color = AppConstants.otherCategory.iconColor;
    } else {
      name = category.name;
      iconData = category.icon;
      color = category.iconColor;
    }
    notifyListeners();
  }

  void changeColor(Color color) {
    this.color = color;
    notifyListeners();
  }

  void changeIcon(IconData iconData) {
    this.iconData = iconData;
    notifyListeners();
  }

  void changeName(String name) {
    this.name = name;
  }

  void saveCategory() {
    if (category == null)
      entryDataSourceImp
          .addCategory(
              cat.Category(name: name, icon: iconData, iconColor: color))
          .listen((event) {});
    else
      entryDataSourceImp
          .updateCategory(cat.Category(
              id: category.id, name: name, icon: iconData, iconColor: color))
          .listen((event) {});
  }

  void deleteCategory() {
    entryDataSourceImp.deleteCategory(category.id).listen((event) {});
  }

  @override
  void dispose() {
    category = null;
    super.dispose();
  }
}
