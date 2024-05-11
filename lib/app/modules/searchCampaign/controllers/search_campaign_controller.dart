import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profitpulsecrm_mobile/app/data/campaign_response.dart';
import 'package:profitpulsecrm_mobile/app/modules/main/controllers/main_controller.dart';

class SearchCampaignController extends GetxController {
  TextEditingController searchController = TextEditingController();
  RxList<Campaign> filteredCampaigns= <Campaign>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Initially, display all contacts
    filteredCampaigns.assignAll(Get.find<MainController>().campaigns);
    // Setup listener to filter contacts whenever the search text changes
    searchController.addListener(filterCampaigns);
  }

  void filterCampaigns() {
    String searchQuery = searchController.text.toLowerCase();
    if (searchQuery.isEmpty) {
      filteredCampaigns.assignAll(Get.find<MainController>().campaigns);
    } else {
      filteredCampaigns.assignAll(
        Get.find<MainController>().campaigns.where((campaign) =>
          campaign.name.toLowerCase().contains(searchQuery)
        ).toList()
      );
    }
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
