import 'package:get/get.dart';

import '../controllers/te_subjects_controller.dart';

class TeSubjectsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TeSubjectsController>(
      () => TeSubjectsController(),
    );
  }
}
