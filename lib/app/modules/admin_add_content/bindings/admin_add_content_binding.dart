import 'package:get/get.dart';

import '../controllers/admin_add_content_controller.dart';

class AdminAddContentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminAddContentController>(
      () => AdminAddContentController(),
    );
  }
}
