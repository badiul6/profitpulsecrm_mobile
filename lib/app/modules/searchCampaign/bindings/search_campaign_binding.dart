import 'package:get/get.dart';

import '../controllers/search_campaign_controller.dart';

class SearchCampaignBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchCampaignController>(
      () => SearchCampaignController(),
    );
  }
}
