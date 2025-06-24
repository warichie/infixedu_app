import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/modules/admin_attendance/views/admin_attendance_view.dart';
import 'package:infixedu/app/modules/child_home/views/child_home_view.dart';
import 'package:infixedu/app/modules/fees/views/fees_view.dart';
import 'package:infixedu/app/modules/home/views/home_view.dart';
import 'package:infixedu/app/modules/profile/views/profile_view.dart';
import 'package:infixedu/app/modules/routine/views/routine_view.dart';
import 'package:infixedu/app/modules/student_class/views/student_class_view.dart';
import 'package:infixedu/app/modules/te_academic/views/te_academic_view.dart';
import 'package:infixedu/app/modules/te_homework/views/te_homework_view.dart';
import 'package:infixedu/config/global_variable/app_settings_controller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
// import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import '../../../../config/global_variable/global_variable_controller.dart';
import '../../../data/constants/image_path.dart';
import '../../notification/view/notification_view.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => PersistentTabView(
        context,
        controller: controller.tabIndexController,
        screens: [
          controller.globalRxVariableController.roleId.value == 3
              ? const ChildHomeView()
              : const HomeView(),
          const NotificationView(),
          controller.globalRxVariableController.roleId.value == 4
              ? const AdminAttendanceView()
              : Get.find<AppSettingsController>()
                          .systemSettings
                          .value
                          .data
                          ?.systemSettings
                          ?.feesStatus ==
                      1
                  ? const FeesView()
                  : const StudentClassView(),
          controller.globalRxVariableController.roleId.value == 4
              ? const TeAcademicView()
              : const RoutineView(),
          controller.globalRxVariableController.roleId.value == 4
              ? const TeHomeworkView()
              : const ProfileView(),
        ],
        items: [
          navItem(icon: Iconsax.home_2, title: 'Home'.tr),
          navItem(
              icon: FontAwesomeIcons.bell,
              title: 'Notification'.tr,
              isNotification: true),
          Get.find<GlobalRxVariableController>().roleId.value == 4
              ? navItemWithImageIcon(
                  imagePath: ImagePath.studentAttendance,
                  title: 'Attendance'.tr)
              : Get.find<AppSettingsController>()
                          .systemSettings
                          .value
                          .data
                          ?.systemSettings
                          ?.feesStatus ==
                      1
                  ? navItemWithImageIcon(
                      imagePath: ImagePath.studentWallet, title: 'Fees'.tr)
                  : navItemWithImageIcon(
                      imagePath: ImagePath.adminClass, title: 'Class'.tr),
          Get.find<GlobalRxVariableController>().roleId.value == 4
              ? navItem(icon: Iconsax.teacher, title: 'Academic'.tr)
              : navItem(icon: Iconsax.menu_board, title: 'Routine'.tr),
          Get.find<GlobalRxVariableController>().roleId.value == 4
              ? navItem(icon: Iconsax.book, title: 'Homework'.tr)
              : navItem(icon: Iconsax.user, title: 'Profile'.tr),
        ],
        hideNavigationBar: false,
        navBarHeight: 79.w,
        margin: const EdgeInsets.all(0),
        padding: NavBarPadding.only(left: 5.w, right: 5.w, bottom: 5.h),
        confineInSafeArea: true,
        backgroundColor: Colors.white,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        stateManagement: false,
        hideNavigationBarWhenKeyboardShows: true,
        // onItemSelected: (index) async {
        //   if (index == 1) {
        //     // await controller.getNotifications();
        //   }
        // },
        onItemSelected: (index) {
          if (index == 2) {}
        },
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(10.0.w),
          colorBehindNavBar: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 10.0.w,
              offset: Offset(2, 3),
            ),
          ],
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: const ItemAnimationProperties(
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation(
          animateTabTransition: false,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle: NavBarStyle.style15,
      ),
    );
  }
}
