import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/data/constants/app_colors.dart';
import 'package:infixedu/app/modules/home/views/widgets/custom_card_tile.dart';
import 'package:infixedu/app/utilities/app_functions/functionality.dart';
import 'package:infixedu/app/utilities/widgets/appbar/back_button_widget.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';

import 'package:get/get.dart';

import '../controllers/admin_attendance_controller.dart';

class AdminAttendanceView extends GetView<AdminAttendanceController> {
  const AdminAttendanceView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => InfixEduScaffold(
        leadingIcon: controller.globalRxVariableController.roleId.value == 1
            ? const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: BackButtonWidget())
            : const SizedBox(),
        title: "Attendance".tr,
        body: CustomBackground(
          customWidget: Column(
            children: [
              GridView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.all(10.w),
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.adminAttendanceTileList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 10.w,
                    crossAxisSpacing: 10.w),
                itemBuilder: (context, index) {
                  return Obx(() => CustomCardTile(
                        icon: controller.adminAttendanceTileList[index].icon,
                        title:
                            controller.adminAttendanceTileList[index].value.tr,
                        iconColor: AppColors.primaryColor.withOpacity(0.7),
                        onTap: () {
                          controller.selectIndex.value = index;
                          AppFunctions.getAdminHomeNavigation(
                              title: controller
                                  .adminAttendanceTileList[index].value);
                        },
                        isSelected: controller.selectIndex.value == index,
                      ));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
