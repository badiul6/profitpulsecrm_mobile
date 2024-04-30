import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:profitpulsecrm_mobile/app/modules/signup/controllers/signup_controller.dart';
import 'package:profitpulsecrm_mobile/app/routes/app_pages.dart';

class VerifyView extends GetView<SignupController> {
  final String name;
  final String email;

  const VerifyView({super.key, required this.name, required this.email});
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenHeight = mediaQueryData.size.height;
    double screenWidth = mediaQueryData.size.width;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        Align(
            alignment: Alignment.topRight,
            child: Text(
              'Step ${controller.pageNo.value.toString()} of 2',
              style: TextStyle(color: colorScheme.primary),
            )),
        SizedBox(
          height: screenHeight * 0.05,
        ),
        Text('Hi $name, please confirm your email'),
        SvgPicture.asset(
          'assets/images/verify.svg',
          height: screenHeight * 0.27,
        ),
        const Text("We've sent an email to"),
        Text(email),
        SizedBox(
          height: screenHeight * 0.012,
        ),
        Text(
          'Click the link in the email to confirm your address and start growing with ProfitPulse today',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12, color: colorScheme.secondary),
        ),
        SizedBox(
          height: screenHeight * 0.025,
        ),
        ElevatedButton(
            onPressed: () async {
              await LaunchApp.openApp(
                  androidPackageName: 'com.google.android.gm');
            },
            style: ElevatedButton.styleFrom(
                minimumSize: Size(screenWidth * 0.02, screenHeight * 0.04),
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.023),
                // backgroundColor: colorScheme.onSecondary
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5))),
            child: const Text('Open your email')),
        SizedBox(
          height: screenHeight * 0.018,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Have you verified? '),
            TextButton(
                onPressed: () {
                  Get.offNamed(Routes.LOGIN);
                },
                style: TextButton.styleFrom(padding: EdgeInsets.zero),
                child: const Text('Login to continue'))
          ],
        ),
        Text(
          'Your information is safe and secured in ProfitPulse',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12, color: colorScheme.secondary),
        ),
      ],
    );
  }
}
