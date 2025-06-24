import 'package:get/get.dart';

import '../controllers/admin_fees_type_controller.dart';

class AdminFeesTypeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminFeesTypeController>(
      () => AdminFeesTypeController(),
    );
  }
}
