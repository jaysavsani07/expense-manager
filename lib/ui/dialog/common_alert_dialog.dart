import 'package:flutter/material.dart';

class CommonAlertDialog extends AlertDialog {
  final Widget child;

  CommonAlertDialog({required this.child}) : super();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.only(
            left: 24, right: 24, top: kToolbarHeight + 12),
        child: Material(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(14))),
          child: child,
        ),
      ),
    );
  }
}
