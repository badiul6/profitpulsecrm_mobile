import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profitpulsecrm_mobile/app/modules/main/controllers/main_controller.dart';

class CampaignCreateView extends GetView<MainController> {
  CampaignCreateView({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    InputDecoration getInputDecoration(String labelText) {
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
      title: const Text('Start a new campaign'),
      backgroundColor: colorScheme.surface,
      content: Form(
        key: _formKey,
        child: TextFormField(
          controller: controller.campaignController,
          validator: controller.validatecampaign,
          decoration: getInputDecoration('Campaign Name'),
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
        Obx(
          () => controller.isSavingCampaign.value
              ? CircularProgressIndicator(
                  color: colorScheme.primary,
                )
              : TextButton(
                  child: Text('Save',
                      style: TextStyle(color: colorScheme.primary)),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      controller.addCampaign();
                    }
                  },
                ),
        )
      ],
    );
  }
}
