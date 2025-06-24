import 'package:get/get.dart';

import '../controllers/admin_vehicle_controller.dart';

class AdminVehicleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminVehicleController>(
      () => AdminVehicleController(),
    );
  }
}
