import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

class MarketingView extends GetView {
  const MarketingView({super.key});
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
    return SingleChildScrollView(
      child: Column(
        children: [
          SvgPicture.asset(
            'assets/images/marketing.svg',
            height: screenHeight*0.3,

          ),
          SizedBox(height: screenHeight * 0.017),
          const Text('Marketing', style: TextStyle(fontSize: 26)),
          SizedBox(height: screenHeight * 0.01),
          SizedBox(
            width: screenWidth * 0.9,
            child: const Text(
              'Learn more about people visiting your site, track emails, spend less time writing emails, manage your facebook ads and email campaigns.',
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
