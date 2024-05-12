import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/search_team_controller.dart';

class SearchTeamView extends GetView<SearchTeamController> {
  const SearchTeamView({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your team'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: controller.searchController,
              decoration: InputDecoration(
                hintText: 'Search by member name, email or role',
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
              onChanged: (value) => controller.filterAgents(),  // Ensure the list filters in real time as the user types
            ),
          ),
          Expanded(
            child: Obx(() => 
            controller.filteredAgents.isEmpty? const Center(child: Text('No member exists')):
            
            ListView.builder(
              itemCount: controller.filteredAgents.length,
              itemBuilder: (context, index) {
                final agent = controller.filteredAgents[index];
                return ListTile(
                  minLeadingWidth: 0,
                  title: Text(agent.fullname,style: const TextStyle(fontWeight: FontWeight.w500),),
                  subtitle: Text(agent.email),
                  trailing: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(controller.getRole(agent.roles[0])
                      ,style: const TextStyle(fontSize: 12),
                      )
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
