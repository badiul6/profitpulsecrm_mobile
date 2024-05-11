import 'package:get/get.dart';

import '../controllers/search_deal_controller.dart';

class SearchDealBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchDealController>(
      () => SearchDealController(),
    );
  }
}
