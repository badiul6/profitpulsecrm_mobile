import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController websiteController = TextEditingController();
  TextEditingController socialController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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

     String? validateUrl(String? url) {
      if (url == null || url.isEmpty) {
        return "Url can't be empty";
      }
      bool isValidUrl =
          RegExp(r'^https?:\/\/[\w\-]+(\.[\w\-]+)+[\w\-.,@?^=%&:/~+#]*[\w\-@?^=%&/~+#]$').hasMatch(url);
          
      if (!isValidUrl) {
        return 'Invalid url';
      }
      return null;
    }

  String? validateName(String? fullname) {
    if (fullname == null || fullname.isEmpty) {
      return 'Please enter company name';
    }
    return null;
  }

  String? validateAddress(String? address) {
    if (address == null || address.isEmpty) {
      return 'Please enter company address';
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

  @override
  void onClose() {
    super.onClose();
  }
}
