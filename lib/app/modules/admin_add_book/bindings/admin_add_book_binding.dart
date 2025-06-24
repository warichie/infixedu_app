import 'package:get/get.dart';

import '../controllers/admin_add_book_controller.dart';

class AdminAddBookBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminAddBookController>(
      () => AdminAddBookController(),
    );
  }
}
