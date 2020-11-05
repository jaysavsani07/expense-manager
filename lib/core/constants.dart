import 'package:expense_manager/data/models/category.dart';
import 'package:flutter/material.dart';

class AppConstants {
  static final defaultCategoryList = [
    Category(
        name: "Food ans Drinks",
        icon: Icons.fastfood,
        iconColor: Color(int.parse("0xFFc03c42"))),
    Category(
        name: "Health",
        icon: Icons.fastfood,
        iconColor: Color(int.parse("0xFF56717c"))),
    Category(
        name: "Shopping",
        icon: Icons.fastfood,
        iconColor: Color(int.parse("0xFFfdbe0d"))),
    Category(
        name: "Transportation",
        icon: Icons.fastfood,
        iconColor: Color(int.parse("0xFF188976"))),
    Category(
        name: "Utilities",
        icon: Icons.fastfood,
        iconColor: Color(int.parse("0xFFc03c42"))),
  ];
}
