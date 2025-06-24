import 'package:get/get.dart';

import '../controllers/admin_add_dormitory_controller.dart';

class AdminAddDormitoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminAddDormitoryController>(
      () => AdminAddDormitoryController(),
    );
  }
}
