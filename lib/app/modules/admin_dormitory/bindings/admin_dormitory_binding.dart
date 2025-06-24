import 'package:get/get.dart';

import '../controllers/admin_dormitory_controller.dart';

class AdminDormitoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminDormitoryController>(
      () => AdminDormitoryController(),
    );
  }
}
