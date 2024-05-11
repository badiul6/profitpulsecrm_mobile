import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:profitpulsecrm_mobile/app/modules/main/controllers/main_controller.dart';
import 'package:profitpulsecrm_mobile/app/routes/app_pages.dart';
import 'package:profitpulsecrm_mobile/app/views/snackbar_view.dart';
import 'package:http/http.dart' as http;

class Product {
  TextEditingController nameController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController discountController = TextEditingController();
}

class AddSaleController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController contactEmailController = TextEditingController();
  TextEditingController salesChannelController = TextEditingController();
  TextEditingController paymentMethodController = TextEditingController();
  TextEditingController shippingAddressController = TextEditingController();
  TextEditingController billingAddressController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController shippingCostController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  final MainController mainController = Get.find<MainController>();
  RxList<String> contacts = <String>[].obs;
  RxList<String> prodList = <String>[].obs;
  RxMap<String, int> productQuantities = <String, int>{}.obs;
  RxList<Product> products = <Product>[].obs;
  RxBool isLoading = false.obs;
  final storage = const FlutterSecureStorage();
  final serverUrl = dotenv.env['SERVERURL'];
  RxString contactEmail= ''.obs;

  @override
  void onInit() {
    contacts.value = mainController.contacts
        .map((contact) => contact.email.toString())
        .toList();
    prodList.value =
        mainController.products.map((prod) => prod.name.toString()).toList();
    productQuantities.value = {
      for (var item in mainController.products) item.name: item.quantity
    };
    super.onInit();
  }

  bool hasDuplicateProductNames(RxList<Product> pros) {
    Set<String> names = {}; // Set to track unique product names
    for (var product in pros) {
      String name = product.nameController.text; // Get the trimmed text
      if (names.contains(name)) {
        // If name already exists in the set, it's a duplicate
        return true;
      } else {
        names.add(name); // Otherwise, add the name to the set
      }
    }
    return false; // No duplicates found
  }

  List<Map<String, dynamic>> productsToJson(RxList<Product> pros) {
    return pros.map((product) {
      return {
        'name': product.nameController.text,
        'quantity': product.quantityController.text,
        'discount': product.discountController.text,
      };
    }).toList();
  }

  Map<String, dynamic> createRequestBody({
    required String contactEmail,
    required String salesChannel,
    required String paymentMethod,
    required String shippingAddress,
    required String billingAddress,
    required String location,
    required String shippingCost,
    required String notes,
    required RxList<Product> products,
  }) {
    return {
      'contact_email': contactEmail,
      'sales_channel': salesChannel,
      'payment_method': paymentMethod,
      'shipping_address': shippingAddress,
      'billing_address': billingAddress,
      'location': location,
      'shipping_cost': shippingCost,
      'notes': notes,
      'products': productsToJson(products),
    };
  }

  Future<void> addSale() async {
    try {
      isLoading.value = true;
      if (hasDuplicateProductNames(products)) {
        SnackbarHelper.showCustomSnackbar(
            title: 'Error',
            message: 'Please remove duplicates',
            type: SnackbarType.error);
        isLoading.value = false;
        return;
      }
      String? cookie = await storage.read(key: 'cookie');
      String? role = await storage.read(key: 'role');

      if (cookie == null || role == null) {
        await storage.deleteAll();
        SnackbarHelper.showCustomSnackbar(
            title: 'Error',
            message: 'Session expired. Please login again to continue',
            type: SnackbarType.error);
        Get.offAllNamed(Routes.HOME);
        isLoading.value = false;
        return;
      }

      var requestBody = createRequestBody(
        contactEmail: contactEmail.value,
        salesChannel: salesChannelController.text,
        paymentMethod: paymentMethodController.text,
        shippingAddress: shippingAddressController.text,
        billingAddress: billingAddressController.text,
        location: locationController.text,
        shippingCost: shippingCostController.text,
        notes: notesController.text,
        products: products,
      );
      String body = jsonEncode(requestBody);
      
    
      var response = await http.post(Uri.parse('$serverUrl/sale/add'),
          headers: {
            "Content-Type": "application/json",
            "Cookie": cookie,
          },
          body: body);
      if (response.statusCode == 201) {
        SnackbarHelper.showCustomSnackbar(
            title: 'Success',
            message: 'Sale added successfully',
            type: SnackbarType.success);
        loadData(role);
        isLoading.value = false;
        Get.offAllNamed(Routes.MAIN);
        return;
      } else if (response.statusCode == 403) {
        await storage.deleteAll();
        SnackbarHelper.showCustomSnackbar(
            title: 'Session Expired',
            message: 'Please login to continue',
            type: SnackbarType.error);
        Get.offAllNamed(Routes.HOME);
        isLoading.value = false;
        return;
      }
      SnackbarHelper.showCustomSnackbar(
          title: 'Error',
          message: 'Try again. Some error occur',
          type: SnackbarType.error);
      isLoading.value = false;
    } catch (e) {
      SnackbarHelper.showCustomSnackbar(
          title: 'Error',
          message: 'Try again. Some error occur',
          type: SnackbarType.error);
      isLoading.value = false;
    }
  }

  void loadData(String role) {
    if (role == 'OWNER') {
      mainController.loadAllData();
    } else if (role == 'MAGENT') {
      mainController.loadMagentData();
    } else if (role == 'SHEAD') {
      mainController.loadSheadData();
    } else if (role == 'SAGENT') {
      mainController.loadSagentData();
    } else if (role == 'CSAGENT') {
      mainController.loadCSagentData();
    }
  }

  // RxList<Product> products = <Product>[Product()].obs;
  String? validateEmail(String? value) {
    if (value == null || !value.contains('@')) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validateNotEmpty(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field cannot be empty';
    }
    return null;
  }

  String? validateDecimal(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field cannot be empty';
    }
    try {
      double.parse(value);
      return null;
    } catch (_) {
      return 'Please enter a valid number';
    }
  }

  void addProduct() {
    products.add(Product());
  }

  void removeProduct(int index) {
    products.removeAt(index);
  }

  void submitForm() async {

    if (formKey.currentState!.validate()) {
       await addSale();
    }
  }
}
