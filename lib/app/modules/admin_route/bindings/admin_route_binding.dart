import 'package:get/get.dart';

import '../controllers/admin_route_controller.dart';

class AdminRouteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminRouteController>(
      () => AdminRouteController(),
    );
  }
}
