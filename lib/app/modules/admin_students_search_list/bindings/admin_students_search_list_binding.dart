import 'package:get/get.dart';

import '../controllers/admin_students_search_list_controller.dart';

class AdminStudentsSearchListBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AdminStudentsSearchListController>(
      AdminStudentsSearchListController(),
    );
  }
}
