import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profitpulsecrm_mobile/app/data/agent_ticket_response.dart';
import 'package:profitpulsecrm_mobile/app/modules/main/controllers/main_controller.dart';

class SearchAgentTicketController extends GetxController {
  TextEditingController searchController = TextEditingController();
  final MainController mainController = Get.find<MainController>();

  RxList<AgentTicket> activeTickets = <AgentTicket>[].obs;
  RxList<AgentTicket> resolvedTickets = <AgentTicket>[].obs;
  RxList<AgentTicket> forwardedtickets = <AgentTicket>[].obs;

  @override
  void onInit() {
    super.onInit();
    filterTickets();
    searchController.addListener(filterTickets);
  }

  void filterTickets() {
    String query = searchController.text.toLowerCase();
    var allTickets = mainController.agentTickets;

    activeTickets.assignAll(allTickets.where((ticket) =>
        ticket.status == 'CREATED' &&
        (ticket.ticketNo.toLowerCase().contains(query) ||
         ticket.contact.fullname.toLowerCase().contains(query) ||
         ticket.contact.email.toLowerCase().contains(query) ||
         ticket.contact.phone.toLowerCase().contains(query) ||
         ticket.issue.toLowerCase().contains(query))));

    resolvedTickets.assignAll(allTickets.where((ticket) =>
        ticket.status == 'RESOLVED' &&
        (ticket.ticketNo.toLowerCase().contains(query) ||
         ticket.contact.fullname.toLowerCase().contains(query) ||
         ticket.contact.email.toLowerCase().contains(query) ||
         ticket.contact.phone.toLowerCase().contains(query) ||
         ticket.issue.toLowerCase().contains(query))));

    forwardedtickets.assignAll(allTickets.where((ticket) =>
        ticket.status == 'FORWARDED' &&
        (ticket.ticketNo.toLowerCase().contains(query) ||
         ticket.contact.fullname.toLowerCase().contains(query) ||
         ticket.contact.email.toLowerCase().contains(query) ||
         ticket.contact.phone.toLowerCase().contains(query) ||
         ticket.issue.toLowerCase().contains(query))));
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
