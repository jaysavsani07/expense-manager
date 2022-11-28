import 'dart:math';

import 'package:expense_manager/core/routes.dart';
import 'package:expense_manager/core/app_localization.dart';
import 'package:expense_manager/ui/app/app_state.dart';
import 'package:expense_manager/ui/dashboard/dashboard_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:tuple/tuple.dart';
import 'package:expense_manager/core/color_scheme.dart';

class CategoryChartView extends ConsumerWidget {
  const CategoryChartView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(categoryPieChartVisibilityProvider.state);
    return Visibility(
      visible: !vm.state,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 24, top: 30, bottom: 20),
            child: Text(
              AppLocalization.of(context).getTranslatedVal("total_expense"),
              style: Theme.of(context)
                  .textTheme
                  .subtitle2
                  .copyWith(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const CategoryPieChartView(),
        ],
      ),
    );
  }
}

class CategoryPieChartView extends ConsumerWidget {
  const CategoryPieChartView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(categoryPieChartProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, AppRoutes.categoryDetails);
        },
        borderRadius: BorderRadius.circular(6),
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                vm.isEmpty
                    ? SizedBox()
                    : Expanded(
                        child: SizedBox(
                        height: 140,
                        width: 140,
                        child: PieChartView(),
                      )),
                SizedBox(width: 24),
                CategoryPieChatListView()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CategoryPieChatListView extends ConsumerWidget {
  const CategoryPieChatListView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(categoryPieChartListProvider);
    return Expanded(
      child: SizedBox(
          height: 140,
          child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            children: vm
                .map((list) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.circle,
                            size: 10,
                            color: list.iconColor,
                          ),
                          SizedBox(width: 4),
                          Text(
                            list.name,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                .copyWith(overflow: TextOverflow.ellipsis),
                          ),
                        ],
                      ),
                    ))
                .toList(),
          )),
    );
  }
}

class TotalAmount extends ConsumerWidget {
  const TotalAmount({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final totalExpense = ref.watch(totalExpenseProvider);
    String currency = ref.watch(appStateNotifier).currency.item1;
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppLocalization.of(context).getTranslatedVal("last_month"),
          style: Theme.of(context).textTheme.caption.copyWith(fontSize: 10),
        ),
        FittedBox(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              "${NumberFormat.simpleCurrency(locale: currency, decimalDigits: 0).format(totalExpense)}",
              style: Theme.of(context)
                  .textTheme
                  .subtitle2
                  .copyWith(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
        )
      ],
    );
  }
}

class PieChartView extends ConsumerWidget {
  const PieChartView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(categoryPieChartProvider);

    return LayoutBuilder(
      builder: (context, constraint) => Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.paiChartColor,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              spreadRadius: -10,
              blurRadius: 20,
              offset: Offset(-8, -8),
              color: Theme.of(context).colorScheme.paiChartShadowLightColor.withOpacity(0.1),
            ),
            BoxShadow(
              // spreadRadius: -2,
              blurRadius: 20,
              offset: Offset(8, 8),
              color: Theme.of(context).colorScheme.paiChartShadowDarkColor.withOpacity(0.4),
            )
          ],
        ),
        child: Stack(
          children: [
            Center(
              child: SizedBox(
                width: constraint.maxWidth * 0.6,
                child: CustomPaint(
                  child: Center(),
                  foregroundPainter: PieChart1(
                    width: constraint.maxWidth * 0.5,
                    categories:
                        vm.map((e) => Tuple2(e.value, e.color)).toList(),
                  ),
                ),
              ),
            ),
            Center(
              child: Container(
                height: constraint.maxWidth * 0.4,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.paiChartColor,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      spreadRadius: -10,
                      blurRadius: 20,
                      offset: Offset(-8, -8),
                      color: Theme.of(context).colorScheme.paiChartShadowLightColor.withOpacity(0.1),
                    ),
                    BoxShadow(
                      // spreadRadius: -2,
                      blurRadius: 20,
                      offset: Offset(8, 8),
                      color: Theme.of(context).colorScheme.paiChartShadowDarkColor.withOpacity(0.4),
                    )
                  ],
                ),
                child: SizedBox(
                  width: constraint.maxWidth * 0.4,
                    child: TotalAmount()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PieChart1 extends CustomPainter {
  PieChart1({@required this.categories, @required this.width});

  final List<Tuple2<double, Color>> categories;
  final double width;

  @override
  void paint(Canvas canvas, Size size) {
    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2);

    var paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = width / 2;

    double total = 0;
    // Calculate total amount from each category
    categories.forEach((expense) => total += expense.item1);

    // The angle/radian at 12 o'clcok
    double startRadian = -pi / 2;

    for (var index = 0; index < categories.length; index++) {
      final currentCategory = categories.elementAt(index);
      // Amount of length to paint is a percentage of the perimeter of a circle (2 x pi)
      final sweepRadian = currentCategory.item1 / total * 2 * pi;
      // Used modulo/remainder to catch use case if there is more than 6 colours
      paint.color = categories.elementAt(index).item2;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startRadian,
        sweepRadian,
        false,
        paint,
      );
      // The new startRadian starts from where the previous sweepRadian.
      // Example, a circle perimeter is 10.
      // Category A takes a startRadian 0 and ends at sweepRadian 5.
      // Category B takes the startRadian where Category A left off, which is 5
      // and ends at sweepRadian 7.
      // Category C takes the startRadian where Category B left off, which is 7
      // and so on.
      startRadian += sweepRadian;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
