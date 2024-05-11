import 'package:get/get.dart';

import '../controllers/search_agent_deal_controller.dart';

class SearchAgentDealBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchAgentDealController>(
      () => SearchAgentDealController(),
    );
  }
}
