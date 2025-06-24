import 'package:get/get.dart';

import '../controllers/te_search_class_routine_controller.dart';

class TeSearchClassRoutineBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TeSearchClassRoutineController>(
      () => TeSearchClassRoutineController(),
    );
  }
}
