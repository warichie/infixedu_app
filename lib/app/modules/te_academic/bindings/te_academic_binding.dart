import 'package:get/get.dart';

import '../controllers/te_academic_controller.dart';

class TeAcademicBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TeAcademicController>(
      () => TeAcademicController(),
    );
  }
}
