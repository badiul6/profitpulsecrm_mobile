import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/search_campaign_controller.dart';


class SearchCampaignView extends GetView<SearchCampaignController> {
  const SearchCampaignView({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gmail Campaigns'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: controller.searchController,
              decoration: InputDecoration(
                hintText: 'Search by campaign name',
                fillColor: colorScheme.background,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: colorScheme.primary, width: 2), // Specify border color here
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: colorScheme.onBackground, width: 1), // Specify border color when TextField is not focused
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: colorScheme.primary, width: 2), // Specify border color when TextField is focused
                ),
                suffixIcon: const Icon(Icons.search),
              ),
              onChanged: (value) => controller.filterCampaigns(),  // Ensure the list filters in real time as the user types
            ),
          ),
          Expanded(
            child: Obx(() => 
            controller.filteredCampaigns.isEmpty? const Center(child: Text('No campaign exists')):
            
            ListView.builder(
              itemCount: controller.filteredCampaigns.length,
              itemBuilder: (context, index) {
                final campaign = controller.filteredCampaigns[index];
                return ListTile(
                  minLeadingWidth: 0,
                  title: Text(campaign.name,style: const TextStyle(fontWeight: FontWeight.w500),),
                  subtitle: Text("Targeted Contacts: ${campaign.totalEmailsSent}"),
                  trailing: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Clicks: ${campaign.clicks}",style: const TextStyle(fontSize: 15),)
                    ],
                  ),
                );
              },
            )),
          ),
        ],
      ),
    );
  }
}
