import 'package:get/get.dart';

import '../controllers/te_homework_evaluation_controller.dart';

class TeHomeworkEvaluationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TeHomeworkEvaluationController>(
      () => TeHomeworkEvaluationController(),
    );
  }
}
