import 'package:flutter/animation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/utilities/app_functions/functionality.dart';
import 'package:infixedu/config/global_variable/global_variable_controller.dart';
import 'package:get/get.dart';
import '../../../database/auth_database.dart';
import '../../../routes/app_pages.dart';

class SplashController extends GetxController with GetTickerProviderStateMixin {
  GlobalRxVariableController globalRxVariableController = Get.find();

  @override
  void onInit() {
    _animation();
    navNextPage();
    super.onInit();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  Animation? animation;
  AnimationController? animationController;
  _animation() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation = Tween(begin: 10.0.w, end: 80.0.w).animate(animationController!);
    animationController?.forward();
  }

  void navNextPage() async {
    AuthDatabase authDatabase = AuthDatabase.instance;
    await 1000.milliseconds.delay();

    if (authDatabase.auth()) {
      globalRxVariableController.roleId.value =
          authDatabase.getUserInfo()!.data.user.roleId;
      globalRxVariableController.notificationCount.value =
          authDatabase.getUnReadNotification() ?? 0;
      globalRxVariableController.token.value = authDatabase.getToken()!;
      globalRxVariableController.userId.value =
          authDatabase.getUserInfo()!.data.user.id;
      globalRxVariableController.roleId.value =
          authDatabase.getUserInfo()!.data.user.roleId;
      globalRxVariableController.email.value =
          authDatabase.getUserInfo()!.data.user.email;
      globalRxVariableController.fullName.value =
          authDatabase.getUserInfo()!.data.user.fullName;

      AppFunctions().getFunctions(globalRxVariableController.roleId.value!);

      if (authDatabase.getUserInfo()!.data.user.roleId == 2) {
        globalRxVariableController.studentId.value =
            authDatabase.getUserInfo()!.data.user.studentId;
        globalRxVariableController.isStudent.value = true;
        globalRxVariableController.roleName.value = 'Student';
        debugPrint('Student Id ::: ${globalRxVariableController.studentId}');
      }

      if (authDatabase.getUserInfo()!.data.user.roleId == 3) {
        globalRxVariableController.parentId.value =
            authDatabase.getUserInfo()!.data.user.parentId;
        globalRxVariableController.roleName.value = 'Parent';
        debugPrint('Parent Id ::: ${globalRxVariableController.parentId}');
      }

      if (authDatabase.getUserInfo()!.data.user.roleId == 1 ||
          authDatabase.getUserInfo()!.data.user.roleId == 4) {
        globalRxVariableController.staffId.value =
            authDatabase.getUserInfo()!.data.user.staffId;
        authDatabase.getUserInfo()!.data.user.roleId == 1
            ? globalRxVariableController.roleName.value = 'Admin'
            : globalRxVariableController.roleName.value = 'Teacher';
        debugPrint(
            'Admin/Teacher Id ::: ${globalRxVariableController.staffId}');
      }
    } else {
      Get.offAndToNamed(Routes.LOGIN);
    }
  }
}
