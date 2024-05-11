import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:profitpulsecrm_mobile/app/views/snackbar_view.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenHeight = mediaQueryData.size.height;
    double screenWidth = mediaQueryData.size.width;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    InputDecoration getInputDecoration(String labelText) {
      return InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: colorScheme.onSurface),
        floatingLabelStyle: TextStyle(color: colorScheme.primary),
        border: const OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colorScheme.onSurface.withOpacity(0.5)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colorScheme.primary, width: 2.0),
        ),
      );
    }

    return Scaffold(
        body: SingleChildScrollView(
      child: SafeArea(
        child: Center(
          child: Form(
            key: controller.formKey,
            child: Padding(
              padding: EdgeInsets.only(
                  top: screenHeight * 0.05,
                  bottom: screenHeight * 0.05,
                  right: screenWidth * 0.03,
                  left: screenWidth * 0.03),
              child: Column(
                children: [
                  Text('Complete your profile',
                      style: TextStyle(
                          fontSize: 28, color: colorScheme.onBackground)),
                  SizedBox(height: screenHeight * 0.008),
                  Text(
                    'Please provide company detail to start using ProfitPulse',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 12, color: colorScheme.onBackground),
                  ),
                  SizedBox(height: screenHeight * 0.04),
                  Stack(
                    children: [
                      ClipOval(
                        child: Obx(() {
                          if (controller.selectedImage.value != null) {
                            return Image.file(
                              controller.selectedImage.value!,
                              height: screenHeight * 0.15,
                              width: screenHeight * 0.15,
                              fit: BoxFit.cover,
                            );
                          } else {
                            return SvgPicture.asset(
                              'assets/images/upload.svg',
                              height: screenHeight * 0.15,
                            );
                          }
                        }),
                      ),
                      Positioned(
                        bottom:
                            05, // Position the button at the bottom of the circle
                        right:
                            5, // Position the button on the right side of the circle
                        child: InkWell(
                          onTap: () {
                            controller.pickImage();
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: colorScheme.primary.withOpacity(
                                  0.8), // Background color of the button
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.camera_alt, // Add icon
                              size: 22, // Icon size can be adjusted
                              color: colorScheme.background
                                  .withOpacity(0.9), // Icon color
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  TextFormField(
                    controller: controller.nameController,
                    validator: controller.validateName,
                    decoration: getInputDecoration('Company name'),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: controller.emailController,
                          validator: controller.validateEmail,
                          decoration: getInputDecoration('Email address'),
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.02),
                      Expanded(
                        child: TextFormField(
                          controller: controller.phoneController,
                          validator: controller.validatePhone,
                          decoration: getInputDecoration('Phone number'),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: controller.websiteController,
                          validator: controller.validateUrl,
                          decoration: getInputDecoration('Website link'),
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.02),
                      Expanded(
                        child: TextFormField(
                          controller: controller.socialController,
                          validator: controller.validateUrl,
                          decoration: getInputDecoration('Social link'),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  TextFormField(
                    controller: controller.addressController,
                    validator: controller.validateAddress,
                    decoration: getInputDecoration('Company address'),
                    keyboardType: TextInputType.multiline,
                    maxLines:
                        null, // Allows the input field to expand vertically.
                    textInputAction: TextInputAction.newline,
                  ),
                  SizedBox(height: screenHeight * 0.05),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: colorScheme.primary,
                          foregroundColor: colorScheme.onPrimary,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          minimumSize:
                              Size(double.infinity, screenHeight * 0.07)),
                      onPressed: () async {
                        if (controller.selectedImage.value == null) {
                          SnackbarHelper.showCustomSnackbar(
                              title: "Error",
                              message: 'Company logo is required',
                              type: SnackbarType.error);
                        } else {
                         
                          if (controller.formKey.currentState!.validate()) {
                            controller.completeProfile();
                          }
                        }
                      },
                      child: Obx(() => controller.isLoading.value
                          ? CircularProgressIndicator(
                              color: colorScheme.background,
                            )
                          : Text('Create',
                              style: TextStyle(color: colorScheme.onPrimary))))
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
