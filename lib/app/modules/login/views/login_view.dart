import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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

    InputDecoration getInputDecoration(String labelText) {
      return InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(color: colorScheme.onSurface.withOpacity(0.3)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colorScheme.onSurface.withOpacity(0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colorScheme.primary, width: 2.0),
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
            child: Padding(
              padding: EdgeInsets.only(
                  top: screenHeight * 0.07,
                  right: screenWidth * 0.04,
                  left: screenWidth * 0.04),
              child: Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    SvgPicture.asset(
                      'assets/images/logo.svg', // Ensure this SVG handles its own colors or is styled appropriately
                    ),
                    SizedBox(height: screenHeight * 0.05),
                    TextFormField(
                      controller: controller.emailController,
                      validator: controller.validateEmail,
                      decoration: getInputDecoration('Email Address'),
                    ),
                    SizedBox(height: screenHeight * 0.039),
                    Obx(
                      () => TextFormField(
                        controller: controller.passwordController,
                        validator: controller.validatePassword,
                        obscureText:
                            controller.isPasswordVisible.value ? false : true,
                        decoration: getInputDecoration('Password').copyWith(
                          suffixIcon: IconButton(
                            onPressed: () {
                              controller.isPasswordVisible.value =
                                  !controller.isPasswordVisible.value;
                            },
                            icon: controller.isPasswordVisible.value
                                ? Icon(Icons.visibility_off,
                                    color: colorScheme.primary)
                                : Icon(Icons.visibility,
                                    color: colorScheme.primary),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        'Forgot your password?',
                        style: TextStyle(color: colorScheme.primary),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.05),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorScheme.primary,
                        foregroundColor: colorScheme.onPrimary,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        minimumSize: Size(double.infinity, screenHeight * 0.07),
                      ),
                      onPressed: () {
                        if (controller.formKey.currentState!.validate()) {
                          Get.toNamed(Routes.PROFILE);
                        }
                      },
                      child: const Text('Log in'),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                              color: colorScheme.onSurface.withOpacity(0.3)),
                        ),
                        SizedBox(width: screenWidth * 0.03),
                        Text('Or',
                            style: TextStyle(color: colorScheme.onBackground)),
                        SizedBox(width: screenWidth * 0.03),
                        Expanded(
                          child: Divider(
                              color: colorScheme.onSurface.withOpacity(0.3)),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't you have an account?",
                          style: TextStyle(color: colorScheme.onBackground),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.offNamed(Routes.SIGNUP);
                          },
                          style: TextButton.styleFrom(
                              foregroundColor: colorScheme.primary),
                          child: const Text('Sign up now'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
