import 'package:get/get.dart';

import '../controllers/admin_attendance_controller.dart';

class AdminAttendanceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminAttendanceController>(
      () => AdminAttendanceController(),
    );
  }
}
