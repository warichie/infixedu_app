import 'package:get/get.dart';

import '../controllers/admin_class_attendance_search_controller.dart';

class AdminClassAttendanceSearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminClassAttendanceSearchController>(
      () => AdminClassAttendanceSearchController(),
    );
  }
}
