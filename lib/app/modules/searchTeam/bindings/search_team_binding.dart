import 'package:get/get.dart';

import '../controllers/search_team_controller.dart';

class SearchTeamBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchTeamController>(
      () => SearchTeamController(),
    );
  }
}
