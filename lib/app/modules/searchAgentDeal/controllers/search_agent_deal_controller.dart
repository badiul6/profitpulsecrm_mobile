import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profitpulsecrm_mobile/app/data/agent_deal_response.dart';
import 'package:profitpulsecrm_mobile/app/modules/main/controllers/main_controller.dart';

class SearchAgentDealController extends GetxController {
  TextEditingController searchController = TextEditingController();
  final MainController mainController = Get.find<MainController>();

  RxList<AgentDeal> activeDeals = <AgentDeal>[].obs;
  RxList<AgentDeal> completedDeals = <AgentDeal>[].obs;
  RxList<AgentDeal> cancelledDeals = <AgentDeal>[].obs;

  @override
  void onInit() {
    super.onInit();
    filterDeals();
    searchController.addListener(filterDeals);
  }

  void filterDeals() {
    String query = searchController.text.toLowerCase();
    var allDeals = mainController.agentDeals;

    activeDeals.assignAll(allDeals.where((deal) =>
        deal.isActive &&
        (deal.contact.fullname.toLowerCase().contains(query) ||
         deal.contact.email.toLowerCase().contains(query) ||
         (deal.contact.companyname?.toLowerCase().contains(query) ?? false) ||
         (deal.contact.jobtitle?.toLowerCase().contains(query) ?? false) ||
         deal.status.toLowerCase().contains(query))));

    completedDeals.assignAll(allDeals.where((deal) =>
        deal.status == 'COMPLETED' &&
        (deal.contact.fullname.toLowerCase().contains(query) ||
         deal.contact.email.toLowerCase().contains(query) ||
         (deal.contact.companyname?.toLowerCase().contains(query) ?? false) ||
         (deal.contact.jobtitle?.toLowerCase().contains(query) ?? false))));

    cancelledDeals.assignAll(allDeals.where((deal) =>
        deal.status == 'CANCELLED' &&
        (deal.contact.fullname.toLowerCase().contains(query) ||
         deal.contact.email.toLowerCase().contains(query) ||
         (deal.contact.companyname?.toLowerCase().contains(query) ?? false) ||
         (deal.contact.jobtitle?.toLowerCase().contains(query) ?? false))));
  }
 String formatDateTime(DateTime dateTime) {
  // Extracting date parts
  String year = dateTime.year.toString().padLeft(4, '0');
  String month = dateTime.month.toString().padLeft(2, '0');
  String day = dateTime.day.toString().padLeft(2, '0');
  String hour = dateTime.hour.toString().padLeft(2, '0');
  String minute = dateTime.minute.toString().padLeft(2, '0');

  // Formatting to "yyyy-MM-dd HH:mm"
  return "$year-$month-$day $hour:$minute";
}
  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
