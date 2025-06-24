import 'package:get/get.dart';

import '../controllers/student_search_subject_attendance_controller.dart';

class StudentSearchSubjectAttendanceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StudentSearchSubjectAttendanceController>(
      () => StudentSearchSubjectAttendanceController(),
    );
  }
}
