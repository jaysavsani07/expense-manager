import 'package:expense_manager/data/models/category.dart';
import 'package:flutter/material.dart';

class AppConstants {
  static final defaultCategoryList = [
    Category(
        name: "Food ans Drinks",
        icon: Icons.fastfood_rounded,
        iconColor: Color(0xFFc03c42)),
    Category(
        name: "Health",
        icon: Icons.local_hospital_rounded,
        iconColor: Color(int.parse("0xFF56717c"))),
    Category(
        name: "Shopping",
        icon: Icons.shopping_cart_rounded,
        iconColor: Color(int.parse("0xFFfdbe0d"))),
    Category(
        name: "Transportation",
        icon: Icons.directions_bus_rounded,
        iconColor: Color(int.parse("0xFF188976"))),
    Category(
        name: "Utilities",
        icon: Icons.build_rounded,
        iconColor: Color(int.parse("0xFFc03c42"))),
    otherCategory
  ];

  static final otherCategory = Category(
      name: "Other",
      icon: Icons.ac_unit_rounded,
      iconColor: Color(int.parse("0xFFc03c42")));

  static final keyboard = [
    ["1", "2", "3"],
    ["4", "5", "6"],
    ["7", "8", "9"],
    [".", "0", "DEL"]
  ];

  static final monthList = {
    1: "Jan",
    2: "Feb",
    3: "Mar",
    4: "Apr",
    5: "May",
    6: "Jun",
    7: "Jul",
    8: "Aug",
    9: "Sep",
    10: "Oct",
    11: "Nov",
    12: "Dec"
  };

  static final iconList = [
    Icons.fastfood_rounded,
    Icons.movie_creation_rounded,
    Icons.directions_car_rounded,
    Icons.shopping_cart_rounded,
    Icons.train_rounded,
    Icons.laptop_chromebook_rounded,
    Icons.local_hospital_rounded,
    Icons.home_rounded,
    Icons.flight_rounded,
    Icons.phone_android_rounded,
    Icons.school_rounded,
    Icons.smoking_rooms_rounded,
    Icons.lunch_dining,
    Icons.movie_creation_rounded,
    Icons.directions_car_rounded,
    Icons.shopping_cart_rounded,
    Icons.train_rounded,
    Icons.laptop_chromebook_rounded,
    Icons.local_hospital_rounded,
    Icons.home_rounded,
    Icons.flight_rounded,
    Icons.phone_android_rounded,
    Icons.school_rounded,
    Icons.smoking_rooms_rounded,
  ];

  static final iconColorList = [
    Color(int.parse("0xFFc03c42")),
    Color(int.parse("0xFF56717c")),
    Color(int.parse("0xFFfdbe0d")),
    Color(int.parse("0xFFc03c42")),
    Color(int.parse("0xFF188976")),
    Color(int.parse("0xFFfdbe0d")),
    Color(int.parse("0xFFc03c42")),
    Color(int.parse("0xFF56717c")),
    Color(int.parse("0xFFfdbe0d")),
    Color(int.parse("0xFFc03c42")),
    Color(int.parse("0xFF188976")),
    Color(int.parse("0xFFfdbe0d")),
    Color(int.parse("0xFFc03c42")),
    Color(int.parse("0xFF56717c")),
    Color(int.parse("0xFFfdbe0d")),
    Color(int.parse("0xFFc03c42")),
    Color(int.parse("0xFF188976")),
    Color(int.parse("0xFFfdbe0d")),
    Color(int.parse("0xFFc03c42")),
    Color(int.parse("0xFF188976")),
    Color(int.parse("0xFFfdbe0d")),
    Color(int.parse("0xFFc03c42")),
    Color(int.parse("0xFF56717c")),
    Color(int.parse("0xFFfdbe0d")),
    Color(int.parse("0xFFc03c42")),
    Color(int.parse("0xFF188976")),
    Color(int.parse("0xFFfdbe0d")),
  ];
}
