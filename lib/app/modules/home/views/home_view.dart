import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profitpulsecrm_mobile/app/modules/home/views/cs_view.dart';
import 'package:profitpulsecrm_mobile/app/modules/home/views/landing_view.dart';
import 'package:profitpulsecrm_mobile/app/modules/home/views/marketing_view.dart';
import 'package:profitpulsecrm_mobile/app/modules/home/views/sale_view.dart';
import 'package:profitpulsecrm_mobile/app/routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
        body: SafeArea(
            child: Center(
      child: Padding(
        padding: EdgeInsets.only(
            top: screenHeight * 0.04,
            bottom: screenHeight * 0.01,
            left: screenWidth * 0.03,
            right: screenWidth * 0.03),
        child: Column(
          children: <Widget>[
            const Text('ProfitPulse', style: TextStyle(fontSize: 36)),
            SizedBox(height: screenHeight * 0.017),
            Expanded(
              child: PageView(
                controller: controller.pageController,
                onPageChanged: controller.handlePageViewChanged,
                children: const [
                  LandingView(),
                  MarketingView(),
                  SaleView(),
                  CsView()
                ],
              ),
            ),
            PageIndicator(
              tabController: controller.tabController,
              currentPageIndex: controller.currentPageIndex,
              onUpdateCurrentPageIndex: controller.updateCurrentPageIndex,
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: OutlinedButton(
                      onPressed: () {
                        Get.toNamed(Routes.LOGIN);
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: colorScheme.primary,
                        minimumSize: Size(double.infinity,
                            screenHeight * 0.055), // Set height here
                        side: BorderSide(color: colorScheme.primary),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                      ),
                      child: const Text(
                        'Login',
                        style: TextStyle(fontSize: 20),
                      )),
                ),
                SizedBox(
                  width: screenWidth * 0.01,
                ),
                Expanded(
                  child: ElevatedButton(
                      onPressed: () {
                        Get.toNamed(Routes.SIGNUP);
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: colorScheme.background,
                        backgroundColor: colorScheme.primary,
                        minimumSize: Size(double.infinity,
                            screenHeight * 0.055), // Set height here
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                      ),
                      child: const Text(
                        'Signup',
                        style: TextStyle(fontSize: 20),
                      )),
                )
              ],
            )
          ],
        ),
      ),
    )));
  }
}

class PageIndicator extends StatelessWidget {
  const PageIndicator({
    super.key,
    required this.tabController,
    required this.currentPageIndex,
    required this.onUpdateCurrentPageIndex,
  });

  final int currentPageIndex;
  final TabController tabController;
  final void Function(int) onUpdateCurrentPageIndex;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TabPageSelector(
          indicatorSize: 9,
          controller: tabController,
          color: colorScheme.background,
          selectedColor: colorScheme.primary,
        ),
      ],
    );
  }
}
