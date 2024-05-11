import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:profitpulsecrm_mobile/app/modules/main/controllers/main_controller.dart';
import 'package:profitpulsecrm_mobile/app/routes/app_pages.dart';
import 'package:profitpulsecrm_mobile/app/views/snackbar_view.dart';
import 'package:http/http.dart' as http;

class AddContactController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController fullnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController jobTitleController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RxBool isLoading= false.obs;
  final storage = const FlutterSecureStorage();
  final serverUrl = dotenv.env['SERVERURL'];
  final MainController mainController = Get.find<MainController>();



  Future<void> addContact() async {
    try {
      isLoading.value = true;
      String? cookie = await storage.read(key: 'cookie');
      String? role = await storage.read(key: 'role');

      if (cookie == null || role == null) {
        await storage.deleteAll();
        SnackbarHelper.showCustomSnackbar(
            title: 'Error',
            message: 'Session expired. Please login again to continue',
            type: SnackbarType.error);
        Get.offAllNamed(Routes.HOME);
        isLoading.value = false;
        return;
      }
      var body = jsonEncode({
        'email': emailController.text,
        'fullname': fullnameController.text,
        'phone': phoneController.text,
        'companyname': companyNameController.text,
        'jobtitle': jobTitleController.text
      });

      var response = await http.post(Uri.parse('$serverUrl/contact/create'),
          headers: {
            "Content-Type": "application/json",
            "Cookie": cookie,
          },
          body: body);
      if (response.statusCode == 201) {
        SnackbarHelper.showCustomSnackbar(
            title: 'Success',
            message: 'Contact successfully added',
            type: SnackbarType.success);
        emailController.clear();
        fullnameController.clear();
        phoneController.clear();
        companyNameController.clear();
        jobTitleController.clear();
        isLoading.value = false;
        loadData(role);
        return;
      } else if (response.statusCode == 409) {
        SnackbarHelper.showCustomSnackbar(
            title: 'Conflict Error',
            message: 'Contact already exists with this email',
            type: SnackbarType.error);
        emailController.clear();
        fullnameController.clear();
        phoneController.clear();
        companyNameController.clear();
        jobTitleController.clear();
        isLoading.value = false;
        return;
      } else if (response.statusCode == 403) {
        await storage.deleteAll();
        SnackbarHelper.showCustomSnackbar(
            title: 'Session Expired',
            message: 'Please login to continue',
            type: SnackbarType.error);
        Get.offAllNamed(Routes.HOME);
        isLoading.value = false;
        return;
      }
      SnackbarHelper.showCustomSnackbar(
          title: 'Error',
          message: 'Try again. Some error occur',
          type: SnackbarType.error);
      isLoading.value = false;
    } catch (e) {
      SnackbarHelper.showCustomSnackbar(
          title: 'Error',
          message: 'Try again. Some error occur',
          type: SnackbarType.error);
      isLoading.value = false;
    }
  }

  void loadData(String role) {
    if (role == 'OWNER') {
      mainController.loadAllData();
    } else if (role == 'MAGENT') {
      mainController.loadMagentData();
    } else if (role == 'SHEAD') {
      mainController.loadSheadData();
    } else if (role == 'SAGENT') {
      mainController.loadSagentData();
    } else if (role == 'CSAGENT') {
      mainController.loadCSagentData();
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
