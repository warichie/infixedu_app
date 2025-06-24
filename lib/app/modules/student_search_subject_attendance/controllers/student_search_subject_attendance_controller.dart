import 'package:infixedu/app/modules/subjects/controllers/subjects_controller.dart';
import 'package:get/get.dart';

import '../../../utilities/widgets/loader/loading.controller.dart';
import '../../home/controllers/home_controller.dart';

class StudentSearchSubjectAttendanceController extends GetxController {
  LoadingController loadingController = Get.find();
  HomeController homeController = Get.find();
  SubjectsController subjectsController = Get.put(SubjectsController());

  final selectIndex = RxInt(0);

  RxInt recordId = 0.obs;

  @override
  void onInit() {
    recordId.value = homeController.studentRecordList[0].id;
    super.onInit();
  }
}
