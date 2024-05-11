import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profitpulsecrm_mobile/app/data/contact_response.dart';
import 'package:profitpulsecrm_mobile/app/modules/main/controllers/main_controller.dart';

class SearchContactController extends GetxController {
  TextEditingController searchController = TextEditingController();
  RxList<Contact> filteredContacts = <Contact>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Initially, display all contacts
    filteredContacts.assignAll(Get.find<MainController>().contacts);
    // Setup listener to filter contacts whenever the search text changes
    searchController.addListener(filterContacts);
  }

  void filterContacts() {
    String searchQuery = searchController.text.toLowerCase();
    if (searchQuery.isEmpty) {
      filteredContacts.assignAll(Get.find<MainController>().contacts);
    } else {
      filteredContacts.assignAll(Get.find<MainController>()
          .contacts
          .where((contact) =>
              contact.fullname.toLowerCase().contains(searchQuery) ||
              contact.email.toLowerCase().contains(searchQuery) ||
              contact.phone.toLowerCase().contains(searchQuery))
          .toList());
    }
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
