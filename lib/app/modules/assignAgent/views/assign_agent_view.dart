import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profitpulsecrm_mobile/app/views/search_field_action_view.dart';
import 'package:profitpulsecrm_mobile/app/views/search_field_view.dart';
import '../controllers/assign_agent_controller.dart';

class AssignAgentView extends GetView<AssignAgentController> {
  const AssignAgentView({super.key});

  @override
  Widget build(BuildContext context) {
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
                    style: TextStyle(
                        fontSize: 22, color: colorScheme.onBackground),
                  ),
                  SizedBox(height: screenHeight * 0.04),
                  Obx(
                    () => SearchFieldActionView(
                      validEmails: controller.campaigns,
                      labelText: 'Search a campaign',
                      isAgentLoading: controller.isAgentLoading.value,
                      getInput: (selectedCampaign) {
                        controller.campaignName.value = selectedCampaign;
                        controller.getAllCampaignLeads(selectedCampaign);
                      },
                    ),
                  ),
                  Obx(() => Visibility(
                        visible: controller.isZeroLeads.value,
                        child: const Align(
                            alignment: Alignment.centerLeft,
                            child: Text('No lead available for this campaign')),
                      )),
                  SizedBox(height: screenHeight * 0.03),
                  Obx(() => Visibility(
                        visible: controller.isSelected.value,
                        child: SearchFieldView(
                          validEmails: controller.leads,
                          labelText: 'Search a lead',
                          getInput: (selectedEmail) {
                            controller.leadEmail.value = selectedEmail;
                          },
                        ),
                      )),
                  SizedBox(height: screenHeight * 0.03),
                  SearchFieldView(
                    validEmails: controller.saleAgents,
                    labelText: 'Search an agent',
                    getInput: (selectedEmail) {
                      controller.agentEmail.value = selectedEmail;
                    },
                  ),
                  SizedBox(height: screenHeight * 0.06),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: colorScheme.primary,
                          foregroundColor: colorScheme.onPrimary,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          minimumSize:
                              Size(double.infinity, screenHeight * 0.07)),
                      onPressed: () {
                        if (controller.formKey.currentState!.validate()) {
                          controller.assignAgent();
                        }
                      },
                      child: Obx(() => controller.isLoading.value
                          ? CircularProgressIndicator(
                              color: colorScheme.background,
                            )
                          : const Text('Assign'))),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
