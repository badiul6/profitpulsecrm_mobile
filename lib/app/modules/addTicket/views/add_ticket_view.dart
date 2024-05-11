import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profitpulsecrm_mobile/app/views/search_field_view.dart';
import '../controllers/add_ticket_controller.dart';

class AddTicketView extends GetView<AddTicketController> {
  const AddTicketView({super.key});

  @override
  Widget build(BuildContext context) {
    

    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    InputDecoration getInputDecoration(String labelText) {
      return InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: colorScheme.onSurface),
                        floatingLabelStyle: TextStyle(color: colorScheme.primary),

        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colorScheme.onSurface.withOpacity(0.5)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colorScheme.primary, width: 2.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colorScheme.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colorScheme.error, width: 2.5),
        ),
        border: OutlineInputBorder(),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Ticket'),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: screenHeight * 0.04,
            right: screenWidth * 0.03,
            left: screenWidth * 0.03,
          ),
          child: Center(
            child: Form(
              key: controller.formKey,
              child: Column(
                children: [
                  Text(
                    'Create new ticket',
                    style: TextStyle(fontSize: 22, color: colorScheme.onBackground),
                  ),
                  SizedBox(height: screenHeight * 0.05),
                  TextFormField(
                    controller: controller.issueController,
                    validator: controller.validateIssue,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: getInputDecoration('Issue'),
                  ),
                  SizedBox(height: screenHeight * 0.04),
                  SearchFieldView(
                    validEmails: controller.contacts,
                    labelText: 'Contact email',
                    getInput: (selectedEmail) {
                      controller.contactEmail.value= selectedEmail;
                    },
                  ),
                  SizedBox(height: screenHeight * 0.06),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme.primary,
                      foregroundColor: colorScheme.onPrimary,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)
                      ),
                      minimumSize: Size(double.infinity, screenHeight * 0.07),
                    ),
                    onPressed: () {
                      if (controller.formKey.currentState!.validate()) {
                        controller.addTicket();
                      }
                    },
                    child: Obx(() => controller.isLoading.value? CircularProgressIndicator(color: colorScheme.background,):const Text('Create')),
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