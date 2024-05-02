import 'package:get/get.dart';

import '../controllers/assign_agent_controller.dart';

class AssignAgentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AssignAgentController>(
      () => AssignAgentController(),
    );
  }
}
