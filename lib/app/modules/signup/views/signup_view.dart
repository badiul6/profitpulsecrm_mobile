import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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

    InputDecoration getDecoration(String labelText) {
      return InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: colorScheme.onSurface.withOpacity(0.3),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: colorScheme.onSurface.withOpacity(0.3),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: colorScheme.primary,
            width: 2.0,
          ),
        ),
        labelText: labelText,
        labelStyle: TextStyle(color: colorScheme.onSurface),
        floatingLabelStyle: TextStyle(color: colorScheme.primary),
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Obx(
              () => Padding(
                padding: EdgeInsets.only(
                    top: screenHeight * 0.002,
                    right: screenWidth * 0.03,
                    left: screenWidth * 0.03),
                child: controller.pageNo.value == 1
                    ? Form(
                        key: controller.formKey,
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.topRight,
                              child: Text(
                                'Step ${controller.pageNo.value.toString()} of 2',
                                style: TextStyle(color: colorScheme.primary),
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.05),
                            SvgPicture.asset(
                              'assets/images/logo.svg', // Ensure this SVG handles its own colors or is styled appropriately
                            ),
                            const Text('Empower Your Business, Join ProfitPulse!'),
                            SizedBox(height: screenHeight * 0.05),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: controller.firstNameController,
                                    validator: controller.validateFullname,
                                    decoration: getDecoration('First Name'),
                                  ),
                                ),
                                SizedBox(width: screenWidth * 0.015),
                                Expanded(
                                  child: TextFormField(
                                    controller: controller.lastNameController,
                                    validator: controller.validateFullname,
                                    decoration: getDecoration('Last Name'),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: screenHeight * 0.029),
                            TextFormField(
                              controller: controller.emailController,
                              validator: controller.validateEmail,
                              decoration: getDecoration('Email Address'),
                            ),
                            SizedBox(height: screenHeight * 0.039),
                            TextFormField(
                              controller: controller.passwordController,
                              validator: controller.validatePassword,
                              obscureText: !controller.isPasswordVisible.value,
                              decoration: getDecoration('Password').copyWith(
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    controller.isPasswordVisible.value =
                                        !controller.isPasswordVisible.value;
                                  },
                                  icon: Icon(
                                    controller.isPasswordVisible.value
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: colorScheme.primary,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.039),
                            TextFormField(
                              controller: controller.rePasswordController,
                              validator: controller.validatePassword,
                              obscureText:
                                  !controller.isRePasswordVisible.value,
                              decoration:
                                  getDecoration('Reenter Password').copyWith(
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    controller.isRePasswordVisible.value =
                                        !controller.isRePasswordVisible.value;
                                  },
                                  icon: Icon(
                                    controller.isRePasswordVisible.value
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: colorScheme.primary,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.05),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: colorScheme.primary,
                                foregroundColor: colorScheme.onPrimary,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                minimumSize: Size(
                                  double.infinity,
                                  screenHeight * 0.07,
                                ),
                              ),
                              onPressed: () async {
                                if (controller.formKey.currentState!.validate()) {
                                  String fullname= '${controller.firstNameController.text} ${controller.lastNameController.text}';
                                  await controller.signup(email: controller.emailController.text, fullname: fullname, 
                                  password: controller.passwordController.text);
                      
                                }
                              },
                              child: controller.isLoading.value?CircularProgressIndicator(
                                color: colorScheme.background,
                              ): const Text('Sign up'),
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            Row(
                              children: [
                                Expanded(
                                    child: Divider(
                                  color: colorScheme.onSurface.withOpacity(
                                      0.2), // Consistent with the other divider
                                  thickness: 1,
                                )),
                                SizedBox(width: screenWidth * 0.03),
                                Text('Or',
                                    style: TextStyle(
                                        color: colorScheme.onBackground)),
                                SizedBox(width: screenWidth * 0.03),
                                Expanded(
                                    child: Divider(
                                  color: colorScheme.onSurface.withOpacity(
                                      0.2), // Consistent with the other divider
                                  thickness: 1,
                                ))
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Already have an account?",
                                  style: TextStyle(
                                      color: colorScheme.onBackground),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Get.offNamed(Routes.LOGIN);
                                  },
                                  style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero),
                                  child: Text(
                                    'Log in',
                                    style:
                                        TextStyle(color: colorScheme.primary),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    :  Obx(() => 
                    VerifyView(
                        name: controller.firstNameController.text, email: controller.verifyEmail.value)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
