import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AssignAgentController extends GetxController {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    RxBool isSelected=false.obs;
  
  @override
  void onClose() {
    super.onClose();
  }

}
