import 'package:expense_manager/ui/history/history_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter_riverpod/all.dart';

class YearList extends StatelessWidget {
  final List<int> yearList;

  YearList({@required this.yearList}) : super();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: yearList.length,
        itemBuilder: (context, index) =>
            yearList[index].toString().text.xl2.center.make().p8().onInkTap(() {
              context
                  .read(historyViewModelProvider)
                  .changeYear(yearList[index]);
              Navigator.pop(context);
            }));
  }
}
