import 'package:get/get.dart';

import '../controllers/admin_fees_controller.dart';

class AdminFeesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminFeesController>(
      () => AdminFeesController(),
    );
  }
}
