import 'package:get/get.dart';

import '../controllers/admin_content_list_controller.dart';

class AdminContentListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminContentListController>(
      () => AdminContentListController(),
    );
  }
}
