import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

class CsView extends GetView {
  const CsView({super.key});
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
    return SingleChildScrollView(
      child: Column(
        children: [
          SvgPicture.asset(
            'assets/images/cs.svg',
                        height: screenHeight*0.3,

          ),
          SizedBox(height: screenHeight * 0.017),
          const Text('Customer Service', style: TextStyle(fontSize: 26)),
          SizedBox(height: screenHeight * 0.01),
          SizedBox(
            width: screenWidth * 0.9,
            child: const Text(
              'Enhance engagement with seamless communication. Connect directly via Gmail, swiftly address concerns with ticket tracking, and elevate potential leads, all while delivering exceptional service.',
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
