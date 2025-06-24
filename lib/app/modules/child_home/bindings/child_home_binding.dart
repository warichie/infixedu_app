import 'package:get/get.dart';

import '../controllers/child_home_controller.dart';

class ChildHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChildHomeController>(
      () => ChildHomeController(),
    );
  }
}
