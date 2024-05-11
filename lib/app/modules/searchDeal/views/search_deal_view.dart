import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profitpulsecrm_mobile/app/data/deal_response.dart';
import '../controllers/search_deal_controller.dart';

class SearchDealView extends GetView<SearchDealController> {
  const SearchDealView({super.key});

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
          title: const Text('Deals'),
          bottom: TabBar(
            labelColor: colorScheme.background,
            unselectedLabelColor: colorScheme.background.withOpacity(0.7),
            tabs: const [
              Tab(text: 'Active'),
              Tab(text: 'Completed'),
              Tab(text: 'Cancelled'),
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
                  hintText: 'Search by agent name or contact details',
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: colorScheme.primary, width: 2),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: colorScheme.onBackground, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: colorScheme.primary, width: 2),
                  ),
                  suffixIcon: const Icon(Icons.search),
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  dealListTab(controller.activeDeals, screenHeight, screenWidth, colorScheme),
                  dealListTab(controller.completedDeals, screenHeight, screenWidth, colorScheme),
                  dealListTab(controller.cancelledDeals, screenHeight, screenWidth, colorScheme),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget dealListTab(RxList<Deal> deals, double screenHeight, double screenWidth, ColorScheme colorScheme) {
    return Obx(() => deals.isEmpty
        ? const Center(child: Text("No deals available"))
        : ListView.builder(
            itemCount: deals.length,
            itemBuilder: (context, index) {
              final deal = deals[index];
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
                    Text('Contact name'),
                    Text('Contact email'),
                    Text('Company Name'),
                    Text('Job Title'),
                    Text('Agent Name'),
                    Text('Status'),
                    Text('No of interactions'),
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
                      Text(deals[index].contact.fullname),
                      Text(
                        deal.contact.email,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      Text(deal.contact.companyname ?? 'N/A'),
                      Text(deal.contact.jobtitle ?? 'N/A'),
                      Text(deal.user.fullname),
                      Text(deal.status),
                      Text(deal.interactions.length.toString()),
                      Text(controller.formatDateTime(deal.updatedAt)),
                    ],
                  ),
                ),
              ],
            ),
          );

            },
          )
          );
  }
}
