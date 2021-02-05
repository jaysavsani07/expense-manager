import 'package:expense_manager/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class AmountText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return [
      "10".text.xl4.bold.make().p4(),
      AppConstants.keyboard
          .map((e) => Flexible(
                flex: 1,
                child: e
                    .map((e) => Flexible(
                        flex: 1,
                        child: e.text.xl2
                            .make()
                            .centered()
                            .box
                            .height(100)
                            .width(100)
                            .make()))
                    .toList()
                    .row(
                        axisSize: MainAxisSize.max,
                        alignment: MainAxisAlignment.spaceBetween),
              ))
          .toList()
          .column()
          .expand(),
    ].column().expand();
  }
}
