import 'package:get/get.dart';

import '../controllers/student_search_attendance_controller.dart';

class StudentSearchAttendanceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StudentSearchAttendanceController>(
      () => StudentSearchAttendanceController(),
    );
  }
}
