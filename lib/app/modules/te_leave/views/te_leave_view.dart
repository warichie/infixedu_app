import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/data/constants/app_colors.dart';
import 'package:infixedu/app/modules/home/views/widgets/custom_card_tile.dart';
import 'package:infixedu/app/utilities/app_functions/functionality.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';

import 'package:get/get.dart';

import '../controllers/te_leave_controller.dart';

class TeLeaveView extends GetView<TeLeaveController> {
  const TeLeaveView({super.key});
  @override
  Widget build(BuildContext context) {
    return InfixEduScaffold(
      title: "Leave".tr,
      body: CustomBackground(
        customWidget: Column(
          children: [
            GridView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.all(10),
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.teacherLeaveTileList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, crossAxisSpacing: 10.w),
              itemBuilder: (context, index) {
                return Obx(
                  () => CustomCardTile(
                    icon: controller.teacherLeaveTileList[index].icon,
                    title: controller.teacherLeaveTileList[index].title.tr,
                    iconColor: AppColors.primaryColor,
                    onTap: () {
                      controller.selectIndex.value = index;
                      AppFunctions.getTeacherHomeNavigation(
                        title: controller.teacherLeaveTileList[index].value,
                      );
                    },
                    isSelected: controller.selectIndex.value == index,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
