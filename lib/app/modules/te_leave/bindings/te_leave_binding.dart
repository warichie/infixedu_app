import 'package:get/get.dart';

import '../controllers/te_leave_controller.dart';

class TeLeaveBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TeLeaveController>(
      () => TeLeaveController(),
    );
  }
}
