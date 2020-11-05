import 'dart:async';

import 'package:expense_manager/core/keys.dart';
import 'package:expense_manager/ui/app/app_state.dart';
import 'package:expense_manager/data/models/entry.dart';
import 'package:expense_manager/data/models/home_tab.dart';
import 'package:expense_manager/ui/addEntry/addEntry_action.dart';
import 'package:expense_manager/ui/home/home_action.dart';
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
              FlatButton(
                  onPressed: () {
                    vm.onSaveCallback(Entry(
                        amount: double.parse(amount) ,categoryName: "Health"));
                  },
                  child: Text("SAVE"))
            ],
          ),
        );
      },
    );
  }

  String amount = "0";
}

class _ViewModel {
  final Function(Entry) onSaveCallback;
  final Entry entry;

  _ViewModel({
    @required this.entry,
    @required this.onSaveCallback,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      entry: store.state.addEntryState.entry,
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
