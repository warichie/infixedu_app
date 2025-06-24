import 'package:get/get.dart';

import '../controllers/admin_students_search_controller.dart';

class AdminStudentsSearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AdminStudentsSearchController>(
       AdminStudentsSearchController(),
    );
  }
}
