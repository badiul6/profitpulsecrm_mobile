import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profitpulsecrm_mobile/app/modules/addSale/controllers/add_sale_controller.dart';
import 'package:profitpulsecrm_mobile/app/views/search_field_view.dart';

class AddSaleView extends GetView<AddSaleController> {
  const AddSaleView({super.key});

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
        title: const Text('Add Sale'),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: controller.formKey,
          child: Padding(
            padding: EdgeInsets.only(
                top: screenHeight * 0.02,
                right: screenWidth * 0.03,
                left: screenWidth * 0.03),
            child: Column(
              children: [
                Text('Create a new sale record',
                    style: TextStyle(fontSize: 22, color: colorScheme.onSurface)),
                SizedBox(height: screenHeight * 0.03),
                SearchFieldView(
                  validEmails: controller.contacts,  // Assuming you have a validEmails list in controller
                  labelText: 'Contact Email',
                  getInput: (s){  
                    controller.contactEmail.value= s;
                  },
                  // Assuming method in controller
                ),
                SizedBox(height: screenHeight * 0.02),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controller.salesChannelController,
                        decoration: getInputDecoration('Sales Channel'),
                        validator: controller.validateNotEmpty,
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.02),
                    Expanded(
                      child: TextFormField(
                        controller: controller.paymentMethodController,
                        decoration: getInputDecoration('Payment Method'),
                        validator: controller.validateNotEmpty,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.02),
                TextFormField(
                  controller: controller.shippingAddressController,
                  decoration: getInputDecoration('Shipping Address'),
                  validator: controller.validateNotEmpty,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  textInputAction: TextInputAction.newline,
                ),
                SizedBox(height: screenHeight * 0.02),
                TextFormField(
                  controller: controller.billingAddressController,
                  decoration: getInputDecoration('Billing Address')
                      .copyWith(suffixIcon: TextButton(
                        onPressed: () {
                          controller.billingAddressController.text =
                              controller.shippingAddressController.text;
                        },
                        child: const Text('Same as above', style: TextStyle(fontSize: 12)),
                      )),
                  validator: controller.validateNotEmpty,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  textInputAction: TextInputAction.newline,
                ),
                SizedBox(height: screenHeight * 0.02),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controller.locationController,
                        decoration: getInputDecoration('Location'),
                        validator: controller.validateNotEmpty,
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.02),
                    Expanded(
                      child: TextFormField(
                        controller: controller.shippingCostController,
                        decoration: getInputDecoration('Shipping Cost'),
                        validator: controller.validateDecimal,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.02),
                TextFormField(
                  controller: controller.notesController,
                  decoration: getInputDecoration('Notes'),
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  textInputAction: TextInputAction.newline,
                ),
                Row(
                  children: [
                    const Text('Products', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                    const Spacer(),
                    TextButton(
                      onPressed: controller.addProduct,
                      child: const Text('+ Add New', style: TextStyle(fontSize: 15, color: Colors.blue)),
                    )
                  ],
                ),
                Obx(() => Column(
                  children: List.generate(
                    controller.products.length,
                    (index) => ProductForm(
                            key: ValueKey(controller.products[index].hashCode), // Unique key for each product
                      product: controller.products[index],
                      index: index,
                      onRemove: () { 
                        controller.removeProduct(index);
                        }),
                  ),
                )),
                SizedBox(height: screenHeight * 0.02),
                Obx(() => ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme.primary,
                      foregroundColor: colorScheme.onPrimary,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                      minimumSize: Size(double.infinity, screenHeight * 0.07)),
                  onPressed: (){
                    controller.submitForm();
                  },
                  child: controller.isLoading.value?CircularProgressIndicator(color: colorScheme.background,): const Text('Create')),),
                SizedBox(height: screenHeight * 0.02),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class ProductForm extends GetView<AddSaleController> {
  final Product product;
  final VoidCallback onRemove;
  final int index;

  const ProductForm({
required Key key,
    required this.product,
    required this.onRemove,
    required this.index
 }) : super(key: key); 

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    InputDecoration getInputDecoration(String label) {
      return InputDecoration(
        labelText: label,
                                floatingLabelStyle: TextStyle(color: colorScheme.primary),

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

    return Column(
      children: [
        Row(
          children: [
            Text(
              'Product ${index + 1}',
              style: TextStyle(color: colorScheme.onSurface),
            ),
            const Spacer(),
            IconButton(
              onPressed: onRemove,
              icon: Icon(
                Icons.delete,
                color: colorScheme.error,
              )
            )
          ],
        ),
       SearchFieldView(
                validEmails: controller.prodList,  // Use product list instead of email list
                labelText: 'Product Name',
                getInput: (selection) {
                  product.nameController.text = selection;
                },
              ),
        SizedBox(height: screenHeight * 0.02),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: product.quantityController,
                keyboardType: TextInputType.number,
                decoration: getInputDecoration('Quantity'),
                validator: (value) {
                  if (value == null || value.isEmpty) return "Cannot be empty";
                  final int enteredQuantity = int.tryParse(value) ?? 0;
                  if (enteredQuantity > controller.productQuantities[product.nameController.text]!) {
                    return "Stock has ${controller.productQuantities[product.nameController.text]} items left";
                  }
                  return null;
                },
              ),
            ),
            SizedBox(width: screenWidth * 0.02),
            Expanded(
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: product.discountController,
                decoration: getInputDecoration('Discount'),
                validator: (value) => value == null || value.isEmpty ? "Cannot be empty" : null,
              ),
            ),
          ],
        )
      ],
    );
  }
}