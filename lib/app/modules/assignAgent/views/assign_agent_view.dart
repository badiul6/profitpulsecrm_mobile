import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profitpulsecrm_mobile/app/views/search_field_view.dart';
import '../controllers/assign_agent_controller.dart';

class AssignAgentView extends GetView<AssignAgentController> {
  const AssignAgentView({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> validEmails = [
      'example1@example.com',
      'example2@example.com',
      'info@example.com',
      'contact@example.com',
      // Add more emails as needed
    ];
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Assign Agent'),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
              top: screenHeight * 0.04,
              right: screenWidth * 0.03,
              left: screenWidth * 0.03),
          child: Center(
            child: Form(
              key: controller.formKey,
              child: Column(
                children: [
                  Text(
                    'Assign an agent to a lead',
                    style: TextStyle(fontSize: 22, color: colorScheme.onBackground),
                  ),
                  SizedBox(height: screenHeight * 0.04),
                  SearchFieldView(
                    validEmails: validEmails,
                    labelText: 'Campaign Name',
                    getInput: (selectedEmail) {
                      print("Selected Email: $selectedEmail");
                      // Perform other actions
                    },
                    isSelected: (bool isSelected) {
                      controller.isSelected.value = isSelected;
                    },
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  Obx(() => Visibility(
                        visible: controller.isSelected.value,
                        child: SearchFieldView(
                          validEmails: validEmails,
                          labelText: 'Contact email',
                          getInput: (selectedEmail) {
                            print("Selected Email: $selectedEmail");
                            // Perform other actions
                          },
                        ),
                      )),
                  SizedBox(height: screenHeight * 0.03),
                  SearchFieldView(
                    validEmails: validEmails,
                    labelText: 'Agent email',
                    getInput: (selectedEmail) {
                      print("Selected Email: $selectedEmail");
                      // Perform other actions
                    },
                  ),
                  SizedBox(height: screenHeight * 0.06),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: colorScheme.primary,
                          onPrimary: colorScheme.onPrimary,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                          minimumSize: Size(double.infinity, screenHeight * 0.07)),
                      onPressed: () {
                        if (controller.formKey.currentState!.validate()) {
                          // Form submission logic
                        }
                      },
                      child: const Text('Assign')),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}