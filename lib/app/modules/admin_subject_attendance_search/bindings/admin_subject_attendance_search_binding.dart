import 'package:get/get.dart';

import '../controllers/admin_subject_attendance_search_controller.dart';

class AdminSubjectAttendanceSearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminSubjectAttendanceSearchController>(
      () => AdminSubjectAttendanceSearchController(),
    );
  }
}
