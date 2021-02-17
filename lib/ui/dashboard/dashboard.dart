import 'package:expense_manager/data/language/app_localization.dart';
import 'package:expense_manager/core/routes.dart';
import 'package:expense_manager/ui/dashboard/category_list_view.dart';
import 'package:expense_manager/ui/dashboard/category_pie_chart_view.dart';
import 'package:expense_manager/ui/dashboard/dashboard_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:velocity_x/velocity_x.dart';

class Dashboard extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return ProviderListener<DashboardViewModel>(
        provider: categoryListProvider,
        onChange: (context, model) async {},
        child: SafeArea(
          top: true,
          child: Scaffold(
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppLocalization.of(context)
                        .getTranslatedVal("home_title")
                        .text
                        .xl2
                        .make()
                        .pOnly(left: 8),
                    AppLocalization.of(context)
                        .getTranslatedVal("home_title")
                        .text
                        .xl2
                        .make()
                        .pOnly(left: 8),
                    Icon(Icons.settings_outlined).p16().onInkTap(() {
                      Navigator.pushNamed(context, AppRoutes.setting);
                    })
                  ],
                ),
                const TotalAmount(),
                8.heightBox,
                const TodayAmount(),
                16.heightBox,
                const SmoothPageView(),
              ],
            ),
          ),
        ));
  }
}

class SmoothPageView extends StatefulWidget {
  const SmoothPageView({
    Key key,
  }) : super(key: key);

  @override
  _PageViewState createState() => _PageViewState();
}

class _PageViewState extends State<SmoothPageView> {
  PageController controller;

  @override
  void initState() {
    controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SmoothPageIndicator(
          controller: controller,
          count: 2,
          effect: JumpingDotEffect(
            activeDotColor: Vx.black,
            dotHeight: 8,
            dotWidth: 8,
          ),
        ),
        PageView(
          scrollDirection: Axis.horizontal,
          controller: controller,
          children: [
            const CategoryPieChartView(),
            const CategoryListView(),
          ],
        ).expand()
      ],
    ).expand();
  }
}

class TotalAmount extends ConsumerWidget {
  const TotalAmount({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final totalAmount = watch(totalAmountProvider);
    return "${NumberFormat.simpleCurrency().currencySymbol}${totalAmount.toString().replaceAll(RegExp(r"([.]*0)(?!.*\d)"), "")}"
        .text
        .bold
        .xl5
        .make()
        .pSymmetric(h: 16);
  }
}

class TodayAmount extends ConsumerWidget {
  const TodayAmount({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final todayAmount = watch(todayAmountProvider);
    return "${NumberFormat.simpleCurrency().currencySymbol}${todayAmount.toString().replaceAll(RegExp(r"([.]*0)(?!.*\d)"), "")} Today"
        .text
        .green500
        .make()
        .pOnly(left: 18);
  }
}
