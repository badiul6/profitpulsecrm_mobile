import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

class SaleView extends GetView {
  const SaleView({super.key});
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
    return SingleChildScrollView(
      child: Column(
        children: [
          SvgPicture.asset(
            'assets/images/sales.svg',
              height: screenHeight*0.3,

          ),
          SizedBox(height: screenHeight * 0.017),
          const Text('Sales', style: TextStyle(fontSize: 26)),
          SizedBox(height: screenHeight * 0.01),
          SizedBox(
            width: screenWidth * 0.9,
            child: const Text(
              'Identify potential leads and manage deals efficiently. Gain visibility into your pipeline, and keeps contacts organized so you can close more deals with less work.',
              style: TextStyle(
                fontSize: 13,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
