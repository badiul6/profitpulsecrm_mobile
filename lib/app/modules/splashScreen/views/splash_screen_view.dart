import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../controllers/splash_screen_controller.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  const SplashScreenView({super.key});
  @override
  Widget build(BuildContext context) {
        final ColorScheme colorScheme = Theme.of(context).colorScheme;
 MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenHeight = mediaQueryData.size.height;
    // double screenWidth = mediaQueryData.size.width;
    return controller.isStart.value?  Scaffold(
      backgroundColor: colorScheme.primary,
      body: Center(child: SvgPicture.asset('assets/images/appIcon.svg',
      height: screenHeight*0.1,
      ))
    ):
     const Center(child:  Column(
            children: [
              Icon(Icons.error, color: Colors.red, size: 35,),
              Text('Oops! Something went wrong!', style: TextStyle(fontSize: 18),),
            ],
          ),);
  }
}
