import 'package:infixedu/app/modules/syllabus/controller/syllabus_controller.dart';
import 'package:get/get.dart';

class SyllabusBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SyllabusController>(
      SyllabusController(),
    );
  }
}
