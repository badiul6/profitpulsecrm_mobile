import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profitpulsecrm_mobile/app/modules/main/controllers/main_controller.dart';

class SagentHomeView extends GetView<MainController> {
  SagentHomeView({super.key});
  final List<Color> colors = [
    const Color.fromRGBO(76, 175, 80, 1),
    const Color.fromARGB(255, 234, 179, 41),
    const Color.fromRGBO(229, 57, 53, 1),
    const Color.fromRGBO(30, 136, 229, 1),
  ];
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenHeight = mediaQueryData.size.height;
    double screenWidth = mediaQueryData.size.width;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final PageController pageController = PageController(viewportFraction: 0.9);
    return RefreshIndicator(
      onRefresh: () async{
        controller.loadSagentData();
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: controller.isError.value? Padding(
          padding: EdgeInsets.only(top: screenHeight*0.38),
          child:  const Center(child:  Column(
            children: [
              Icon(Icons.error, color: Colors.red, size: 35,),
              Text('Oops! Something went wrong!', style: TextStyle(fontSize: 18),),
            ],
          ),)):Padding(
          padding: EdgeInsets.only(
              top: screenHeight * 0.015,
              right: screenWidth * 0.035,
              left: screenWidth * 0.035),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                Icon(
                  Icons.business_center,
                  color: colorScheme.primary,
                  size: 35,
                ),
                const Text('Products',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500))
              ]),
              SizedBox(
                height: screenHeight * 0.015,
              ),
              Obx(() => controller.products.isEmpty
                  ? Text('No products is added',
                      style: TextStyle(
                          fontSize: 16,
                          color: colorScheme.onBackground,
                          fontWeight: FontWeight.w500))
                  : SizedBox(
                      height: screenHeight * 0.225,
                      child: PageView.builder(
                          controller: pageController,
                          itemCount: controller.products.length,
                          itemBuilder: (context, index) {
                            return Transform.scale(
                              scale: 1, // Change based on focus
                              child: productCard(
                                  screenWidth, screenHeight, colorScheme, index),
                            );
                          }))),
              SizedBox(
                height: screenHeight * 0.015,
              ),
              Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                Icon(
                  Icons.handshake,
                  color: colorScheme.primary,
                  size: 35,
                ),
                const Text('My deals',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500))
              ]),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                child: Obx(() => Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Text('Active deals',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: colorScheme.onBackground,
                                    fontWeight: FontWeight.w500)),
                            const Spacer(),
                            Text(
                                controller.agentDeals
                                    .where((element) => element.isActive == true)
                                    .length
                                    .toString(),
                                style: TextStyle(
                                    fontSize: 22,
                                    color: colorScheme.onBackground,
                                    fontWeight: FontWeight.w700)),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Closed deals',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: colorScheme.onBackground,
                                    fontWeight: FontWeight.w500)),
                            const Spacer(),
                            Text(
                                controller.agentDeals
                                    .where((element) =>
                                        element.status == 'COMPLETED')
                                    .length
                                    .toString(),
                                style: TextStyle(
                                    fontSize: 22,
                                    color: colorScheme.onBackground,
                                    fontWeight: FontWeight.w700)),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Cancelled deals',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: colorScheme.onBackground,
                                    fontWeight: FontWeight.w500)),
                            const Spacer(),
                            Text(
                                controller.agentDeals
                                    .where((element) =>
                                        element.status == 'CANCELLED')
                                    .length
                                    .toString(),
                                style: TextStyle(
                                    fontSize: 22,
                                    color: colorScheme.onBackground,
                                    fontWeight: FontWeight.w700)),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Total deals',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: colorScheme.onBackground,
                                    fontWeight: FontWeight.w500)),
                            const Spacer(),
                            Text(controller.agentDeals.length.toString(),
                                style: TextStyle(
                                    fontSize: 22,
                                    color: colorScheme.onBackground,
                                    fontWeight: FontWeight.w700)),
                          ],
                        ),
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget campaignCard(double screenWidth, double screenHeight,
      ColorScheme colorScheme, int index) {
    Color bgColor = colors[index % colors.length];
    return Container(
        padding: EdgeInsets.only(
          left: screenWidth * 0.1,
          right: screenWidth * 0.1,
          top: screenHeight * 0.02,
          bottom: screenHeight * 0.015,
        ),
        margin: EdgeInsets.only(right: screenWidth * 0.03),
        decoration: BoxDecoration(
          boxShadow: [BoxShadow(color: bgColor, blurRadius: 2)],
          color: bgColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(controller.campaigns[index].name,
                style: TextStyle(
                    fontSize: 20,
                    color: colorScheme.background,
                    fontWeight: FontWeight.w700)),
            SizedBox(
              height: screenHeight * 0.015,
            ),
            Row(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(controller.campaigns[index].totalEmailsSent.toString(),
                        style: TextStyle(
                            fontSize: 22,
                            color: colorScheme.background,
                            fontWeight: FontWeight.w700)),
                    Text('Target contacts',
                        style: TextStyle(
                            fontSize: 16,
                            color: colorScheme.background,
                            fontWeight: FontWeight.w500)),
                  ],
                ),
                const Spacer(),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(controller.campaigns[index].clicks.toString(),
                        style: TextStyle(
                            fontSize: 22,
                            color: colorScheme.background,
                            fontWeight: FontWeight.w700)),
                    Text('Clicks',
                        style: TextStyle(
                            fontSize: 16,
                            color: colorScheme.background,
                            fontWeight: FontWeight.w500)),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: screenHeight * 0.01,
            ),
          ],
        ));
  }

  Widget productCard(double screenWidth, double screenHeight,
      ColorScheme colorScheme, int index) {
    return Container(
        padding: EdgeInsets.only(
          left: screenWidth * 0.1,
          right: screenWidth * 0.1,
          top: screenHeight * 0.02,
          bottom: screenHeight * 0.015,
        ),
        margin: EdgeInsets.only(right: screenWidth * 0.03),
        decoration: BoxDecoration(
          boxShadow: [BoxShadow(color: colorScheme.primary, blurRadius: 2)],
          color: colorScheme.primary.withOpacity(0.6),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(controller.products[index].name,
                style: TextStyle(
                    fontSize: 20,
                    color: colorScheme.background,
                    fontWeight: FontWeight.w700)),
            SizedBox(
              height: screenHeight * 0.015,
            ),
            Row(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(controller.products[index].quantity.toString(),
                        style: TextStyle(
                            fontSize: 22,
                            color: colorScheme.background,
                            fontWeight: FontWeight.w700)),
                    Text('Quantity',
                        style: TextStyle(
                            fontSize: 16,
                            color: colorScheme.background,
                            fontWeight: FontWeight.w500)),
                  ],
                ),
                const Spacer(),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(controller.products[index].unitPrice.toString(),
                        style: TextStyle(
                            fontSize: 22,
                            color: colorScheme.background,
                            fontWeight: FontWeight.w700)),
                    Text('Unit price',
                        style: TextStyle(
                            fontSize: 16,
                            color: colorScheme.background,
                            fontWeight: FontWeight.w500)),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: screenHeight * 0.015,
            ),
            Text('Description',
                style: TextStyle(
                    fontSize: 16,
                    color: colorScheme.background,
                    fontWeight: FontWeight.w700)),
            Text(controller.products[index].description ?? 'N/A',
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                maxLines: 1,
                style: TextStyle(
                  fontSize: 14,
                  color: colorScheme.background,
                )),
          ],
        ));
  }
}
