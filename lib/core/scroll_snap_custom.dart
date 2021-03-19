import 'dart:math';

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'custom_scroll_physics.dart';

///Anchor location for selected item in the list
enum SelectedItemAnchor { START, MIDDLE, END }

///A ListView widget that able to "snap" or focus to an item whenever user scrolls.
///
///Allows unrestricted scroll speed. Snap/focus event done on every `ScrollEndNotification`.
///
///Contains `ScrollNotification` widget, so might be incompatible with other scroll notification.
class ScrollSnapPageCustom extends StatefulWidget {
  ///List background
  final Color background;

  final List<Widget> Function(BuildContext, int) listBuilder;

  ///Widget builder.
  final Widget Function(BuildContext, int) itemBuilder;

  final Widget Function(BuildContext, int) textItemBuilder;

  ///Animation curve
  final Curve curve;

  ///Animation duration in milliseconds (ms)
  final int duration;

  ///Pixel tolerance to trigger onReachEnd.
  ///Default is itemSize/2
  final double endOfListTolerance;

  ///Focus to an item when user tap on it. Inactive if the list-item have its own onTap detector (use state-key to help focusing instead).
  final bool focusOnItemTap;

  ///Method to manually trigger focus to an item. Call with help of `GlobalKey<ScrollSnapListState>`.
  final void Function(int) focusToItem;

  ///Container's margin
  final EdgeInsetsGeometry margin;

  ///Number of item in this list
  final int itemCount;

  ///Composed of the size of each item + its margin/padding.
  ///Size used is width if `scrollDirection` is `Axis.horizontal`, height if `Axis.vertical`.
  ///
  ///Example:
  ///- Horizontal list
  ///- Card with `width` 100
  ///- Margin is `EdgeInsets.symmetric(horizontal: 5)`
  ///- itemSize is `100+5+5 = 110`
  final double itemSize;

  ///Global key that's used to call `focusToItem` method to manually trigger focus event.
  final Key key;

  ///Global key that passed to child ListView. Can be used for PageStorageKey
  final Key listViewKey;

  ///Callback function when list snaps/focuses to an item
  final void Function(int) onItemFocus;

  ///Callback function when user reach end of list.
  ///
  ///Can be used to load more data from database.
  final Function onReachEnd;

  ///Container's padding
  final EdgeInsetsGeometry padding;

  ///Reverse scrollDirection
  final bool reverse;

  ///Calls onItemFocus (if it exists) when ScrollUpdateNotification fires
  final bool updateOnScroll;

  ///An optional initial position which will not snap until after the first drag
  final double initialIndex;

  ///ListView's scrollDirection
  final Axis scrollDirection;

  ///Allows external controller
  final ScrollController listController;

  final PageController pageController;

  ///Scale item's size depending on distance to center
  final bool dynamicItemSize;

  ///Custom equation to determine dynamic item scaling calculation
  ///
  ///Input parameter is distance between item position and center of ScrollSnapList (Negative for left side, positive for right side)
  ///
  ///Output value is scale size (must be >=0, 1 is normal-size)
  ///
  ///Need to set `dynamicItemSize` to `true`
  final double Function(double distance) dynamicSizeEquation;

  ///Custom Opacity of items off center
  final double dynamicItemOpacity;

  ///Anchor location for selected item in the list
  final SelectedItemAnchor selectedItemAnchor;

  ScrollSnapPageCustom(
      {this.background,
      @required this.itemBuilder,
      @required this.listBuilder,
      @required this.textItemBuilder,
      ScrollController listController,
      PageController pageController,
      this.curve = Curves.ease,
      this.duration = 500,
      this.endOfListTolerance,
      this.focusOnItemTap = true,
      this.focusToItem,
      this.itemCount,
      @required this.itemSize,
      this.key,
      this.listViewKey,
      this.margin,
      @required this.onItemFocus,
      this.onReachEnd,
      this.padding,
      this.reverse = false,
      this.updateOnScroll,
      this.initialIndex,
      this.scrollDirection = Axis.horizontal,
      this.dynamicItemSize = false,
      this.dynamicSizeEquation,
      this.dynamicItemOpacity,
      this.selectedItemAnchor = SelectedItemAnchor.MIDDLE})
      : listController = listController ?? ScrollController(),
        pageController = PageController(viewportFraction: 0.9),
        super(key: key);

  @override
  ScrollSnapPageCustomState createState() => ScrollSnapPageCustomState();
}

class ScrollSnapPageCustomState extends State<ScrollSnapPageCustom> {
  //true if initialIndex exists and first drag hasn't occurred
  bool isInit = true;
  //to avoid multiple onItemFocus when using updateOnScroll
  int previousIndex = -1;
  //Current scroll-position in pixel
  double currentPixel = 0;

  bool isCardMovable = true;

  PageController secondPageController;

  void initState() {
    super.initState();
    secondPageController = new PageController(viewportFraction: 0.9);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.initialIndex != null) {
        //set list's initial position
        focusToInitialPosition();
      } else {
        isInit = false;
      }
    });

    ///After initial jump, set isInit to false
    Future.delayed(Duration(milliseconds: 10), () {
      if (this.mounted) {
        setState(() {
          isInit = false;
        });
      }
    });
  }

  void _animateScroll(double location) {
    isCardMovable = false;
    int page = 0;
    if (location >= 0 && location < widget.itemSize) {
      page = 0;
    } else if (location >= widget.itemSize &&
        location <= (widget.itemSize * 2) - 2) {
      page = 1;
    } else {
      page = 2;
    }

    Future.delayed(Duration.zero, () {
      secondPageController
          .animateToPage(page,
              duration: Duration(milliseconds: 400), curve: widget.curve)
          .then((value) {
        Future.delayed(Duration(milliseconds: 100), () {
          isCardMovable = true;
        });
      });
    });
  }

  double calculateScale(int index) {
    double intendedPixel = index * widget.itemSize;
    double difference = intendedPixel - currentPixel;

    if (widget.dynamicSizeEquation != null) {
      double scale = widget.dynamicSizeEquation(difference);
      return scale < 0 ? 0 : scale;
    }
    return 1 - min(difference.abs() / widget.itemSize * 0.5, 0.5);
  }

  double calculateOpacity(int index) {
    double intendedPixel = index * widget.itemSize;
    double difference = intendedPixel - currentPixel;

    return (difference == 0) ? 1.0 : widget.dynamicItemOpacity ?? 1.0;
  }

  Alignment calculateAlignment(int index) {
    if (index == 0) {
      return Alignment(1.6, -1.7);
    } else if (index == 1) {
      double dx = 0;
      if (dx >= 0 || dx <= 2.4) {
        dx = currentPixel / (15.83 * 15);
      } else {
        dx = dx;
      }
      return Alignment(-1.6 + dx, -1.7);
    } else {
      double intendedPixel = index * widget.itemSize;
      double dx = intendedPixel * 0.0002;
      return Alignment(-1.9 + dx, -1.75);
    }
  }

  Offset calculateOffset(int index) {
    if (index == 0) {
      double dx = currentPixel;
      return Offset(-dx, 0.0);
    } else if (index == 1) {
      double dx = currentPixel / 2;
      return Offset(-dx * 2, 0.0);
    } else {
      double dx = currentPixel / 2;
      return Offset(-dx * 2, 0.0);
    }
  }

  Widget _buildListItem(BuildContext context, int index) {
    Widget child;
    if (widget.dynamicItemSize) {
      child = Transform.scale(
        scale: calculateScale(index),
        alignment: calculateAlignment(index),
        child: widget.itemBuilder(context, index),
      );
    } else {
      child = widget.itemBuilder(context, index);
    }

    if (widget.dynamicItemOpacity != null) {
      child = Opacity(child: child, opacity: calculateOpacity(index));
    }

    if (widget.focusOnItemTap)
      return GestureDetector(
        onTap: () => focusToItem(index),
        child: child,
      );
    return child;
  }

  Widget _buildTextItem(BuildContext context, int index) {
    Widget child;
    child = widget.textItemBuilder(context, index);
    return child;
  }

  ///Then trigger `onItemFocus`
  double _calcCardLocation(
      {double pixel, @required double itemSize, int index}) {
    int cardIndex =
        index != null ? index : ((pixel - itemSize / 2) / itemSize).ceil();

    if (widget.onItemFocus != null && cardIndex != previousIndex) {
      previousIndex = cardIndex;
      widget.onItemFocus(cardIndex);
    }
    return (cardIndex * itemSize);
  }

  void focusToItem(int index) {
    double targetLoc =
        _calcCardLocation(index: index, itemSize: widget.itemSize);
    _animateScroll(targetLoc);
  }

  void focusToInitialPosition() {
    widget.listController.jumpTo((widget.initialIndex * widget.itemSize));
  }

  void _onReachEnd() {
    if (widget.onReachEnd != null) widget.onReachEnd();
  }

  @override
  void dispose() {
    widget.listController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.padding,
      margin: widget.margin,
      child: LayoutBuilder(
        builder: (BuildContext ctx, BoxConstraints constraint) {
          double _listPadding = 0;

          //determine anchor
          switch (widget.selectedItemAnchor) {
            case SelectedItemAnchor.START:
              _listPadding = 0;
              break;
            case SelectedItemAnchor.MIDDLE:
              _listPadding = (widget.scrollDirection == Axis.horizontal
                          ? constraint.maxWidth
                          : constraint.maxHeight) /
                      2 -
                  widget.itemSize / 2;
              break;
            case SelectedItemAnchor.END:
              _listPadding = (widget.scrollDirection == Axis.horizontal
                      ? constraint.maxWidth
                      : constraint.maxHeight) -
                  widget.itemSize;
              break;
          }

          return GestureDetector(
            //by catching onTapDown gesture, it's possible to keep animateTo from removing user's scroll listener
            onTapDown: (_) {},
            child: NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification scrollInfo) {
                  if (scrollInfo is ScrollEndNotification && isCardMovable) {
                    // dont snap until after first drag
                    if (isInit) {
                      return true;
                    }

                    double tolerance =
                        widget.endOfListTolerance ?? (widget.itemSize / 2);
                    if (scrollInfo.metrics.pixels >=
                        scrollInfo.metrics.maxScrollExtent - tolerance) {
                      _onReachEnd();
                    }

                    double offset = _calcCardLocation(
                      pixel: scrollInfo.metrics.pixels,
                      itemSize: widget.itemSize,
                    );
                    if ((scrollInfo.metrics.pixels - offset).abs() > 0.01 ||
                        offset == 0) {
                      _animateScroll(offset);
                    }
                  } else if (scrollInfo is ScrollUpdateNotification &&
                      isCardMovable) {
                    if (widget.dynamicItemSize ||
                        widget.dynamicItemOpacity != null) {
                      setState(() {
                        currentPixel = scrollInfo.metrics.pixels;
                      });
                    }

                    if (widget.updateOnScroll == true) {
                      if (isInit) {
                        return true;
                      }

                      if (widget.onItemFocus != null && isInit == false) {
                        _calcCardLocation(
                          pixel: scrollInfo.metrics.pixels,
                          itemSize: widget.itemSize,
                        );
                      }
                    }
                  }
                  return true;
                },
                child: Column(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Container(
                        color: Colors.transparent,
                      ),
                    ),
                    Expanded(
                        child: PageView.builder(
                          key: widget.listViewKey,
                          physics: CustomScrollPhysics(),
                          clipBehavior: Clip.antiAlias,
                          controller: widget.pageController,
                          reverse: widget.reverse,
                          scrollDirection: widget.scrollDirection,
                          itemBuilder: _buildListItem,
                          itemCount: widget.itemCount,
                        ),
                        flex: 65),
                    Expanded(
                      flex: 5,
                      child: Container(),
                    ),
                    Expanded(
                        flex: 20,
                        child: PageView.builder(
                          itemBuilder: _buildTextItem,
                          controller: secondPageController,
                          itemCount: widget.itemCount,
                          key: widget.listViewKey,
                          scrollDirection: Axis.horizontal,
                        )),
                    Expanded(
                      flex: 5,
                      child: SmoothPageIndicator(
                        controller: widget.pageController,
                        count: widget.itemCount,
                        effect: WormEffect(
                            dotColor: Color(0xFFEEEEEE),
                            activeDotColor: Color(0xFF2196F3)),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Container(
                        color: Colors.transparent,
                      ),
                    )
                  ],
                )),
          );
        },
      ),
    );
  }
}
