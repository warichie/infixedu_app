import 'package:get/get.dart';

import '../controllers/te_homework_list_controller.dart';

class TeHomeworkListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TeHomeworkListController>(
      () => TeHomeworkListController(),
    );
  }
}
