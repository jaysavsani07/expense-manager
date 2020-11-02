import 'package:expense_manager/data/models/app_state.dart';
import 'package:expense_manager/ui/app/app.dart';
import 'package:expense_manager/ui/app/app_reducer.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp(
    store: Store<AppState>(
      appReducer,
      initialState: AppState.loading(),
    ),
  ));
}


/*
StoreProvider(
store: Store<int>(reducerCounter, initialState: 0),
child: Scaffold(
appBar: AppBar(
title: Text(widget.title),
),
body: Center(
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
children: <Widget>[
Text(
'You have pushed the button this many times:',
),
StoreConnector<int, String>(
converter: (store) => store.state.toString(),
builder: (BuildContext context, viewModel) {
return Text(
'$viewModel',
style: Theme.of(context).textTheme.headline4,
);
},
)
],
),
),
floatingActionButton: Row(
children: [
StoreConnector<int, VoidCallback>(
converter: (Store<int> store) {
return () {
store.dispatch(IncrementCountAction());
};
},
builder: (BuildContext context, VoidCallback increase) {
return FloatingActionButton(
onPressed: increase,
child: Icon(Icons.add),
);
},
)
],
),
),
);*/
