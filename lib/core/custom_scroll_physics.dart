import 'package:flutter/material.dart';

class CustomScrollPhysics extends PageScrollPhysics {
  const CustomScrollPhysics({ScrollPhysics parent}) : super(parent: parent);

  @override
  double get minFlingVelocity => 0.01;

  @override
  double get maxFlingVelocity => 0.5;

  @override
  double get minFlingDistance => 10;

  @override
  double get dragStartDistanceMotionThreshold => 80;

  @override
  CustomScrollPhysics applyTo(ScrollPhysics ancestor) {
    return CustomScrollPhysics(parent: buildParent(ancestor));
  }
}
