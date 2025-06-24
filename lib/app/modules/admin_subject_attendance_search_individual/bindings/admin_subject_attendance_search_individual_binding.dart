import 'package:get/get.dart';

import '../controllers/admin_subject_attendance_search_individual_controller.dart';

class AdminSubjectAttendanceSearchIndividualBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminSubjectAttendanceSearchIndividualController>(
      () => AdminSubjectAttendanceSearchIndividualController(),
    );
  }
}
