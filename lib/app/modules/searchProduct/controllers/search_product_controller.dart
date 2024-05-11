import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profitpulsecrm_mobile/app/data/product_response.dart';
import 'package:profitpulsecrm_mobile/app/modules/main/controllers/main_controller.dart';

class SearchProductController extends GetxController {
  TextEditingController searchController = TextEditingController();
  RxList<ProductResponse> filteredProducts = <ProductResponse>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Initially, display all contacts
    filteredProducts.assignAll(Get.find<MainController>().products);
    // Setup listener to filter contacts whenever the search text changes
    searchController.addListener(filterProducts);
  }

  void filterProducts() {
    String searchQuery = searchController.text.toLowerCase();
    if (searchQuery.isEmpty) {
      filteredProducts.assignAll(Get.find<MainController>().products);
    } else {
      filteredProducts.assignAll(Get.find<MainController>()
          .products
          .where((product) =>
              product.name.toLowerCase().contains(searchQuery) ||
              (product.description?.toLowerCase().contains(searchQuery) ?? false) ||
              product.unitPrice.toString().toLowerCase().contains(searchQuery) ||
              product.quantity.toString().toLowerCase().contains(searchQuery),)
          .toList());
    }
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
