import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenHeight = mediaQueryData.size.height;
    double screenWidth = mediaQueryData.size.width;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
        body: SingleChildScrollView(
      child: SafeArea(
        child: Center(
          child: Form(
            key: controller.formKey,
            child: Padding(
              padding: EdgeInsets.only(
                  top: screenHeight * 0.05,
                  right: screenWidth * 0.03,
                  left: screenWidth * 0.03),
              child: Column(
                children: [
                  const Text('Profit Pulse', style: TextStyle(fontSize: 36)),
                  SizedBox(
                    height: screenHeight * 0.03,
                  ),
                  const Text('Complete your profile',
                      style: TextStyle(fontSize: 28)),
                  SizedBox(
                    height: screenHeight * 0.008,
                  ),
                  Text(
                    'Please provide company detail to start using ProfitPulse',
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 12, color: colorScheme.secondary),
                  ),
                  SizedBox(
                    height: screenHeight * 0.03,
                  ),
                  TextFormField(
                    controller: controller.nameController,
                    validator: controller.validateName,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Company name',
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: controller.emailController,
                          validator: controller.validateEmail,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Email address',
                          ),
                        ),
                      ),
                      SizedBox(
                        width: screenWidth * 0.02,
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: controller.phoneController,
                          validator: controller.validatePhone,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Phone number',
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: controller.websiteController,
                          validator: controller.validateUrl,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Website link',
                          ),
                        ),
                      ),
                      SizedBox(
                        width: screenWidth * 0.02,
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: controller.socialController,
                          validator: controller.validateUrl,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Social link',
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  TextFormField(
                    controller: controller.addressController,
                    validator: controller.validateAddress,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Company address',
                    ),
                    keyboardType: TextInputType.multiline,
                    maxLines:
                        null, // Allows the input field to expand vertically.
                    textInputAction: TextInputAction.newline,
                  ),
                  SizedBox(
                    height: screenHeight * 0.05,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          foregroundColor: colorScheme.background,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          minimumSize: Size(
                            double.infinity,
                            screenHeight * 0.07,
                          )),
                      onPressed: () {
                        if (controller.formKey.currentState!.validate()) {}
                      },
                      child: const Text('Create'))
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
