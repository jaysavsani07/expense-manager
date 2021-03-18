import 'dart:math';

import 'package:flutter/material.dart';

const SCALE_FRACTION = 0.7;
const FULL_SCALE = 1.0;
const PAGER_HEIGHT = 200.0;

class LandingView extends StatefulWidget {
  final ScrollController listController = ScrollController();

  @override
  _LandingViewState createState() => _LandingViewState();
}

class _LandingViewState extends State<LandingView> {
  double viewPortFraction = 0.5;
  PageController pageController;
  int currentPage = 2;

  List<Map<String, String>> listOfCharacters = [
    {'image': "lib/images/img_1.png", 'name': "Roy"},
    {'image': "lib/images/img_2.png", 'name': "Moss"},
    {'image': "lib/images/img_3.png", 'name': "Douglas"},
  ];

  double page = 2.0;

  @override
  void initState() {
    pageController = PageController(
        initialPage: currentPage, viewportFraction: viewPortFraction);
    super.initState();
  }

  double _calculateCardLocation(
      {double pixel, @required double itemSize, int index}) {
    int cardIndex =
        index != null ? index : ((pixel - itemSize / 2) / itemSize).ceil();
    // print(cardIndex * itemSize);
    return (cardIndex * itemSize);
  }

  void _snapScroll(double location) {
    Future.delayed(Duration.zero, () {
      widget.listController.animateTo(location,
          duration: new Duration(milliseconds: 500), curve: Curves.ease);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        backgroundColor: Colors.indigo,
        title: Text(
          "Nividata",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 100, bottom: 100),
        child: NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            if (scrollInfo is ScrollEndNotification) {
              double offset = _calculateCardLocation(
                  pixel: scrollInfo.metrics.pixels, itemSize: 350);

              if (offset >= 350) {
                print(offset);
                print((scrollInfo.metrics.pixels - offset).abs());
                _snapScroll(offset);
              }
            } else if (scrollInfo is ScrollUpdateNotification) {}

            return true;
          },
          child: ListView(
            scrollDirection: Axis.horizontal,
            controller: widget.listController,
            shrinkWrap: true,
            children: <Widget>[
              SizedBox(
                width: 30,
              ),
              Container(
                width: 350,
                height: 200,
                color: Colors.green,
              ),
              SizedBox(
                width: 30,
              ),
              Container(
                width: 350,
                height: 200,
                color: Colors.red,
              ),
              SizedBox(
                width: 30,
              ),
              Container(
                width: 350,
                height: 200,
                color: Colors.blue,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget circleOffer(String image, double scale) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        height: PAGER_HEIGHT * scale,
        width: PAGER_HEIGHT * scale,
        child: Card(
          elevation: 4,
          clipBehavior: Clip.antiAlias,
          shape: CircleBorder(
              side: BorderSide(color: Colors.grey.shade200, width: 5)),
          child: Image.asset(
            image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

double _calculateCardLocation() {}
