import 'package:get/get.dart';

import '../controllers/add_sale_controller.dart';

class AddSaleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddSaleController>(
      () => AddSaleController(),
    );
  }
}
