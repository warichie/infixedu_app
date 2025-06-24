import 'package:get/get.dart';

import '../controllers/book_issued_controller.dart';

class BookIssuedBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BookIssuedController>(
      () => BookIssuedController(),
    );
  }
}
