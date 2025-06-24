import 'package:get/get.dart';

import '../controllers/admin_class_attendance_search_individual_controller.dart';

class AdminClassAttendanceSearchIndividualBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminClassAttendanceSearchIndividualController>(
      () => AdminClassAttendanceSearchIndividualController(),
    );
  }
}
