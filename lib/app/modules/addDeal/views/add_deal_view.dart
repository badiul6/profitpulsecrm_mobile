import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profitpulsecrm_mobile/app/views/search_field_view.dart';
import '../controllers/add_deal_controller.dart';

class AddDealView extends GetView<AddDealController> {
  const AddDealView({super.key});

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Deal'),
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                top: screenHeight * 0.02,
                right: screenWidth * 0.03,
                left: screenWidth * 0.03),
            child: Center(
              child: Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    Text(
                      'Create new deal',
                      style: TextStyle(fontSize: 22, color: colorScheme.onBackground),
                    ),
                    SizedBox(height: screenHeight * 0.04),
                   SearchFieldView(
                      validEmails: controller.salesAgents,
                      labelText: 'Agent email',
                      getInput: (selectedEmail) {
                        controller.agentEmail.value=selectedEmail;
                      },
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    SearchFieldView(
                      validEmails: controller.contacts,
                      labelText: 'Contact email',
                      getInput: (selectedEmail) {
                        controller.contactEmail.value=selectedEmail;
                      },
                    ),
                    SizedBox(height: screenHeight * 0.06),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: colorScheme.primary,
                            foregroundColor: colorScheme.onPrimary,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            minimumSize: Size(
                              double.infinity,
                              screenHeight * 0.07,
                            )),
                        onPressed: () {
                          if (controller.formKey.currentState!.validate()) {
                          controller.addDeal();
                          }
                        },
                        child: Obx(() => controller.isLoading.value? CircularProgressIndicator(color: colorScheme.background,): const Text('Create'))),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}