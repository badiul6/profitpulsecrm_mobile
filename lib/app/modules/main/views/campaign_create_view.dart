import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profitpulsecrm_mobile/app/modules/main/controllers/main_controller.dart';

class CampaignCreateView extends GetView<MainController> {
  const CampaignCreateView({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    InputDecoration _getInputDecoration(String labelText) {
      return InputDecoration(
        labelText: labelText,
                                        floatingLabelStyle: TextStyle(color: colorScheme.primary),

        labelStyle: TextStyle(color: colorScheme.onSurface),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: colorScheme.onSurface.withOpacity(0.5)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colorScheme.onSurface.withOpacity(0.5)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colorScheme.primary, width: 2.0),
        ),
      );
    }

    return AlertDialog(
      title: Text('Start a new campaign'),
      backgroundColor: colorScheme.surface,
      content: SingleChildScrollView(
        child: Form(
          key: controller.campaignFormKey,
          child: TextFormField(
            controller: controller.campaignController,
            validator: controller.validatecampaign,
            decoration: _getInputDecoration('Campaign Name'),
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Cancel', style: TextStyle(color: colorScheme.error)),
          onPressed: () {
            controller.campaignController.clear();
            Navigator.of(context).pop(); // dismiss dialog
          },
        ),
        TextButton(
          child: Text('Save', style: TextStyle(color: colorScheme.primary)),
          onPressed: () {
            if (controller.campaignFormKey.currentState!.validate()) {
              // Handle save action
              Navigator.of(context).pop(); // Optionally close the dialog on save
            }
          },
        ),
      ],
    );
  }
}