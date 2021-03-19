import 'dart:math';

import 'package:expense_manager/core/routes.dart';
import 'package:expense_manager/core/scroll_snap_custom.dart';
import 'package:expense_manager/ui/dashboard/pie_chart.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:tuple/tuple.dart';

void main() => runApp(CustomScrollOnboarding());

class CustomScrollOnboarding extends StatefulWidget {
  @override
  _CustomScrollOnboardingState createState() => _CustomScrollOnboardingState();
}

class _CustomScrollOnboardingState extends State<CustomScrollOnboarding> {
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
    // print("********");
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
    print("_focusedIndex $_focusedIndex");
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
    // print("index asdf $index");
    if (index == data.length)
      return Center(
        child: CircularProgressIndicator(),
      );

    if (index == 0) {
      return Container(
        padding: EdgeInsets.only(
            top: listViewTopPadding, bottom: listViewTopPadding / 2),
        width: cardSize,
        color: Colors.transparent,
        child: Container(
            padding: EdgeInsets.only(top: 100),
            child: Card(
              elevation: 4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 2.2,
                    child: PieChart(
                      dataMap: [
                        Tuple2(45, Color(0xFFFF5722)),
                        Tuple2(20, Color(0xFFCDDC39)),
                        Tuple2(8, Color(0xFF795548)),
                        Tuple2(15, Color(0xFFE91E63)),
                      ],
                      animationDuration: Duration(milliseconds: 800),
                      chartLegendSpacing: 16,
                      chartRadius: MediaQuery.of(context).size.width / 3.2 > 300
                          ? 300
                          : MediaQuery.of(context).size.width / 2.5,
                      initialAngleInDegree: -80,
                      centerText: Container(),
                      ringStrokeWidth: 20,
                      emptyColor: Colors.grey,
                    ),
                  ),
                  Container(
                      width: 100,
                      height: 180,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 15,
                                height: 30,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xFFFF5722)),
                              ),
                              Container(
                                width: 10,
                              ),
                              Container(
                                width: 60,
                                height: 15,
                                decoration: BoxDecoration(
                                    color: Color(0xFFEEEEEE),
                                    borderRadius: BorderRadius.circular(5)),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                width: 15,
                                height: 30,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xFFCDDC39)),
                              ),
                              Container(
                                width: 10,
                              ),
                              Container(
                                width: 30,
                                height: 15,
                                decoration: BoxDecoration(
                                    color: Color(0xFFEEEEEE),
                                    borderRadius: BorderRadius.circular(5)),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                width: 15,
                                height: 30,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xFF795548)),
                              ),
                              Container(
                                width: 10,
                              ),
                              Container(
                                width: 75,
                                height: 15,
                                decoration: BoxDecoration(
                                    color: Color(0xFFEEEEEE),
                                    borderRadius: BorderRadius.circular(5)),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                width: 15,
                                height: 30,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xFFE91E63)),
                              ),
                              Container(
                                width: 10,
                              ),
                              Container(
                                width: 50,
                                height: 15,
                                decoration: BoxDecoration(
                                    color: Color(0xFFEEEEEE),
                                    borderRadius: BorderRadius.circular(5)),
                              )
                            ],
                          ),
                        ],
                      ))
                ],
              ),
            )),
      );
    } else if (index == 1) {
      return Container(
        padding: EdgeInsets.only(
            top: listViewTopPadding, bottom: listViewTopPadding / 2),
        width: cardSize,
        alignment: Alignment.center,
        child: Container(
            padding: EdgeInsets.only(top: 100),
            child: Card(
              elevation: 4,
              shadowColor: Colors.grey,
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 1.2,
                    margin: EdgeInsets.all(10),
                    height: 212,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.train_rounded,
                              size: 25,
                              color: Color(0xFFFF5722),
                            ),
                            Container(
                              height: 30,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 100,
                                    height: 13,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(3),
                                        color: Color(0xFFEEEEEE)),
                                  ),
                                  LinearPercentIndicator(
                                      width: MediaQuery.of(context).size.width /
                                          1.4,
                                      lineHeight: 6.0,
                                      percent: 1.0,
                                      padding: EdgeInsets.zero,
                                      backgroundColor: Color(0xFFEEEEEE),
                                      progressColor: Color(0xFFFF5722)),
                                ],
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.restaurant,
                              size: 25,
                              color: Color(0xFFCDDC39),
                            ),
                            Container(
                              height: 30,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 100,
                                    height: 13,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(3),
                                        color: Color(0xFFEEEEEE)),
                                  ),
                                  LinearPercentIndicator(
                                      width: MediaQuery.of(context).size.width /
                                          1.4,
                                      lineHeight: 6.0,
                                      percent: 0.7,
                                      padding: EdgeInsets.zero,
                                      backgroundColor: Color(0xFFEEEEEE),
                                      progressColor: Color(0xFFCDDC39))
                                ],
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.label,
                              size: 25,
                              color: Color(0xFFE91E63),
                            ),
                            Container(
                              height: 30,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 100,
                                    height: 13,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(3),
                                        color: Color(0xFFEEEEEE)),
                                  ),
                                  LinearPercentIndicator(
                                      width: MediaQuery.of(context).size.width /
                                          1.4,
                                      lineHeight: 6.0,
                                      percent: 0.4,
                                      padding: EdgeInsets.zero,
                                      backgroundColor: Color(0xFFEEEEEE),
                                      progressColor: Color(0xFFE91E63)),
                                ],
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.local_cafe,
                              size: 25,
                              color: Color(0xFF795548),
                            ),
                            Container(
                              height: 30,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 100,
                                    height: 13,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(3),
                                        color: Color(0xFFEEEEEE)),
                                  ),
                                  LinearPercentIndicator(
                                      width: MediaQuery.of(context).size.width /
                                          1.4,
                                      lineHeight: 6.0,
                                      percent: 0.15,
                                      padding: EdgeInsets.zero,
                                      backgroundColor: Color(0xFFEEEEEE),
                                      progressColor: Color(0xFF795548)),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )),
      );
    } else {
      return Container(
          padding: EdgeInsets.only(top: listViewTopPadding - 10),
          width: cardSize,
          child: Stack(
            children: [
              Container(
                  padding: EdgeInsets.only(top: 0),
                  child: Container(
                    padding: EdgeInsets.only(left: 35, right: 35),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              elevation: 4,
                              shadowColor: Colors.grey,
                              child: Container(
                                  width: 90,
                                  height: 90,
                                  child: Icon(
                                    Icons.school_rounded,
                                    size: 45,
                                    color: Color(0xFF673AB7),
                                  )),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              elevation: 4,
                              shadowColor: Colors.grey,
                              child: Container(
                                  width: 90,
                                  height: 90,
                                  child: Icon(
                                    Icons.movie_creation_rounded,
                                    size: 45,
                                    color: Color(0xFFFFC107),
                                  )),
                            ),
                            Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              elevation: 4,
                              shadowColor: Colors.grey,
                              child: Container(
                                  width: 90,
                                  height: 90,
                                  child: Icon(
                                    Icons.restaurant,
                                    size: 45,
                                    color: Color(0xFFCDDC39),
                                  )),
                            ),
                            Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              elevation: 4,
                              shadowColor: Colors.grey,
                              child: Container(
                                  width: 90,
                                  height: 90,
                                  child: Icon(
                                    Icons.medical_services,
                                    size: 45,
                                    color: Color(0xFF2196F3),
                                  )),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              elevation: 4,
                              shadowColor: Colors.grey,
                              child: Container(
                                  width: 90,
                                  height: 90,
                                  child: Icon(
                                    Icons.shopping_basket,
                                    size: 45,
                                    color: Color(0xFF00BCD4),
                                  )),
                            ),
                            Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              elevation: 4,
                              shadowColor: Colors.grey,
                              child: Container(
                                  width: 90,
                                  height: 90,
                                  child: Icon(
                                    Icons.more_rounded,
                                    size: 45,
                                    color: Color(0xFFE91E63),
                                  )),
                            ),
                            Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              elevation: 4,
                              shadowColor: Colors.grey,
                              child: Container(
                                  width: 90,
                                  height: 90,
                                  child: Icon(
                                    Icons.train,
                                    size: 45,
                                    color: Color(0xFFFF5722),
                                  )),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              elevation: 4,
                              shadowColor: Colors.grey,
                              child: Container(
                                  width: 90,
                                  height: 90,
                                  child: Icon(
                                    Icons.local_cafe,
                                    size: 45,
                                    color: Color(0xFF795548),
                                  )),
                            ),
                          ],
                        )
                      ],
                    ),
                  )),
            ],
          ));
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
                    onPressed: () {
                      Navigator.popAndPushNamed(
                        context,
                        AppRoutes.welcome,
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: heightFromTop,
                ),
                Expanded(
                  child: ScrollSnapPageCustom(
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
