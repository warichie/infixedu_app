import 'package:get/get.dart';

import '../controllers/admin_transport_controller.dart';

class AdminTransportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminTransportController>(
      () => AdminTransportController(),
    );
  }
}
