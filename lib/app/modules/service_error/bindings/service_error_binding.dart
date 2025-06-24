import 'package:get/get.dart';

import '../controllers/service_error_controller.dart';

class ServiceErrorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ServiceErrorController>(
      () => ServiceErrorController(),
    );
  }
}
