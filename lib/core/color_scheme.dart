import 'package:flutter/material.dart';

extension CustomColorScheme on ColorScheme {
  Color get baseColor =>
      brightness == Brightness.light ? Colors.white : Colors.black;
  //
  // Color get baseLightColor => brightness == Brightness.light
  //     ? AppColor.whiteLight
  //     : AppColor.blackLight;
  //
  Color get crossColor =>
      brightness == Brightness.light ? Colors.black : Colors.white;
  //
  // Color get crossLightColor => brightness == Brightness.light
  //     ? AppColor.blackLight
  //     : AppColor.whiteLight;

  Color get paiChartColor =>
      brightness == Brightness.light ?
      Color(0xFFBDCDE0) :
      Color(0xFF292D32);

  Color get paiChartShadowLightColor =>
      brightness == Brightness.light ? Colors.black : Colors.white;

  Color get paiChartShadowDarkColor =>
      brightness == Brightness.light ? Colors.white : Colors.black;
}
