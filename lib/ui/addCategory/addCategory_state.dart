import 'package:expense_manager/core/constants.dart';
import 'package:expense_manager/data/models/category.dart' as cat;
import 'package:expense_manager/data/repository/entry_repository_imp.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tuple/tuple.dart';

final addCategoryModelProvider = ChangeNotifierProvider.autoDispose
    .family<AddCategoryViewModel, Tuple2<EntryType, cat.Category>>(
        (ref, tuple2) => AddCategoryViewModel(
              entryDataSourceImp: ref.read(repositoryProvider),
              entryType: tuple2.item1,
              category: tuple2.item2,
            ));

class AddCategoryViewModel with ChangeNotifier {
  EntryRepositoryImp entryDataSourceImp;
  cat.Category category;
  String name;
  IconData iconData;
  Color color;
  EntryType entryType;

  AddCategoryViewModel({
    @required this.entryDataSourceImp,
    @required this.category,
    @required this.entryType,
  }) {
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

  void addUpdateCategory() {
    if (category == null) {
      entryDataSourceImp
          .addCategory(entryType,
              cat.Category(name: name.trim(), icon: iconData, iconColor: color))
          .listen((event) {});
    } else {
      entryDataSourceImp
          .updateCategory(
              entryType,
              cat.Category(
                  id: category.id,
                  position: category.position,
                  name: name,
                  icon: iconData,
                  iconColor: color))
          .listen((event) {});
    }
  }

  void delete() {
    entryDataSourceImp
        .deleteCategory(entryType, category.id)
        .listen((event) {});
  }

  @override
  void dispose() {
    category = null;
    super.dispose();
  }
}
