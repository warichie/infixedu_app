import 'package:get/get.dart';

import '../controllers/dormitory_controller.dart';

class DormitoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<DormitoryController>(
      DormitoryController(),
    );
  }
}
