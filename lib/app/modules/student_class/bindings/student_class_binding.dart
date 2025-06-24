import 'package:get/get.dart';

import '../controllers/student_class_controller.dart';

class StudentClassBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StudentClassController>(
      () => StudentClassController(),
    );
  }
}
