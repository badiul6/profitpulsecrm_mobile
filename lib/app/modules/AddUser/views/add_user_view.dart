import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/add_user_controller.dart';

class AddUserView extends GetView<AddUserController> {
  const AddUserView({super.key});

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
        title: const Text('Add User'),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
              top: screenHeight * 0.035,
              right: screenWidth * 0.03,
              left: screenWidth * 0.03),
          child: Center(
            child: Form(
              key: controller.formKey,
              child: Column(
                children: [
                  Text(
                    'Add a member to your team',
                    style: TextStyle(fontSize: 22, color: colorScheme.onBackground),
                  ),
                  SizedBox(
                    height: screenHeight * 0.05,
                  ),
                  TextFormField(
                    controller: controller.emailController,
                    validator: controller.validateEmail,
                    decoration: getInputDecoration('Email address'),
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  TextFormField(
                    controller: controller.fullnameController,
                    validator: controller.validateFullname,
                    decoration: getInputDecoration('Full name'),
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  DropdownButtonFormField<String>(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a member role';
                      }
                      return null;
                    },
                    decoration: getInputDecoration('Select member Role'),
                    value: controller.selectedRoleKey.value.isEmpty ? null : controller.selectedRoleKey.value,
                    onChanged: (String? newValue) {
                      if(newValue != null){
                        controller.selectedRoleKey.value = newValue;
                      }
                    },
                    items: controller.memberRoles.entries.map((entry) {
                      return DropdownMenuItem<String>(
                        value: entry.key,
                        child: Text(entry.value, style: TextStyle(color: colorScheme.onSurface)),
                      );
                    }).toList(),
                  ),
                  SizedBox(
                    height: screenHeight * 0.06,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme.primary,
                      foregroundColor: colorScheme.onPrimary,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                      minimumSize: Size(double.infinity, screenHeight * 0.07),
                    ),
                    onPressed: () {
                      if (controller.formKey.currentState!.validate()) {
                        controller.addUser();
                      }
                    },
                    child:  Obx(() => controller.isLoading.value? CircularProgressIndicator(color: colorScheme.background,):const Text('Create'),),
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