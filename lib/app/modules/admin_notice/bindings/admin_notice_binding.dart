import 'package:get/get.dart';

import '../controllers/admin_notice_controller.dart';

class AdminNoticeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminNoticeController>(
      () => AdminNoticeController(),
    );
  }
}
