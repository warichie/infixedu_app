import 'package:get/get.dart';

import '../controllers/parent_child_controller.dart';

class ParentChildBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ParentChildController>(
      () => ParentChildController(),
    );
  }
}
