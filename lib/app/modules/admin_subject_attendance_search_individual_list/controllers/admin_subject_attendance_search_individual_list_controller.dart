import 'package:infixedu/domain/core/model/admin/admin_attendance_model/admin_sub_atten_search_individual_response_model.dart';
import 'package:get/get.dart';

class AdminSubjectAttendanceSearchIndividualListController
    extends GetxController {
  RxList<AdminSubAttenStudents> adminSubAttendanceList =
      <AdminSubAttenStudents>[].obs;
  RxInt subjectNameId = 0.obs;

  @override
  void onInit() {
    adminSubAttendanceList = Get.arguments['search_data'];
    subjectNameId.value = Get.arguments['subject_name_id'];

    super.onInit();
  }
}
