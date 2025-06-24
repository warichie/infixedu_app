import 'package:get/get.dart';

import '../controllers/admin_class_attendance_search_individual_list_controller.dart';

class AdminClassAttendanceSearchIndividualListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminClassAttendanceSearchIndividualListController>(
      () => AdminClassAttendanceSearchIndividualListController(),
    );
  }
}
