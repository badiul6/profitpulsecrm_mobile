import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:profitpulsecrm_mobile/app/modules/login/controllers/login_controller.dart';
import 'package:profitpulsecrm_mobile/app/routes/app_pages.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenHeight = mediaQueryData.size.height;
    double screenWidth = mediaQueryData.size.width;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
                child: Center(
          child: Padding(
            padding: EdgeInsets.only(
                top: screenHeight * 0.05,
                right: screenWidth * 0.04,
                left: screenWidth * 0.04),
            child: Form(
              key: controller.formKey,
              child: Column(
                children: [
                  const Text('ProfitPulse', style: TextStyle(fontSize: 36)),
                  SizedBox(
                    height: screenHeight * 0.05,
                  ),
                  TextFormField(
                    controller: controller.emailController,
                    validator: controller.validateEmail,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email Address',
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.019,
                  ),
                  Obx(
                    () => TextFormField(
                      controller: controller.passwordController,
                      validator: controller.validatePassword,
                      obscureText:
                          controller.isPasswordVisible.value ? false : true,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: 'Password',
                        suffixIcon: IconButton(
                            onPressed: () {
                              controller.isPasswordVisible.value =
                                  !controller.isPasswordVisible.value;
                            },
                            icon: controller.isPasswordVisible.value
                                ? Icon(
                                    Icons.visibility_off,
                                    color: colorScheme.primary,
                                  )
                                : Icon(
                                    Icons.visibility,
                                    color: colorScheme.primary,
                                  )),
                      ),
                    ),
                  ),
          
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        'Forgot your password?',
                        style: TextStyle(color: colorScheme.primary),
                      )),
                  SizedBox(
                    height: screenHeight * 0.04,
                  ),
          
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          foregroundColor: colorScheme.background,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          minimumSize: Size(
                            double.infinity,
                            screenHeight * 0.07,
                          )),
                      onPressed: () {
                        if (controller.formKey.currentState!.validate()) {}

                        Get.toNamed(Routes.PROFILE);
                      },
                      child: const Text('Log in')),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
          
                   Row(
                    children: [
                      const Expanded(child: Divider()),
                      SizedBox(
                        width: screenWidth * 0.03,
                      ),
                      const Text('Or'),
                      SizedBox(
                        width: screenWidth * 0.03,
                      ),
                      const Expanded(child: Divider())
                    ],
                  ),
                  
                  // const Spacer(),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    const Text("Don't you have an account? "),
                    TextButton(
                        onPressed: () {
                          Get.offNamed(Routes.SIGNUP);
                        },
                        style: TextButton.styleFrom(padding: EdgeInsets.zero),
                        child: const Text('Sign up now'))
                  ])
                ],
              ),
            ),
          ),
                ),
              ),
        ));
  }
}
