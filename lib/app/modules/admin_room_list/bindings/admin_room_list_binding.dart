import 'package:get/get.dart';

import '../controllers/admin_room_list_controller.dart';

class AdminRoomListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminRoomListController>(
      () => AdminRoomListController(),
    );
  }
}
