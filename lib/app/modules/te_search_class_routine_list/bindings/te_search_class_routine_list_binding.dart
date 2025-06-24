import 'package:get/get.dart';

import '../controllers/te_search_class_routine_list_controller.dart';

class TeSearchClassRoutineListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TeSearchClassRoutineListController>(
      () => TeSearchClassRoutineListController(),
    );
  }
}
