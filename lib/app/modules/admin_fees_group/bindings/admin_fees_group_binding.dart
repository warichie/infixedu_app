import 'package:get/get.dart';

import '../controllers/admin_fees_group_controller.dart';

class AdminFeesGroupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminFeesGroupController>(
      () => AdminFeesGroupController(),
    );
  }
}
