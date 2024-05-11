import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:profitpulsecrm_mobile/app/modules/main/controllers/main_controller.dart';
import 'package:profitpulsecrm_mobile/app/routes/app_pages.dart';
import 'package:profitpulsecrm_mobile/app/views/snackbar_view.dart';
import 'package:http/http.dart' as http;


class AddDealController extends GetxController {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final MainController mainController = Get.find<MainController>();
    RxList<String> contacts = <String>[].obs;
    RxList<String> salesAgents = <String>[].obs;
    RxString agentEmail=''.obs;
    RxString contactEmail=''.obs;
    RxBool isLoading= false.obs;
    final storage = const FlutterSecureStorage();
    final serverUrl = dotenv.env['SERVERURL'];


  @override
  void onInit() {
    contacts.value =   mainController.contacts.map((contact) => contact.email.toString()).toList();
    salesAgents.value= mainController.salesAgents.map((sagent) => sagent.email.toString()).toList();
    super.onInit();
  }

  Future<void> addDeal() async {
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
        'contact_email': contactEmail.value,
        'agent_email': agentEmail.value,
        
      });

      var response = await http.post(Uri.parse('$serverUrl/deal/create'),
          headers: {
            "Content-Type": "application/json",
            "Cookie": cookie,
          },
          body: body);
      if (response.statusCode == 201) {
        SnackbarHelper.showCustomSnackbar(
            title: 'Success',
            message: 'Deal successfully added',
            type: SnackbarType.success);
        isLoading.value = false;
        loadData(role);
        return;
      } else if (response.statusCode == 409) {
        SnackbarHelper.showCustomSnackbar(
            title: 'Conflict Error',
            message: 'Deal is already active with this contact',
            type: SnackbarType.error);
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


}
