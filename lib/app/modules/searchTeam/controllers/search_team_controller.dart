import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profitpulsecrm_mobile/app/data/agent_response.dart';
import 'package:profitpulsecrm_mobile/app/modules/main/controllers/main_controller.dart';

class SearchTeamController extends GetxController {
  TextEditingController searchController = TextEditingController();
  RxList<Agent> filteredAgents= <Agent>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Initially, display all contacts
    filteredAgents.assignAll(Get.find<MainController>().agents);
    // Setup listener to filter contacts whenever the search text changes
    searchController.addListener(filterAgents);
  }

  void filterAgents() {
    String searchQuery = searchController.text.toLowerCase();
    if (searchQuery.isEmpty) {
      filteredAgents.assignAll(Get.find<MainController>().agents);
    } else {
      filteredAgents.assignAll(
        Get.find<MainController>().agents.where((agent) =>
          agent.fullname.toLowerCase().contains(searchQuery)||
          agent.email.toLowerCase().contains(searchQuery)
        ).toList()
      );
    }
  }
  String getRole(String role){
    if(role=='MAGENT'){
      return 'Marketing Agent';
    }else if(role=='SHEAD'){
      return 'Sales Head';
    }else if(role=='SAGENT'){
      return 'Sales Agent';
    }else if(role=='CSAGENT'){
      return 'CS Agent';
    }
    return '';
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
