import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:profitpulsecrm_mobile/app/data/login_response.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginController extends GetxController {


  RxBool isPasswordVisible = false.obs;
  RxBool isLoading = false.obs;
  final serverUrl = dotenv.env['SERVERURL'];

  final storage = const FlutterSecureStorage();


  Future<int> login({required String email, required String password}) async {
    isLoading.value = true;
    var body = jsonEncode({
      'email': email,
      'password': password,
    });
    try {
      var response = await http.post(Uri.parse('$serverUrl/auth/login'),
          headers: {
            "Content-Type": "application/json",
          },
          body: body);
      isLoading.value = false;

      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        //saving cookie
        var auth = response.headers['set-cookie'];
        await storage.write(key: 'cookie', value: auth);

        var loginResponse = LoginResponse.fromJson(data);
        //saving role
        if (loginResponse.roles.contains('OWNER')) {
          await storage.write(key: 'role', value: 'OWNER');
        } else if (loginResponse.roles.contains('MAGENT')) {
          await storage.write(key: 'role', value: 'MAGENT');
        } else if (loginResponse.roles.contains('SHEAD')) {
          await storage.write(key: 'role', value: 'SHEAD');
        } else if (loginResponse.roles.contains('SAGENT')) {
          await storage.write(key: 'role', value: 'SAGENT');
        } else if (loginResponse.roles.contains('CSAGENT')) {
          await storage.write(key: 'role', value: 'CSAGENT');
        }

        if (!loginResponse.isCompleted) {
          await storage.write(key: 'isCompleted', value: 'false');
          return 204;
        }
        await storage.write(key: 'isCompleted', value: 'true');
      }
      return response.statusCode;
    } catch (e) {
      isLoading.value = false;

      return 400;
    }
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

  String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password cannot be empty';
    }
    final regexUppercase = RegExp(r'[A-Z]');
    final regexLowercase = RegExp(r'[a-z]');
    final regexDigit = RegExp(r'[0-9]');
    final regexSpecial = RegExp(r'[#?!@$%^&*-]');
    if (password.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    if (!regexUppercase.hasMatch(password)) {
      return 'Password must contain at least one uppercase letter';
    }
    if (!regexLowercase.hasMatch(password)) {
      return 'Password must contain at least one lowercase letter';
    }
    if (!regexDigit.hasMatch(password)) {
      return 'Password must contain at least one number';
    }
    if (!regexSpecial.hasMatch(password)) {
      return 'Password must contain at least one special character';
    }
    return null;
  }

}
