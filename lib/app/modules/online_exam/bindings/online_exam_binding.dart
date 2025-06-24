import 'package:get/get.dart';

import '../controllers/online_exam_controller.dart';

class OnlineExamBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<OnlineExamController>(
       OnlineExamController(),
    );
  }
}
