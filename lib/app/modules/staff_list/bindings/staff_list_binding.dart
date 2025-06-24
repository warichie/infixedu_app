import 'package:get/get.dart';

import '../controllers/staff_list_controller.dart';

class StaffListBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<StaffListController>(
      StaffListController(),
    );
  }
}
