import 'package:get/get.dart';

import '../controllers/admin_library_controller.dart';

class AdminLibraryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminLibraryController>(
      () => AdminLibraryController(),
    );
  }
}
