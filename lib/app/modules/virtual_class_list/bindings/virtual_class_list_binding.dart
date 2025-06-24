import 'package:get/get.dart';

import '../controllers/virtual_class_list_controller.dart';

class VirtualClassListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VirtualClassListController>(
      () => VirtualClassListController(),
    );
  }
}
