import 'package:get/get.dart';

import '../controllers/student_homework_controller.dart';

class StudentHomeworkBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<StudentHomeworkController>(
      StudentHomeworkController(),
    );
  }
}
