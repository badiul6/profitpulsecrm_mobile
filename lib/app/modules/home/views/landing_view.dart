import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class LandingView extends GetView {
  const LandingView({super.key});
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
    return Column(
      children: [
        SvgPicture.asset(
          'assets/images/welcome_rocket.svg',
        ),
        SizedBox(height: screenHeight * 0.017),
        const Text('ProfitPulse CRM', style: TextStyle(fontSize: 26)),
        SizedBox(height: screenHeight * 0.01),
        SizedBox(
          width: screenWidth * 0.9,
          child: const Text(
            'Powerful alone. Even better together. Businesses grow faster when they have a complete Growth Stack for Marketing, Sales and Customer Service from ProfitPulse.',
            style: TextStyle(
              fontSize: 13,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
