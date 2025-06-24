import 'package:get/get.dart';

import '../controllers/admin_add_member_controller.dart';

class AdminAddMemberBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminAddMemberController>(
      () => AdminAddMemberController(),
    );
  }
}
