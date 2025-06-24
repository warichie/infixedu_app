import 'package:infixedu/config/global_variable/global_variable_controller.dart';
import 'package:get/get.dart';

class StudentClassController extends GetxController {
  GlobalRxVariableController globalRxVariableController =
      Get.put(GlobalRxVariableController());

  RxBool isJitsiTapped = false.obs;
  RxBool isZoomTapped = false.obs;
  RxBool isGoogleMeetTap = false.obs;
  RxBool isBigBlueButtonTap = false.obs;
}
