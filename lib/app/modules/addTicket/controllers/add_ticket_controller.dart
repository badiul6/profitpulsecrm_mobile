import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddTicketController extends GetxController {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    TextEditingController issueController = TextEditingController();

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
