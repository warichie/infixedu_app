import 'package:get/get.dart';

import '../controllers/admin_class_set_attendance_controller.dart';

class AdminClassSetAttendanceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminClassSetAttendanceController>(
      () => AdminClassSetAttendanceController(),
    );
  }
}
