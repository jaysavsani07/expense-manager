import 'package:expense_manager/core/routes.dart';
import 'package:expense_manager/core/scroll_snap_custom.dart';
import 'package:expense_manager/ui/dashboard/pie_chart.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:tuple/tuple.dart';

class CustomScrollOnboarding extends StatefulWidget {
  @override
  _CustomScrollOnboardingState createState() => _CustomScrollOnboardingState();
}

class _CustomScrollOnboardingState extends State<CustomScrollOnboarding> {
  int _focusedIndex = -1;
  late double cardSize;
  double heightFromTop = 0;
  late double listViewTopPadding;
  late double deviceHeight;
  late double deviceWidth;
  late double marginFromTop;
  late double cardIconSize;
  late double backgroundImageHeight;

  @override
  void initState() {
    super.initState();
  }

  void _onItemFocus(int index) {
    setState(() {
      _focusedIndex = index;
    });
  }

  Widget _buildBackgroundItem(BuildContext context, int index) {
    if (index == 0) {
      return Container(
        width: cardSize,
        child: Image.asset(
          "assets/images/page_1.png",
        ),
      );
    } else if (index == 1) {
      return Container(
        width: cardSize,
        child: Image.asset(
          "assets/images/page_2.png",
        ),
      );
    } else {
      return Container(
        width: cardSize,
        child: Image.asset(
          "assets/images/page_3.png",
        ),
      );
    }
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
    if (index == 0) {
      return Container(
        padding: EdgeInsets.only(
            top: listViewTopPadding * 1.6, bottom: listViewTopPadding / 2),
        width: cardSize,
        child: Container(
            padding:
                EdgeInsets.only(top: marginFromTop, bottom: marginFromTop * 2),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
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
                      chartRadius: deviceHeight * 0.16,
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
            top: listViewTopPadding * 1.6, bottom: listViewTopPadding / 2),
        width: cardSize,
        alignment: Alignment.center,
        child: Container(
            padding:
                EdgeInsets.only(top: marginFromTop, bottom: marginFromTop * 2),
            child: Card(
              elevation: 4,
              shadowColor: Colors.grey,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 1.2,
                    margin: EdgeInsets.all(10),
                    height: deviceHeight * 0.249,
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
                                    width:
                                        MediaQuery.of(context).size.width / 1.4,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 120,
                                          height: 13,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(3),
                                              color: Color(0xFFEEEEEE)),
                                        ),
                                        Container(
                                            width: 75,
                                            height: 17,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(3),
                                                color: Color(0xFFEEEEEE)))
                                      ],
                                    ),
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
                                    width:
                                        MediaQuery.of(context).size.width / 1.4,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 80,
                                          height: 13,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(3),
                                              color: Color(0xFFEEEEEE)),
                                        ),
                                        Container(
                                            width: 40,
                                            height: 17,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(3),
                                                color: Color(0xFFEEEEEE)))
                                      ],
                                    ),
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
                                    width:
                                        MediaQuery.of(context).size.width / 1.4,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 90,
                                          height: 13,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(3),
                                              color: Color(0xFFEEEEEE)),
                                        ),
                                        Container(
                                            width: 75,
                                            height: 17,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(3),
                                                color: Color(0xFFEEEEEE)))
                                      ],
                                    ),
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
                                    width:
                                        MediaQuery.of(context).size.width / 1.4,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 60,
                                          height: 13,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(3),
                                              color: Color(0xFFEEEEEE)),
                                        ),
                                        Container(
                                            width: 50,
                                            height: 17,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(3),
                                                color: Color(0xFFEEEEEE)))
                                      ],
                                    ),
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
          padding: EdgeInsets.only(
              top: (listViewTopPadding * 1.5), bottom: marginFromTop * 2),
          width: cardSize,
          child: Container(
              child: Container(
            padding: EdgeInsets.only(
                left: deviceWidth * 0.09, right: deviceWidth * 0.08),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                          width: cardIconSize,
                          height: cardIconSize,
                          child: Icon(
                            Icons.school_rounded,
                            size: cardIconSize / 2,
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
                          width: cardIconSize,
                          height: cardIconSize,
                          child: Icon(
                            Icons.movie_creation_rounded,
                            size: cardIconSize / 2,
                            color: Color(0xFFFFC107),
                          )),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      elevation: 4,
                      shadowColor: Colors.grey,
                      child: Container(
                          width: cardIconSize,
                          height: cardIconSize,
                          child: Icon(
                            Icons.restaurant,
                            size: cardIconSize / 2,
                            color: Color(0xFFCDDC39),
                          )),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      elevation: 4,
                      shadowColor: Colors.grey,
                      child: Container(
                          width: cardIconSize,
                          height: cardIconSize,
                          child: Icon(
                            Icons.medical_services,
                            size: cardIconSize / 2,
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
                          width: cardIconSize,
                          height: cardIconSize,
                          child: Icon(
                            Icons.shopping_basket,
                            size: cardIconSize / 2,
                            color: Color(0xFF00BCD4),
                          )),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      elevation: 4,
                      shadowColor: Colors.grey,
                      child: Container(
                          width: cardIconSize,
                          height: cardIconSize,
                          child: Icon(
                            Icons.more_rounded,
                            size: cardIconSize / 2,
                            color: Color(0xFFE91E63),
                          )),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      elevation: 4,
                      shadowColor: Colors.grey,
                      child: Container(
                          width: cardIconSize,
                          height: cardIconSize,
                          child: Icon(
                            Icons.train,
                            size: cardIconSize / 2,
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
                          width: cardIconSize,
                          height: cardIconSize,
                          child: Icon(
                            Icons.local_cafe,
                            size: cardIconSize / 2,
                            color: Color(0xFF795548),
                          )),
                    ),
                  ],
                )
              ],
            ),
          )));
    }
    //horizontal
  }

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;

    marginFromTop = deviceHeight * 0.1079;
    listViewTopPadding = deviceHeight * 0.0929;
    cardIconSize = deviceHeight * 0.1;
    cardSize = deviceWidth * 0.89;
    backgroundImageHeight = deviceHeight * 0.6;

    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  child: Text(_focusedIndex == 2 ? "Next" : "Skip"),
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
                  textItemBuilder: _buildTextItem,
                  backgroundItemBuilder: _buildBackgroundItem,
                  itemCount: 3,
                  backgroundImgHeight: backgroundImageHeight,
                  dynamicItemSize: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
