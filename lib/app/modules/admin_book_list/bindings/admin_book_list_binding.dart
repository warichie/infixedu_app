import 'package:get/get.dart';

import '../controllers/admin_book_list_controller.dart';

class AdminBookListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminBookListController>(
      () => AdminBookListController(),
    );
  }
}
