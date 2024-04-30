import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RxBool isPasswordVisible= false.obs;

 

  String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Please enter your email';
    }
    bool isValidEmail =
        RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);

    if (!isValidEmail) {
      return 'Invalid email address';
    }
    return null;
  }

  String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password cannot be empty';
    }
    final regexUppercase = RegExp(r'[A-Z]');
    final regexLowercase = RegExp(r'[a-z]');
    final regexDigit = RegExp(r'[0-9]');
    final regexSpecial = RegExp(r'[#?!@$%^&*-]');
    if (password.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    if (!regexUppercase.hasMatch(password)) {
      return 'Password must contain at least one uppercase letter';
    }
    if (!regexLowercase.hasMatch(password)) {
      return 'Password must contain at least one lowercase letter';
    }
    if (!regexDigit.hasMatch(password)) {
      return 'Password must contain at least one number';
    }
    if (!regexSpecial.hasMatch(password)) {
      return 'Password must contain at least one special character';
    }
    return null;
  }

  @override
  void onClose() {
    super.onClose();
    emailController.dispose();
    passwordController.dispose();
  }
}
