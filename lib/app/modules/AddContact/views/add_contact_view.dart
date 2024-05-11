import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/add_contact_controller.dart';

class AddContactView extends GetView<AddContactController> {
  const AddContactView({super.key});

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    InputDecoration getInputDecoration(String labelText) {
      return InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(color: colorScheme.onSurface.withOpacity(0.3)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colorScheme.onSurface.withOpacity(0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colorScheme.primary, width: 2.0),
        ),
        labelText: labelText,
        labelStyle: TextStyle(color: colorScheme.onSurface),
                        floatingLabelStyle: TextStyle(color: colorScheme.primary),

      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Contact'),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
              top: screenHeight * 0.03,
              right: screenWidth * 0.03,
              left: screenWidth * 0.03),
          child: Center(
            child: Form(
              key: controller.formKey,
              child: Column(
                children: [
                  Text(
                    'Create a new contact',
                    style: TextStyle(fontSize: 22, color: colorScheme.onBackground),
                  ),
                  SizedBox(height: screenHeight * 0.04),
                  TextFormField(
                    controller: controller.emailController,
                    validator: controller.validateEmail,
                    decoration: getInputDecoration('Email address'),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  TextFormField(
                    controller: controller.fullnameController,
                    validator: controller.validateFullname,
                    decoration: getInputDecoration('Full name'),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  TextFormField(
                    controller: controller.phoneController,
                    validator: controller.validatePhone,
                    decoration: getInputDecoration('Phone no'),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  TextFormField(
                    controller: controller.companyNameController,
                    decoration: getInputDecoration('Company name'),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  TextFormField(
                    controller: controller.jobTitleController,
                    decoration: getInputDecoration('Job title'),
                  ),
                  SizedBox(height: screenHeight * 0.06),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme.primary,
                      foregroundColor: colorScheme.onPrimary,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                      minimumSize: Size(double.infinity, screenHeight * 0.07),
                    ),
                    onPressed: () {
                      if (controller.formKey.currentState!.validate()) {
                        controller.addContact();
                      }
                    },
                    child: Obx(() => controller.isLoading.value?CircularProgressIndicator(color: colorScheme.background,):const Text('Create')),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}