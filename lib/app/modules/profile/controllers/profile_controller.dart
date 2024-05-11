import 'dart:convert';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:profitpulsecrm_mobile/app/routes/app_pages.dart';
import 'package:profitpulsecrm_mobile/app/views/snackbar_view.dart';

class ProfileController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController websiteController = TextEditingController();
  TextEditingController socialController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RxBool isLoading = false.obs;
  final serverUrl = dotenv.env['SERVERURL'];
  final storage = const FlutterSecureStorage();
  Rx<File?> selectedImage = Rx<File?>(null);

  Future<void> completeProfile() async {
    var uri = Uri.parse("$serverUrl/profile/complete");
    isLoading.value = true;
    String? cookie = await getCookie(); // Retrieve the saved cookie

    if (cookie == null) {
      Get.offAllNamed(Routes.LOGIN);
      SnackbarHelper.showCustomSnackbar(
          title: 'Session Expired',
          message: 'Please login to continue',
          type: SnackbarType.error);
      return;
    }
    var request = http.MultipartRequest('POST', uri)
      ..headers['Cookie'] = cookie // Include the cookie here
      ..fields['name'] = nameController.text
      ..fields['email'] = emailController.text
      ..fields['contact'] = phoneController.text
      ..fields['website_link'] = websiteController.text
      ..fields['address'] = addressController.text
      ..fields['social_link'] = socialController.text;

    if (selectedImage.value != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'logo',
        selectedImage.value!.path,
      ));
    }
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    isLoading.value = false;

    if (response.statusCode == 201) {
      Get.offAllNamed(Routes.MAIN);
      SnackbarHelper.showCustomSnackbar(
          title: 'Success',
          message: 'Profile successfully updated',
          type: SnackbarType.success);
    } else if (response.statusCode == 403) {
      Get.offAllNamed(Routes.LOGIN);
      SnackbarHelper.showCustomSnackbar(
          title: 'Session Expired',
          message: 'Please login to continue',
          type: SnackbarType.error);
    } else {
      SnackbarHelper.showCustomSnackbar(
          title: 'Error',
          message: 'Failed to update profile',
          type: SnackbarType.error);
    }
  }

  Future<String?> getCookie() async {
    return await storage.read(key: "cookie");
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 85);

    if (image != null) {
      if (image.path.endsWith('.jpeg') ||
          image.path.endsWith('.jpg') ||
          image.path.endsWith('.png')) {
        selectedImage.value = File(image.path);
      } else {
        SnackbarHelper.showCustomSnackbar(
            title: "Unsupported format",
            message: "Please select a JPEG or PNG image.",
            type: SnackbarType.error);
      }
    }
  }

  String? validatePhone(String? phone) {
    if (phone == null || phone.isEmpty) {
      return 'Please enter your phone number';
    }
    bool isValidPhone = RegExp(r'^\+?\d+$').hasMatch(phone);

    if (!isValidPhone) {
      return 'Invalid phone number';
    }
    return null;
  }

  String? validateUrl(String? url) {
    if (url == null || url.isEmpty) {
      return "Url can't be empty";
    }
    bool isValidUrl = RegExp(
            r'^https?:\/\/[\w\-]+(\.[\w\-]+)+[\w\-.,@?^=%&:/~+#]*[\w\-@?^=%&/~+#]$')
        .hasMatch(url);

    if (!isValidUrl) {
      return 'Invalid url';
    }
    return null;
  }

  String? validateName(String? fullname) {
    if (fullname == null || fullname.isEmpty) {
      return 'Please enter company name';
    }
    return null;
  }

  String? validateAddress(String? address) {
    if (address == null || address.isEmpty) {
      return 'Please enter company address';
    }
    return null;
  }

  String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Please enter your email';
    }
    bool isValidEmail =
        RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);

    if (!isValidEmail) {
      return 'Invalid email address';
    }
    return null;
  }

  @override
  void onClose() {
    super.onClose();
  }
}
