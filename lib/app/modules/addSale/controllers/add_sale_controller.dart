import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

  // RxList<Product> products = <Product>[Product()].obs;
  RxList<Product> products = <Product>[].obs;
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

  void submitForm() {
    if (formKey.currentState!.validate()) {
      // API Call to submit data
      print("Form is valid, proceed with API call");
    }
  }
}
