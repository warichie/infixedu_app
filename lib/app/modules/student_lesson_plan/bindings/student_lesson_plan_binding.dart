import 'package:get/get.dart';

import '../controllers/student_lesson_plan_controller.dart';

class StudentLessonPlanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StudentLessonPlanController>(
      () => StudentLessonPlanController(),
    );
  }
}
