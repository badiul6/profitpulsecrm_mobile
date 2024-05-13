import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profitpulsecrm_mobile/app/data/ticket_response.dart';
import 'package:profitpulsecrm_mobile/app/modules/main/controllers/main_controller.dart';

class SearchTicketController extends GetxController {
  TextEditingController searchController = TextEditingController();
  final MainController mainController = Get.find<MainController>();

  RxList<Ticket> activeTickets = <Ticket>[].obs;
  RxList<Ticket> resolvedTickets = <Ticket>[].obs;
  RxList<Ticket> forwardedtickets = <Ticket>[].obs;

  @override
  void onInit() {
    super.onInit();
    filterTickets();
    searchController.addListener(filterTickets);
  }

  void filterTickets() {
    String query = searchController.text.toLowerCase();
    var allTickets = mainController.tickets;

    activeTickets.assignAll(allTickets.where((ticket) =>
        ticket.status == 'CREATED' &&
        (ticket.ticketNo.toLowerCase().contains(query) ||
         ticket.contact.fullname.toLowerCase().contains(query) ||
         ticket.contact.email.toLowerCase().contains(query) ||
         ticket.contact.phone.toLowerCase().contains(query) ||
         ticket.issue.toLowerCase().contains(query) ||
         ticket.user.fullname.toLowerCase().contains(query))));

    resolvedTickets.assignAll(allTickets.where((ticket) =>
        ticket.status == 'RESOLVED' &&
        (ticket.ticketNo.toLowerCase().contains(query) ||
         ticket.contact.fullname.toLowerCase().contains(query) ||
         ticket.contact.email.toLowerCase().contains(query) ||
         ticket.contact.phone.toLowerCase().contains(query) ||
         ticket.issue.toLowerCase().contains(query) ||
         ticket.user.fullname.toLowerCase().contains(query))));

    forwardedtickets.assignAll(allTickets.where((ticket) =>
        ticket.status == 'FORWARDED' &&
        (ticket.ticketNo.toLowerCase().contains(query) ||
         ticket.contact.fullname.toLowerCase().contains(query) ||
         ticket.contact.email.toLowerCase().contains(query) ||
         ticket.contact.phone.toLowerCase().contains(query) ||
         ticket.issue.toLowerCase().contains(query) ||
         ticket.user.fullname.toLowerCase().contains(query))));
  }
 String formatDateTime(DateTime dateTime) {
  // Extracting date parts
  DateTime pakistanTime = dateTime.add(const Duration(hours: 5));
  String year = pakistanTime.year.toString().padLeft(4, '0');
  String month = pakistanTime.month.toString().padLeft(2, '0');
  String day = pakistanTime.day.toString().padLeft(2, '0');
  String hour = pakistanTime.hour.toString().padLeft(2, '0');
  String minute = pakistanTime.minute.toString().padLeft(2, '0');

  // Formatting to "yyyy-MM-dd HH:mm"
  return "$year-$month-$day $hour:$minute";
}
  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
