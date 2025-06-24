import 'package:get/get.dart';

import '../controllers/admin_subject_attendance_search_individual_list_controller.dart';

class AdminSubjectAttendanceSearchIndividualListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminSubjectAttendanceSearchIndividualListController>(
      () => AdminSubjectAttendanceSearchIndividualListController(),
    );
  }
}
