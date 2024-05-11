
import 'dart:async';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:profitpulsecrm_mobile/app/routes/app_pages.dart';

class SplashScreenController extends GetxController {

    final storage = const FlutterSecureStorage();
    RxBool isStart= true.obs;

  @override
  void onInit() {
    super.onInit();
    Timer(const Duration(seconds: 3),()async{

         String? cookie= await storage.read(key: 'cookie');
         String? role= await storage.read(key: 'role');
         String? isCompleted= await storage.read(key: 'isCompleted');
         if(cookie!= null&& isCompleted!= null && role!= null){
          if(isCompleted=='true'){
            Get.offAllNamed(Routes.MAIN);
          }else if(isCompleted=='false'){
            Get.offAllNamed(Routes.PROFILE);
          }
         }else{
          Get.offAllNamed(Routes.HOME);
         }

        });
  }
}
