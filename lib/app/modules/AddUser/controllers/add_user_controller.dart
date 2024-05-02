import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddUserController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController fullnameController = TextEditingController();
  TextEditingController roleController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RxString selectedRoleKey=''.obs;
  Map<String, String> memberRoles = {
  'MAGENT': 'Marketing Agent',
  'SHEAD': 'Sales Head',
  'SAGENT': 'Sales Agent',
  'CSAGENT': 'Customer Service Agent',
};
 
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
    roleController.dispose();
  }

}
