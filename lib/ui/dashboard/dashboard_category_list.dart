import 'package:expense_manager/data/models/category_with_sum.dart';
import 'package:expense_manager/ui/app/app_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class DashboardCategoryList extends StatelessWidget {
  DashboardCategoryList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      distinct: true,
      converter: _ViewModel.fromStore,
      builder: (context, vm) {
        return ListView(
          children: vm.list
              .map((e) => Container(
                    padding: EdgeInsets.symmetric(horizontal: 16  , vertical: 4),
                    width: double.maxFinite,
                    height: 110,
                    child: Card(
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  bottomLeft: Radius.circular(8)),
                              color: e.category.iconColor,
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            height: double.maxFinite,
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
                                          e.total
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight:
                                              FontWeight
                                                  .bold))
                                    ],
                                  ),
                                 /* Row(
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
                                  ),*/
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ))
              .toList(),
        );
      },
    );
  }
}

class _ViewModel {
  final List<CategoryWithSum> list;

  _ViewModel({
    @required this.list,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      list: store.state.dashboardState.list,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _ViewModel &&
          runtimeType == other.runtimeType &&
          list == other.list;

  @override
  int get hashCode => list.hashCode;
}
