import 'package:get/get.dart';

import '../controllers/admin_assign_vehicle_controller.dart';

class AdminAssignVehicleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminAssignVehicleController>(
      () => AdminAssignVehicleController(),
    );
  }
}
