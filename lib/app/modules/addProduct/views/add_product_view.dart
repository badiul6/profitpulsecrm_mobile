import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profitpulsecrm_mobile/app/modules/addSale/controllers/add_sale_controller.dart';
import 'package:profitpulsecrm_mobile/app/views/search_field_view.dart';

import '../controllers/add_product_controller.dart';

class AddProductView extends GetView<AddProductController> {
  const AddProductView({super.key});

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    InputDecoration getInputDecoration(String labelText) {
      return InputDecoration(
        floatingLabelStyle: TextStyle(color: colorScheme.primary),
        labelText: labelText,
        labelStyle: TextStyle(color: colorScheme.onSurface),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colorScheme.onSurface.withOpacity(0.5)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colorScheme.primary, width: 2.0),
        ),
        border: const OutlineInputBorder(),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: controller.formKey,
          child: Padding(
            padding: EdgeInsets.only(
                top: screenHeight * 0.03,
                right: screenWidth * 0.03,
                left: screenWidth * 0.03),
            child: Column(
              children: [
                Text('Add a new product',
                    style:
                        TextStyle(fontSize: 22, color: colorScheme.onSurface)),
                SizedBox(height: screenHeight * 0.04),
                TextFormField(
                  controller: controller.nameController,
                  decoration: getInputDecoration('Product name'),
                  validator: controller.validateField,
                ),
                SizedBox(height: screenHeight * 0.03),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controller.quantityController,
                        decoration: getInputDecoration('Quantity'),
                        validator: controller.validateField,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.02),
                    Expanded(
                      child: TextFormField(
                        controller: controller.unitPriceController,
                        decoration: getInputDecoration('Unit Price'),
                        validator: controller.validateField,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.03),
                TextFormField(
                  controller: controller.descriptionController,
                  decoration: getInputDecoration('Description'),
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  textInputAction: TextInputAction.newline,
                ),
               
                SizedBox(height: screenHeight * 0.04),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: colorScheme.primary,
                        foregroundColor: colorScheme.onPrimary,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        minimumSize:
                            Size(double.infinity, screenHeight * 0.07)),
                            onPressed: () {
                              if(controller.formKey.currentState!.validate()){
                                controller.addProduct();
                              }
                            },
                    child: Obx(() => controller.isLoading.value? CircularProgressIndicator(color: colorScheme.background,):const Text('Add'))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

