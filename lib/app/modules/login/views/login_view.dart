import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:profitpulsecrm_mobile/app/modules/login/controllers/login_controller.dart';
import 'package:profitpulsecrm_mobile/app/routes/app_pages.dart';
import 'package:profitpulsecrm_mobile/app/views/snackbar_view.dart';

class LoginView extends GetView<LoginController> {
    LoginView({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController= TextEditingController();
  final TextEditingController _passwordController=TextEditingController();

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
                key: _formKey,
                child: Column(
                  children: [
                    SvgPicture.asset(
                      'assets/images/logo.svg', // Ensure this SVG handles its own colors or is styled appropriately
                    ),
                    SizedBox(height: screenHeight * 0.05),
                    TextFormField(
                      controller: _emailController,
                      validator: controller.validateEmail,
                      decoration: getInputDecoration('Email Address'),
                    ),
                    SizedBox(height: screenHeight * 0.039),
                    Obx(
                      () => TextFormField(
                        controller: _passwordController,
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
                    // SizedBox(height: screenHeight * 0.01),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: TextButton(
                        onPressed: () {
                          Get.toNamed(Routes.FORGOT_PASSWORD);
                        },
                        child: Text(
                        'Forgot your password?',
                        style: TextStyle(color: colorScheme.primary),
                      ),)
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
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          int statusCode = await controller.login(
                              email: _emailController.text,
                              password: _passwordController.text);
                          if (statusCode == 200) {
                            Get.offAllNamed(Routes.MAIN);
                          } else if (statusCode == 204) {
                           
                            Get.offAllNamed(Routes.PROFILE);
                          } else if (statusCode == 422) {
                            SnackbarHelper.showCustomSnackbar(
                                title: 'Error',
                                message: "User not verified",
                                type: SnackbarType.error);
                          } else if (statusCode == 403) {
                            SnackbarHelper.showCustomSnackbar(
                                title: 'Error',
                                message: "Password doesn't match",
                                type: SnackbarType.error);
                          } else if (statusCode == 404) {
                            SnackbarHelper.showCustomSnackbar(
                                title: 'Error',
                                message: 'User not found',
                                type: SnackbarType.error);
                          } else {
                            SnackbarHelper.showCustomSnackbar(
                                title: 'Error',
                                message: 'Please try again',
                                type: SnackbarType.error);
                          }
                        }
                      },
                      child: Obx(() => controller.isLoading.value
                          ? CircularProgressIndicator(
                              color: colorScheme.background,
                            )
                          : const Text('Log in')),
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
