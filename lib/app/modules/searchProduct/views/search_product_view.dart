import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/search_product_controller.dart';

class SearchProductView extends GetView<SearchProductController> {
  const SearchProductView({super.key});

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    final double screenHeight = mediaQueryData.size.height;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: controller.searchController,
              decoration: InputDecoration(
                hintText: 'Search by name, description, quantity or unit price',
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
              onChanged: (value) => controller.filterProducts(),  // Ensure the list filters in real time as the user types
            ),
          ),
          Expanded(
            child: Obx(() => 
            controller.filteredProducts.isEmpty?const Center(child: Text('No product exists')):
            
            ListView.builder(
              itemCount: controller.filteredProducts.length,
              itemBuilder: (context, index) {
                final product = controller.filteredProducts[index];
                return ListTile(
                  minLeadingWidth: 0,
                  title: Text(product.name,style: const TextStyle(fontWeight: FontWeight.w500),),
                  subtitle: Text(product.description?? '', maxLines: 2, overflow: TextOverflow.ellipsis,),
                  trailing: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                       Text('Unit Price: ${product.unitPrice}'),
                      Text('Quantity: ${product.quantity}',style: const TextStyle(fontSize: 15),),
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
