import 'package:get/get.dart';

import '../controllers/admin_add_room_controller.dart';

class AdminAddRoomBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminAddRoomController>(
      () => AdminAddRoomController(),
    );
  }
}
