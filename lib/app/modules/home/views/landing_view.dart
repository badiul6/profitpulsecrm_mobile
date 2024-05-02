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
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        SvgPicture.asset(
          'assets/images/welcome_rocket.svg', // Ensure this SVG handles its own colors or is styled appropriately
        ),
        SizedBox(height: screenHeight * 0.017),
        Text(
          'ProfitPulse CRM',
          style: TextStyle(
            fontSize: 26,
            color: colorScheme.onBackground, // Suitable color for primary text
          )
        ),
        SizedBox(height: screenHeight * 0.01),
        SizedBox(
          width: screenWidth * 0.9,
          child: Text(
            'Powerful alone. Even better together. Businesses grow faster when they have a complete Growth Stack for Marketing, Sales and Customer Service from ProfitPulse.',
            style: TextStyle(
              fontSize: 13,
              color: colorScheme.onBackground, // Ensuring readability on your chosen background
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}