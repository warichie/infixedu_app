import 'package:get/get.dart';

import '../controllers/te_homework_controller.dart';

class TeHomeworkBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<TeHomeworkController>(
      TeHomeworkController(),
    );

  }
}
