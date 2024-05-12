import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:profitpulsecrm_mobile/app/views/snackbar_view.dart';


class ForgotPasswordController extends GetxController {
  TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RxBool isLoading = false.obs;
  final serverUrl = dotenv.env['SERVERURL'];

  Future<void> forgotPassword() async {
    isLoading.value = true;
    var body = jsonEncode({
      'email': emailController.text
    });
    try {
      var response = await http.post(Uri.parse('$serverUrl/auth/forgot-password'),
          headers: {
            "Content-Type": "application/json",
          },
          body: body);
          isLoading.value=false;
          if(response.statusCode==201){
            SnackbarHelper.showCustomSnackbar(title: 'Request approved', message: 'We have sent a temporary password at you email', type: SnackbarType.success);
            emailController.clear();
            return;
          }else if(response.statusCode==406){
            SnackbarHelper.showCustomSnackbar(title: 'Error', message: 'Contact your company owner for password reset', type: SnackbarType.error);
            emailController.clear();
            return;
          }else if(response.statusCode==409){
            SnackbarHelper.showCustomSnackbar(title: 'Error', message: 'Wait for 5 minutes to request another password reset', type: SnackbarType.error);
            emailController.clear();
            return;  
          }else if(response.statusCode==404){
            SnackbarHelper.showCustomSnackbar(title: 'Error', message: 'No user exists with this email', type: SnackbarType.error);
            return;  
          }
          SnackbarHelper.showCustomSnackbar(title: 'Error', message: 'Some error occur');
          return;
      
    } catch (e) {
          SnackbarHelper.showCustomSnackbar(title: 'Error', message: 'Some error occur');
    }
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
    emailController.dispose();
  }
}
