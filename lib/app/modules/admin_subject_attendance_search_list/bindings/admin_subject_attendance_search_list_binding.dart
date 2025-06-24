import 'package:get/get.dart';

import '../controllers/admin_subject_attendance_search_list_controller.dart';

class AdminSubjectAttendanceSearchListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminSubjectAttendanceSearchListController>(
      () => AdminSubjectAttendanceSearchListController(),
    );
  }
}
