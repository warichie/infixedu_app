import 'package:infixedu/app/modules/admin_students_search/controllers/admin_students_search_controller.dart';
import 'package:infixedu/config/global_variable/global_variable_controller.dart';
import 'package:infixedu/domain/core/model/admin/admin_student_model/admin_student_search_response_model.dart';
import 'package:get/get.dart';

class AdminStudentsSearchListController extends GetxController {
  GlobalRxVariableController globalRxVariableController = Get.find();
  AdminStudentsSearchController adminStudentsSearchController = Get.find();
  List<StudentSearchData>? studentData;

  @override
  void onInit() {
    studentData = Get.arguments['search_data'];

    super.onInit();
  }
}
