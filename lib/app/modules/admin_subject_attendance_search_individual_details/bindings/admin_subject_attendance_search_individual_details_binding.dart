import 'package:get/get.dart';

import '../controllers/admin_subject_attendance_search_individual_details_controller.dart';

class AdminSubjectAttendanceSearchIndividualDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminSubjectAttendanceSearchIndividualDetailsController>(
      () => AdminSubjectAttendanceSearchIndividualDetailsController(),
    );
  }
}
