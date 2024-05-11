import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:profitpulsecrm_mobile/app/modules/main/controllers/main_controller.dart';
import 'package:profitpulsecrm_mobile/app/routes/app_pages.dart';
import 'package:profitpulsecrm_mobile/app/views/snackbar_view.dart';

class AddTicketController extends GetxController {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    TextEditingController issueController = TextEditingController();
    final MainController mainController = Get.find<MainController>();
    RxList<String> contacts = <String>[].obs;
    RxString contactEmail=''.obs;
    RxBool isLoading= false.obs;
    final storage = const FlutterSecureStorage();
    final serverUrl = dotenv.env['SERVERURL'];

    @override
  void onInit() {
    contacts.value =   mainController.contacts.map((contact) => contact.email.toString()).toList();
    super.onInit();
  }


  Future<void> addTicket() async {
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
        'issue': issueController.text,
        
      });

      var response = await http.post(Uri.parse('$serverUrl/ticket/create'),
          headers: {
            "Content-Type": "application/json",
            "Cookie": cookie,
          },
          body: body);
      if (response.statusCode == 201) {
        Map<String, dynamic> ticket = jsonDecode(response.body);
        String ticketNo = ticket['ticketNo'];
        SnackbarHelper.showCustomSnackbar(
            title: 'Ticket generated',
            message: 'Ticket no: $ticketNo',
            type: SnackbarType.success);
        issueController.clear();
        isLoading.value = false;
        loadData(role);
        return;
      } else if (response.statusCode == 409) {
        SnackbarHelper.showCustomSnackbar(
            title: 'Conflict Error',
            message: 'Ticket already created',
            type: SnackbarType.error);
        issueController.clear();
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

    String? validateIssue(String? fullname) {
      if (fullname == null || fullname.isEmpty) {
        return 'Please enter your issue';
      }
      return null;
    }
  @override
  void onClose() {
    super.onClose();
    issueController.dispose();
  }

}
