import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/forgot_password_controller.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  const ForgotPasswordView({super.key});
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
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
        body: Padding(
      padding: EdgeInsets.only(
          top: screenHeight * 0.1,
          right: screenWidth * 0.03,
          left: screenWidth * 0.03),
      child: Center(
        child: Form(
          key: controller.formKey,
          child: Column(
            children: [
              const Text(
                'Reset your password',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 30),
              ),
              SizedBox(height: screenHeight * 0.01),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                  child: const Text(
                    "Please enter the email address you'd like your password reset information sent to.",
                    textAlign: TextAlign.center,
                  )),
              SizedBox(height: screenHeight * 0.07),
              TextFormField(
                controller: controller.emailController,
                validator: controller.validateEmail,
                decoration: getInputDecoration('Email address'),
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
                    controller.forgotPassword();
                  }
                },
                child: Obx(() => controller.isLoading.value
                    ? CircularProgressIndicator(
                        color: colorScheme.background,
                      )
                    : const Text('Request reset'),)
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
