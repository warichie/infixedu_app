import 'package:get/get.dart';

import '../controllers/admin_class_attendance_individual_details_controller.dart';

class AdminClassAttendanceIndividualDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminClassAttendanceIndividualDetailsController>(
      () => AdminClassAttendanceIndividualDetailsController(),
    );
  }
}
