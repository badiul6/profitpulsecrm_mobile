import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:profitpulsecrm_mobile/app/modules/main/controllers/main_controller.dart';
import 'package:profitpulsecrm_mobile/app/routes/app_pages.dart';
import 'package:profitpulsecrm_mobile/app/views/snackbar_view.dart';

class AssignAgentController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RxBool isSelected = false.obs;
  final serverUrl = dotenv.env['SERVERURL'];
  final storage = const FlutterSecureStorage();
  RxBool isAgentLoading = false.obs;
  RxBool isZeroLeads = false.obs;
  final MainController mainController = Get.find<MainController>();
  RxList<String> saleAgents = <String>[].obs;
  RxList<String> campaigns = <String>[].obs;
  RxList<String> leads = <String>[].obs;
  RxString campaignName=''.obs;
  RxString leadEmail=''.obs;
  RxString agentEmail=''.obs;
  RxBool isLoading= false.obs;

  @override
  void onInit() {
    campaigns.value = mainController.campaigns
        .map((campaign) => campaign.name.toString())
        .toList();
    saleAgents.value = mainController.salesAgents
        .map((sagent) => sagent.email.toString())
        .toList();

    super.onInit();
  }

  Future<void> assignAgent() async {
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
        'contact_email': leadEmail.value,
        'agent_email': agentEmail.value,
        'campaign_name': campaignName.value
        
      });

      var response = await http.post(Uri.parse('$serverUrl/deal/assign-agent'),
          headers: {
            "Content-Type": "application/json",
            "Cookie": cookie,
          },
          body: body);
      if (response.statusCode == 201) {
        SnackbarHelper.showCustomSnackbar(
            title: 'Assigned',
            message: 'Deal created sucessfulyy',
            type: SnackbarType.success);
        isLoading.value = false;
        loadData(role);
        return;
      } else if (response.statusCode == 409) {
        SnackbarHelper.showCustomSnackbar(
            title: 'Conflict Error',
            message: 'Deal already created',
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

  Future<void> getAllCampaignLeads(String name) async {
    try {
      isZeroLeads.value = false;
      isSelected.value = false;
      isAgentLoading.value = true;
      String? cookie = await storage.read(key: 'cookie');
      String? role = await storage.read(key: 'role');

      if (cookie == null || role == null) {
        await storage.deleteAll();
        SnackbarHelper.showCustomSnackbar(
            title: 'Error',
            message: 'Session expired. Please login again to continue',
            type: SnackbarType.error);
        Get.offAllNamed(Routes.HOME);
        isAgentLoading.value = false;
        return;
      }

      var response = await http.get(
        Uri.parse(
          '$serverUrl/campaign/leads?name=$name',
        ),
        headers: {
          "Content-Type": "application/json",
          "Cookie": cookie, // Include the cookie here
        },
      );
      isAgentLoading.value = false;
      if (response.statusCode == 200) {
        List<String> emails = (jsonDecode(response.body)['data'] as List)
            .map((item) => item['contact']['email'] as String)
            .toList();
        leads.value = emails;
        if (emails.isEmpty) {
          isZeroLeads.value = true;
          return;
        }
        isSelected.value = true;
        return;
      } else if (response.statusCode == 403) {
        await storage.deleteAll();
        SnackbarHelper.showCustomSnackbar(
            title: 'Session Expired',
            message: 'Please login to continue',
            type: SnackbarType.error);
        Get.offAllNamed(Routes.HOME);
        return;
      }
      SnackbarHelper.showCustomSnackbar(
          title: 'Error',
          message: 'Try again. Some error occur',
          type: SnackbarType.error);
    } catch (e) {
      SnackbarHelper.showCustomSnackbar(
          title: 'Error',
          message: 'Try again. Some error occur',
          type: SnackbarType.error);
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
