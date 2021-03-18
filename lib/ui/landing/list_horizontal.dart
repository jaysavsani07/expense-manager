import 'dart:math';

import 'package:expense_manager/core/scroll_snap_custom.dart';
import 'package:flutter/material.dart';

void main() => runApp(DynamicHorizontalDemo());

class DynamicHorizontalDemo extends StatefulWidget {
  @override
  _DynamicHorizontalDemoState createState() => _DynamicHorizontalDemoState();
}

class _DynamicHorizontalDemoState extends State<DynamicHorizontalDemo> {
  List<int> data = [];
  int _focusedIndex = -1;
  double cardSize = 380;
  double heightFromTop = 0;
  double listViewTopPadding = 100;

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < 3; i++) {
      data.add(Random().nextInt(100) + 1);
    }
  }

  void _onItemFocus(int index) {
    setState(() {
      _focusedIndex = index;
    });
  }

  Widget _buildItemDetail() {
    if (_focusedIndex < 0)
      return Container(
        height: 250,
        child: Text("Nothing selected"),
      );

    if (data.length > _focusedIndex)
      return Container(
        height: 250,
        child: Text("index $_focusedIndex: ${data[_focusedIndex]}"),
      );

    return Container(
      height: 250,
      child: Text("No Data"),
    );
  }

  Widget _buildTextItem(BuildContext context, int index) {
    if (index == 0) {
      return Container(
        width: cardSize,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Track Expense",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 32,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Add your daily expense in one touch &\n Get your daily reports via categorized charts",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[700]),
            )
          ],
        ),
        alignment: Alignment.center,
      );
    } else if (index == 1) {
      return Container(
        width: cardSize,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Control Finance",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 32,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Take control of your finances \n Allocate money to different priorities",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[700]),
            )
          ],
        ),
        alignment: Alignment.center,
      );
    } else if (index == 2) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Prioritize Spending",
            style: TextStyle(
                color: Colors.black, fontSize: 32, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            """Analyze your spending habits \nSave now and Achive your financial goals """,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey[700]),
          )
        ],
      );
    } else {
      return Container();
    }
  }

  Widget _buildListItem(BuildContext context, int index) {
    if (index == data.length)
      return Center(
        child: CircularProgressIndicator(),
      );

    if (index == 0) {
      return Container(
        padding: EdgeInsets.only(top: listViewTopPadding),
        width: cardSize,
        color: Colors.transparent,
        child: Container(
            padding: EdgeInsets.only(top: 100),
            child: Card(
              elevation: 4,
              shadowColor: Colors.grey,
              child: Container(),
            )),
      );
    } else if (index == 1) {
      return Container(
        padding: EdgeInsets.only(top: listViewTopPadding),
        width: cardSize,
        color: Colors.transparent,
        child: Container(
            padding: EdgeInsets.only(top: 100),
            child: Card(
              elevation: 4,
              shadowColor: Colors.grey,
              child: Container(),
            )),
      );
    } else {
      return Container(
        padding: EdgeInsets.only(top: listViewTopPadding),
        width: cardSize,
        color: Colors.transparent,
        child: Container(
            height: 50,
            padding: EdgeInsets.only(top: 100),
            child: Card(
              elevation: 4,
              shadowColor: Colors.grey,
              child: Container(),
            )),
      );
    }
    //horizontal
  }

  List<Widget> _buildListChild(BuildContext context, int index) {
    return [
      Container(
        width: 100,
        height: 100,
        color: Colors.black,
        key: ValueKey("first"),
      ),
      Container(
        width: 80,
        height: 80,
        color: Colors.blue,
        key: ValueKey("second"),
      ),
      Container(
        width: 100,
        height: 100,
        color: Colors.green,
        key: ValueKey("third"),
      ),
    ];
  }

  ///Override default dynamicItemSize calculation
  double customEquation(double distance) {
    // return 1-min(distance.abs()/500, 0.2);
    return 1 - (distance / cardSize);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Onboarding screen',
      home: Scaffold(
        body: SafeArea(
          child: Container(
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                    child: Text("Skip"),
                    onPressed: () {},
                  ),
                ),
                SizedBox(
                  height: heightFromTop,
                ),
                Expanded(
                  child: ScrollSnapListCustom(
                    onItemFocus: _onItemFocus,
                    itemSize: cardSize,
                    margin: EdgeInsets.zero,
                    padding: EdgeInsets.zero,
                    itemBuilder: _buildListItem,
                    listBuilder: _buildListChild,
                    textItemBuilder: _buildTextItem,
                    itemCount: data.length,
                    dynamicItemSize: true,
                    // dynamicSizeEquation: customEquation, //optional
                  ),
                ),
                SizedBox(
                  height: 00,
                )
                // _buildItemDetail(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
