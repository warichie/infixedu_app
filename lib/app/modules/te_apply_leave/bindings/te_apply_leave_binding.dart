import 'package:get/get.dart';

import '../controllers/te_apply_leave_controller.dart';

class TeApplyLeaveBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TeApplyLeaveController>(
      () => TeApplyLeaveController(),
    );
  }
}
