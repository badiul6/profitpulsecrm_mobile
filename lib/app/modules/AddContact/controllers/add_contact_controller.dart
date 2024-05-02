import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddContactController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController fullnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController jobTitleController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();


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
    String? validatePhone(String? phone) {
      if (phone == null || phone.isEmpty) {
        return 'Please enter your phone number';
      }
      bool isValidPhone =
          RegExp(r'^\+?\d+$').hasMatch(phone);

      if (!isValidPhone) {
        return 'Invalid phone number';
      }
      return null;
    }

    String? validateFullname(String? fullname) {
      if (fullname == null || fullname.isEmpty) {
        return 'Please enter your fullname';
      }
      return null;
    }

  @override
  void onClose() {
    super.onClose();
    emailController.dispose();
    fullnameController.dispose();
    phoneController.dispose();
    companyNameController.dispose();
    jobTitleController.dispose();
  }
}
