import 'package:expense_manager/data/models/category.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

enum EntryType { expense, income, all }
enum QuarterlyType { Q1, Q2, Q3, Q4 }

class AppConstants {
  static final defaultCategoryList = [
    Category(
        name: "Food", icon: Icons.restaurant, iconColor: Color(0xFFc03c42)),
    Category(
        name: "Health",
        icon: Icons.local_hospital_rounded,
        iconColor: Color(0xFF56717c)),
    Category(
        name: "Shopping",
        icon: Icons.shopping_cart_rounded,
        iconColor: Color(0xFFfdbe0d)),
    Category(
        name: "Transportation",
        icon: Icons.directions_bus_rounded,
        iconColor: Color(0xFF188976)),
    Category(
        name: "Utilities",
        icon: Icons.build_rounded,
        iconColor: Color(0xFFAB3A66)),
  ];

  static final defaultIncomeCategoryList = [
    Category(
        name: "Salary",
        icon: Icons.attach_money_outlined,
        iconColor: Color(0xFFc03c42)),
    Category(
        name: "Allowance",
        icon: Icons.security_outlined,
        iconColor: Color(0xFF84C03C)),
    Category(
        name: "Bonus",
        icon: Icons.sentiment_very_satisfied_outlined,
        iconColor: Color(0xFF3CC0BA)),
    Category(
        name: "Petty Cash",
        icon: Icons.money_outlined,
        iconColor: Color(0xFF783CC0)),
  ];

  static final otherCategory = Category(
      name: "Other", icon: Icons.ac_unit_rounded, iconColor: Color(0xFF798897));

  static final monthList = {
    1: "jan",
    2: "feb",
    3: "mar",
    4: "apr",
    5: "may",
    6: "jun",
    7: "jul",
    8: "aug",
    9: "sep",
    10: "oct",
    11: "nov",
    12: "dec"
  };

  static final quarterlyMonth ={
    QuarterlyType.Q1: [1, 2, 3],
    QuarterlyType.Q2: [4,5, 6],
    QuarterlyType.Q3: [ 7, 8 ,9],
    QuarterlyType.Q4: [10, 11, 12],
  };

  static final currencyList = [
    Tuple2("en", "Dollar"),
    Tuple2("eu", "Euro"),
    Tuple2("cy", "Pound"),
    Tuple2("ja", "Yen"),
    Tuple2("en_IN", "Rupee"),
  ];

  static final expenseIconList = [
    Icons.fastfood_rounded,
    Icons.local_cafe_rounded,
    Icons.local_dining_rounded,
    Icons.restaurant_rounded,
    Icons.local_bar_rounded,
    Icons.lunch_dining,
    Icons.cake_rounded,
    Icons.directions_bus_rounded,
    Icons.directions_car_rounded,
    Icons.local_shipping_rounded,
    Icons.two_wheeler_rounded,
    Icons.train_rounded,
    Icons.agriculture_rounded,
    Icons.build_rounded,
    Icons.local_movies_rounded,
    Icons.audiotrack_rounded,
    Icons.shopping_cart_rounded,
    Icons.laptop_chromebook_rounded,
    Icons.local_hospital_rounded,
    Icons.home_rounded,
    Icons.flight_rounded,
    Icons.phone_android_rounded,
    Icons.school_rounded,
    Icons.smoking_rooms_rounded,
    Icons.add_circle_rounded,
    Icons.receipt_long_rounded,
    Icons.payment_rounded,
    Icons.attach_money_rounded,
    Icons.trending_up_rounded,
    Icons.widgets_rounded,
    Icons.security_rounded,
    Icons.toys_rounded,
    Icons.local_gas_station_rounded,
    Icons.hotel_rounded,
    Icons.electrical_services_rounded,
    Icons.festival,
    Icons.local_laundry_service_rounded,
    Icons.local_library_rounded,
    Icons.child_care_rounded,
    Icons.fitness_center_rounded,
    Icons.sports_esports_rounded,
    Icons.add_moderator,
    Icons.science_rounded,
    Icons.eco_rounded,
    Icons.public_rounded,
  ];

  static final expenseIconColorList = [
    Color(0xFFc03c42),
    Color(0xFFF44336),
    Color(0xFFE91E63),
    Color(0xFF9C27B0),
    Color(0xFF673AB7),
    Color(0xFF3F51B5),
    Color(0xFF2196F3),
    Color(0xFF03A9F4),
    Color(0xFF00BCD4),
    Color(0xFF009688),
    Color(0xFF4CAF50),
    Color(0xFF8BC34A),
    Color(0xFFCDDC39),
    Color(0xFFFFEB3B),
    Color(0xFFFFC107),
    Color(0xFFFF9800),
    Color(0xFF9E9E9E),
    Color(0xFF607D8B),
    Color(0xFF86447C),
    Color(0xFF5B4C7E),
    Color(0xFF2F4858),
    Color(0xFFB9538E),
  ];

  static final incomeIconList = [
    Icons.fastfood_rounded,
    Icons.local_cafe_rounded,
    Icons.local_dining_rounded,
    Icons.restaurant_rounded,
    Icons.local_bar_rounded,
    Icons.lunch_dining,
    Icons.cake_rounded,
    // Icons.directions_bus_rounded,
    // Icons.directions_car_rounded,
    // Icons.local_shipping_rounded,
    // Icons.two_wheeler_rounded,
    // Icons.train_rounded,
    // Icons.agriculture_rounded,
    // Icons.build_rounded,
    // Icons.local_movies_rounded,
    // Icons.audiotrack_rounded,
    // Icons.shopping_cart_rounded,
    // Icons.laptop_chromebook_rounded,
    // Icons.local_hospital_rounded,
    // Icons.home_rounded,
    // Icons.flight_rounded,
    // Icons.phone_android_rounded,
    // Icons.school_rounded,
    // Icons.smoking_rooms_rounded,
    // Icons.add_circle_rounded,
    // Icons.receipt_long_rounded,
    // Icons.payment_rounded,
    // Icons.attach_money_rounded,
    // Icons.trending_up_rounded,
    // Icons.widgets_rounded,
    // Icons.security_rounded,
    // Icons.toys_rounded,
    // Icons.local_gas_station_rounded,
    // Icons.hotel_rounded,
    // Icons.electrical_services_rounded,
    // Icons.festival,
    // Icons.local_laundry_service_rounded,
    // Icons.local_library_rounded,
    // Icons.child_care_rounded,
    // Icons.fitness_center_rounded,
    // Icons.sports_esports_rounded,
    // Icons.add_moderator,
    // Icons.science_rounded,
    // Icons.eco_rounded,
    // Icons.public_rounded,
  ];

  static final incomeIconColorList = [
    Color(0xFFc03c42),
    Color(0xFFF44336),
    Color(0xFFE91E63),
    Color(0xFF9C27B0),
    Color(0xFF673AB7),
    // Color(0xFF3F51B5),
    // Color(0xFF2196F3),
    // Color(0xFF03A9F4),
    // Color(0xFF00BCD4),
    // Color(0xFF009688),
    // Color(0xFF4CAF50),
    // Color(0xFF8BC34A),
    // Color(0xFFCDDC39),
    // Color(0xFFFFEB3B),
    // Color(0xFFFFC107),
    // Color(0xFFFF9800),
    // Color(0xFF9E9E9E),
    // Color(0xFF607D8B),
    // Color(0xFF86447C),
    // Color(0xFF5B4C7E),
    // Color(0xFF2F4858),
    // Color(0xFFB9538E),
  ];
}
