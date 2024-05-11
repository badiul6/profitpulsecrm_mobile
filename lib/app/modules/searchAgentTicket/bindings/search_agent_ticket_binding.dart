import 'package:get/get.dart';

import '../controllers/search_agent_ticket_controller.dart';

class SearchAgentTicketBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchAgentTicketController>(
      () => SearchAgentTicketController(),
    );
  }
}
