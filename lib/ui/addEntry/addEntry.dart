import 'package:expense_manager/core/keys.dart';
import 'package:expense_manager/data/models/category.dart';
import 'package:expense_manager/ui/app/app_state.dart';
import 'package:expense_manager/data/models/entry.dart';
import 'package:expense_manager/ui/addEntry/addEntry_action.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class AddEntry extends StatefulWidget {
  AddEntry() : super(key: AppKeys.addTodoFab);

  @override
  _AddEntryState createState() => _AddEntryState();
}

class _AddEntryState extends State<AddEntry> {
  String amount = "0";
  String categoryName = "";

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      distinct: true,
      converter: _ViewModel.fromStore,
      builder: (context, vm) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Dashboard"),
          ),
          body: Column(
            children: [
              TextFormField(
                autofocus: true,
                keyboardType: TextInputType.number,
                onChanged: (value) => amount = value,
              ),
              Container(
                height: 235,
                child: GridView(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  scrollDirection: Axis.horizontal,
                  children: vm.categoryList
                      .map((category) => InkWell(
                            onTap: () {
                              categoryName = category.name;
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 5),
                              width: 110,
                              height: 110,
                              child: Card(
                                color: category.iconColor,
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                ),
                                child: Icon(category.icon),
                              ),
                            ),
                          ))
                      .toList(),
                ),
              ),
              FlatButton(
                  onPressed: () {
                    vm.onSaveCallback(
                      Entry(
                          amount: double.parse(amount),
                          categoryName: categoryName,
                          modifiedDate: DateTime.now()),
                    );
                  },
                  child: Text("SAVE"))
            ],
          ),
        );
      },
    );
  }
}

class _ViewModel {
  final Function(Entry) onSaveCallback;
  final Entry entry;
  final List<Category> categoryList;

  _ViewModel({
    @required this.entry,
    @required this.categoryList,
    @required this.onSaveCallback,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      entry: store.state.addEntryState.entry,
      categoryList: store.state.addEntryState.categoryList,
      onSaveCallback: (entry) {
        store.dispatch(AddEntryAction(entry));
      },
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _ViewModel &&
          runtimeType == other.runtimeType &&
          entry == other.entry;

  @override
  int get hashCode => entry.hashCode;
}
