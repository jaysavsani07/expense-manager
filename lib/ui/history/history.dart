import 'package:expense_manager/data/models/history.dart';
import 'package:expense_manager/ui/app/app_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';
import 'package:redux/redux.dart';

class History1 extends StatelessWidget {
  History1({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      distinct: true,
      converter: _ViewModel.fromStore,
      builder: (context, vm) {
        return ListView(
          shrinkWrap: true,
          children: vm.list
              .map((History history) => Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          history.title,
                          style: TextTheme().caption,
                        ),
                        ListView(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          children: history.list
                              .map((e) => Container(
                                    padding: EdgeInsets.symmetric(vertical: 8),
                                    height: 66,
                                    child: Row(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(25)),
                                            color: e.category.iconColor,
                                          ),
                                          height: 50,
                                          width: 50,
                                          child: Icon(e.category.icon),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8,
                                                right: 8,
                                                bottom: 4,
                                                top: 4),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      e.category.name,
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(
                                                        e.entry.amount
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold))
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      DateFormat('d MMM')
                                                          .format(e.entry
                                                              .modifiedDate),
                                                      style:
                                                          TextTheme().caption,
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 4),
                                                      child: Icon(
                                                        Icons.circle,
                                                        size: 8,
                                                      ),
                                                    ),
                                                    Text(
                                                      DateFormat.Hm().format(
                                                          e.entry.modifiedDate),
                                                      style:
                                                          TextTheme().caption,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ))
                              .toList(),
                        )
                      ],
                    ),
                  ))
              .toList(),
        );
      },
    );
  }
}

class _ViewModel {
  final List<History> list;

  _ViewModel({
    @required this.list,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      list: store.state.historyState.list,
    );
  }
}
