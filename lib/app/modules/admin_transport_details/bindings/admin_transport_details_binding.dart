import 'package:get/get.dart';

import '../controllers/admin_transport_details_controller.dart';

class AdminTransportDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminTransportDetailsController>(
      () => AdminTransportDetailsController(),
    );
  }
}
