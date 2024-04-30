import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RxBool isRePasswordValid = false.obs;
  RxBool isPasswordVisible= false.obs;
  RxBool isRePasswordVisible= false.obs;
  RxInt pageNo= 1.obs;

  updatePage(int page){
    pageNo.value= page;
  }

  String? validateFullname(String? fullname) {
      if (fullname == null || fullname.isEmpty) {
        return 'Please enter your fullname';
      }
      return null;
    }
  
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
     if (passwordController.text != rePasswordController.text) {
    return 'Passwords do not match';
  }
    return null;
  }



  @override
  void onClose() {
    super.onClose();
    emailController.dispose();
    passwordController.dispose();
    rePasswordController.dispose();
  }

}
