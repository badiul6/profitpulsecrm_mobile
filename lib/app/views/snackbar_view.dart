import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum SnackbarType { success, error }

class SnackbarHelper {
  static void showCustomSnackbar({
    required String title,
    required String message,
    SnackbarType type = SnackbarType.success,
  }) {
    Widget icon;
    switch (type) {
      case SnackbarType.success:
        icon = Container(
          padding: const EdgeInsets.all(2),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color.fromRGBO(0, 117, 124, 1),
          ),
          child: const Icon(
            Icons.done,
            size: 18,
            color: Colors.white,
          ),
        );
        break;
      case SnackbarType.error:
        icon = const Icon(Icons.error, color: Colors.red);
        break;
    }
    Get.snackbar(title, message,
        icon: icon,
        shouldIconPulse: false,
        messageText: Text(
          message,
          style: const TextStyle(color: Colors.black),
        ));
  }
}
