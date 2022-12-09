import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

import 'chart_painter.dart';

class PieChart extends StatefulWidget {
  PieChart({
    required this.dataMap,
    required this.chartRadius,
    required this.animationDuration,
    this.chartLegendSpacing = 48,
    this.initialAngleInDegree = 0.0,
    required this.centerText,
    this.ringStrokeWidth = 20.0,
    this.emptyColor = Colors.grey,
    Key? key,
  }) : super(key: key);

  final List<Tuple2<double, Color>> dataMap;
  final double chartRadius;
  final Duration animationDuration;
  final double chartLegendSpacing;
  final double initialAngleInDegree;
  final Widget centerText;
  final double ringStrokeWidth;
  final Color emptyColor;

  @override
  _PieChartState createState() => _PieChartState();
}

class _PieChartState extends State<PieChart>
    with SingleTickerProviderStateMixin {
  late final Animation<double> animation;
  late final AnimationController controller;
  double _animFraction = 0.0;

  late List<double> legendValues;
  late List<Color> colorList;

  void initValues() {
    this.legendValues =
        widget.dataMap.map((e) => e.item1).toList(growable: false);
    this.colorList = widget.dataMap.map((e) => e.item2).toList(growable: false);
  }

  void initData() {
    assert(
      widget.dataMap != null && widget.dataMap.isNotEmpty,
      "dataMap passed to pie chart cant be null or empty",
    );
    initValues();
  }

  @override
  void initState() {
    super.initState();
    initData();
    controller = AnimationController(
      duration: widget.animationDuration ?? Duration(milliseconds: 800),
      vsync: this,
    );
    final Animation curve = CurvedAnimation(
      parent: controller,
      curve: Curves.decelerate,
    );
    animation =
        Tween<double>(begin: 0, end: 1).animate(curve as Animation<double>)
          ..addListener(() {
            setState(() {
              _animFraction = animation.value;
            });
          });
    controller.forward();
  }

  Widget _getChart() {
    return LayoutBuilder(
      builder: (_, c) => Container(
        height: widget.chartRadius != null
            ? c.maxWidth < widget.chartRadius
                ? c.maxWidth
                : widget.chartRadius
            : null,
        child: CustomPaint(
          painter: PieChartPainter(
            _animFraction,
            colorList,
            values: legendValues,
            initialAngle: widget.initialAngleInDegree,
            strokeWidth: widget.ringStrokeWidth,
            emptyColor: widget.emptyColor,
          ),
          child: Center(child: widget.centerText),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(8.0),
      child: _getChart(),
    );
  }

  @override
  void didUpdateWidget(PieChart oldWidget) {
    initData();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
