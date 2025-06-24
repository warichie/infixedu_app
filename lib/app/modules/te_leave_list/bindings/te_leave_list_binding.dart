import 'package:get/get.dart';

import '../controllers/te_leave_list_controller.dart';

class TeLeaveListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TeLeaveListController>(
      () => TeLeaveListController(),
    );
  }
}
