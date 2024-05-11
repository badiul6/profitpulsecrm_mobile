import 'package:get/get.dart';

import '../controllers/search_ticket_controller.dart';

class SearchTicketBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchTicketController>(
      () => SearchTicketController(),
    );
  }
}
