import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profitpulsecrm_mobile/app/data/ticket_response.dart';

import '../controllers/search_ticket_controller.dart';

class SearchTicketView extends GetView<SearchTicketController> {
  const SearchTicketView({super.key});

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    final double screenHeight = mediaQueryData.size.height;
    final double screenWidth = mediaQueryData.size.width;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Tickets'),
          bottom: TabBar(
            labelColor: colorScheme.background,
            unselectedLabelColor: colorScheme.background.withOpacity(0.7),
            tabs: const [
              Tab(text: 'Active'),
              Tab(text: 'Resolved'),
              Tab(text: 'Forwarded'),
            ],
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: controller.searchController,
                decoration: InputDecoration(
                  hintText: 'Search by ticket no, contact or agent details',
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide:
                        BorderSide(color: colorScheme.primary, width: 2),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide:
                        BorderSide(color: colorScheme.onBackground, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide:
                        BorderSide(color: colorScheme.primary, width: 2),
                  ),
                  suffixIcon: const Icon(Icons.search),
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  dealListTab(
                      controller.activeTickets, screenHeight, screenWidth, colorScheme),
                  dealListTab(
                      controller.resolvedTickets, screenHeight, screenWidth, colorScheme),
                  dealListTab(
                      controller.forwardedtickets, screenHeight, screenWidth, colorScheme),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget dealListTab(
      RxList<Ticket> tickets, double screenHeight, double screenWidth, ColorScheme colorScheme) {
    return Obx(() => tickets.isEmpty
        ? const Center(child: Text("No Tickets available"))
        : ListView.builder(
            itemCount: tickets.length,
            itemBuilder: (context, index) {
              final ticket = tickets[index];
              return Container(
                margin: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.0025,
                    horizontal: screenWidth * 0.02),
                padding: EdgeInsets.only(
                    bottom: screenHeight * 0.02,
                    top: screenHeight * 0.02,
                    left: screenWidth * 0.02),
                width: double.infinity,
                color: colorScheme.primary.withOpacity(0.1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Ticket no'),
                        Text('Contact name'),
                        Text('Contact email'),
                        Text('Contact phone'),
                        Text('Agent Name'),
                        Text('Issue'),
                        Text('Last updated'),
                      ],
                    ),
                    SizedBox(
                      width: screenWidth * 0.05,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(ticket.ticketNo),
                          Text(ticket.contact.fullname),
                          Text(
                            ticket.contact.email,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          Text(ticket.contact.phone),
                          Text(ticket.user.fullname),
                          Text(
                            ticket.issue,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          Text(controller.formatDateTime(ticket.updatedAt)),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ));
  }
}
