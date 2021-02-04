import 'package:expense_manager/core/constants.dart';
import 'package:flutter/material.dart';

class AmountText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
      children: [
        Text(""),
        Expanded(
          child: Column(
            children: AppConstants.keyboard
                .map((e) => Flexible(
                      flex: 1,
                      child: Row(
                        children: e
                            .map((e) => Flexible(flex: 1, child: Text(e)))
                            .toList(),
                      ),
                    ))
                .toList(),
          ),
        ),
        FlatButton(
          child: Text("Save"),
          onPressed: () {},
          color: ThemeData().primaryColor,
        )
      ],
    ));
  }
}
