import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/search_contact_controller.dart';

class SearchContactView extends GetView<SearchContactController> {
  const SearchContactView({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: controller.searchController,
              decoration: InputDecoration(
                hintText: 'Search by name, email, or phone',
                fillColor: Colors.white,
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
              onChanged: (value) => controller.filterContacts(),  // Ensure the list filters in real time as the user types
            ),
          ),
          Expanded(
            child: Obx(() => 
            controller.filteredContacts.isEmpty?const Center(child: Text('No contact exists')):
            
            ListView.builder(
              itemCount: controller.filteredContacts.length,
              itemBuilder: (context, index) {
                final contact = controller.filteredContacts[index];
                return ListTile(
                  minLeadingWidth: 0,
                  title: Text(contact.fullname,style: const TextStyle(fontWeight: FontWeight.w500),),
                  subtitle: Text('Email: ${contact.email}', maxLines: 2, overflow: TextOverflow.ellipsis,),
                  trailing: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Phone#'),
                      Text(contact.phone,style: const TextStyle(fontSize: 15),),
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
