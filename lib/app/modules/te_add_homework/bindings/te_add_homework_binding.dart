import 'package:get/get.dart';

import '../controllers/te_add_homework_controller.dart';

class TeAddHomeworkBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TeAddHomeworkController>(
      () => TeAddHomeworkController(),
    );
  }
}
