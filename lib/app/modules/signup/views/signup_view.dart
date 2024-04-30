import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:profitpulsecrm_mobile/app/modules/signup/views/verify_view.dart';
import 'package:profitpulsecrm_mobile/app/routes/app_pages.dart';

import '../controllers/signup_controller.dart';

class SignupView extends GetView<SignupController> {
  const SignupView({super.key});
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenHeight = mediaQueryData.size.height;
    double screenWidth = mediaQueryData.size.width;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      body:   SingleChildScrollView(
        child: SafeArea(
        child: Center(
          child: Obx(() => 
          Padding(
            padding: EdgeInsets.only(
                top: screenHeight * 0.002,
                right: screenWidth * 0.03,
                left: screenWidth * 0.03),
            child: controller.pageNo.value==1 ? Form(
              key: controller.formKey,
              child: Column(
                children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        'Step ${controller.pageNo.value.toString()} of 2',
                        style: TextStyle(color: colorScheme.primary),
                      )),

                      SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  const Text('ProfitPulse', style: TextStyle(fontSize: 36)),
                  SizedBox(
                    height: screenHeight * 0.05,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: TextFormField(
                                            controller: controller.firstNameController,
                                            validator: controller.validateFullname,
                                            decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'First Name',
                                            ),
                                          ),
                      ),
                       SizedBox(
                    width: screenWidth * 0.015,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: controller.lastNameController,
                      validator: controller.validateFullname,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Last Name',
                      ),
                    ),
                  ),
                    ],
                  ),
                  SizedBox(
                    height: screenHeight * 0.019,
                  ),
                  TextFormField(
                    controller: controller.emailController,
                    validator: controller.validateEmail,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email address',
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.019,
                  ),
                  // Obx(
                  //   () => 
                    TextFormField(
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
                  // ),
                  SizedBox(
                    height: screenHeight * 0.019,
                  ),
                  // Obx(
                  //   () => 
                    TextFormField(
                      controller: controller.rePasswordController,
                      validator: controller.validatePassword,
                      obscureText:
                          controller.isRePasswordVisible.value ? false : true,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: 'Reenter pasword',
                        suffixIcon: IconButton(
                            onPressed: () {
                              controller.isRePasswordVisible.value =
                                  !controller.isRePasswordVisible.value;
                            },
                            icon: controller.isRePasswordVisible.value
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
                  // ),
        
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  
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
                        // if (controller.formKey.currentState!.validate()) {
                          controller.updatePage(2);
                        // }
                      },
                      child: const Text('Sign up')),
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
                    const Text("Already have an account?"),
                    TextButton(
                        onPressed: () {
                          Get.offNamed(Routes.LOGIN);
                        },
                        style: TextButton.styleFrom(padding: EdgeInsets.zero),
                        child: const Text('Log in'))
                  ])
                ],
              ),
            ):VerifyView(name: 'Badiul',email: 'badiuljamal3208@gmail.com')
          )),
        ),
            ),
      )
    );
  }
}
