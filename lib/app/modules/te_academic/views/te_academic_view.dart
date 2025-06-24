import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/data/constants/app_colors.dart';
import 'package:infixedu/app/modules/home/views/widgets/custom_card_tile.dart';
import 'package:infixedu/app/utilities/app_functions/functionality.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';

import 'package:get/get.dart';

import '../controllers/te_academic_controller.dart';

class TeAcademicView extends GetView<TeAcademicController> {
  const TeAcademicView({super.key});
  @override
  Widget build(BuildContext context) {
    return InfixEduScaffold(
      leadingIcon: const SizedBox(),
      title: "Academic".tr,
      body: CustomBackground(
        customWidget: Column(
          children: [
            GridView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.all(10.w),
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.teacherAcademicTileList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10.w,
                  mainAxisSpacing: 10.w),
              itemBuilder: (context, index) {
                return Obx(
                  () => CustomCardTile(
                    icon: controller.teacherAcademicTileList[index].icon,
                    title: controller.teacherAcademicTileList[index].title.tr,
                    iconColor: AppColors.primaryColor,
                    onTap: () {
                      controller.selectIndex.value = index;
                      AppFunctions.getTeacherHomeNavigation(
                        title: controller.teacherAcademicTileList[index].value,
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
