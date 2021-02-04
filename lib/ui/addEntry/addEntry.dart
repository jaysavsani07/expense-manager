import 'package:expense_manager/ui/addEntry/addEntry_state.dart';
import 'package:expense_manager/ui/addEntry/amount_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';

class AddEntry extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final vm = watch(addEntryModelProvider);
    return ProviderListener<AddEntryViewModel>(
        provider: addEntryModelProvider,
        onChange: (context, model) async {},
        child: Scaffold(
          appBar: AppBar(
            title: Text("Dashboard"),
          ),
          body: Column(
            children: [
              /*TextFormField(
                autofocus: true,
                keyboardType: TextInputType.number,
                onChanged: (value) => amount = value,
              ),*/
              AmountText(),
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
                              // categoryName = category.name;
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
                                child: Stack(
                                  children: [
                                    Align(
                                        alignment: Alignment.center,
                                        child: Icon(category.icon)),
                                    Align(
                                      child: Text(category.name),
                                      alignment: Alignment.bottomCenter,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ))
                      .toList(),
                ),
              ),
              FlatButton(
                  onPressed: () {
                    // vm.onSaveCallback(
                    //   Entry(
                    //       amount: double.parse(amount),
                    //       categoryName: categoryName,
                    //       modifiedDate: DateTime.now()),
                    // );
                  },
                  child: Text("SAVE"))
            ],
          ),
        ));
  }
}
