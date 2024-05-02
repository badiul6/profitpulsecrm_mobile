import 'package:get/get.dart';

import '../controllers/add_deal_controller.dart';

class AddDealBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddDealController>(
      () => AddDealController(),
    );
  }
}
