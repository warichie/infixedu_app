import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/modules/home/views/widgets/custom_card_tile.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';

import 'package:get/get.dart';

import '../../../utilities/app_functions/functionality.dart';
import '../controllers/study_materials_controller.dart';

class StudyMaterialsView extends GetView<StudyMaterialsController> {
  const StudyMaterialsView({super.key});

  @override
  Widget build(BuildContext context) {
    return InfixEduScaffold(
      title: 'Study Materials'.tr,
      body: CustomBackground(
        customWidget: Column(
          children: [
            GridView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.studyMaterialTileList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10.w,
              ),
              itemBuilder: (context, index) {
                return Obx(
                  () => CustomCardTile(
                    icon: controller.studyMaterialTileList[index].icon,
                    title: controller.studyMaterialTileList[index].title.tr,
                    onTap: () {
                      controller.selectIndex.value = index;
                      AppFunctions.getStudentDashboardNavigation(
                          title: controller.studyMaterialTileList[index].value);
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
