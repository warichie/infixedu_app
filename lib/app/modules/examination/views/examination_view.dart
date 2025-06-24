import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../utilities/app_functions/functionality.dart';
import '../../../utilities/widgets/common_widgets/custom_background.dart';
import '../../../utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import '../../home/views/widgets/custom_card_tile.dart';
import '../controllers/examination_controller.dart';

class ExaminationView extends GetView<ExaminationController> {
  const ExaminationView({super.key});
  @override
  Widget build(BuildContext context) {
    return InfixEduScaffold(
      title: 'Examination'.tr,
      body: CustomBackground(
        customWidget: Column(
          children: [
            GridView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.all(10.w),
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.examinationTileList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10.w
              ),
              itemBuilder: (context, index) {
                return Obx(

                      () => CustomCardTile(
                    icon: controller.examinationTileList[index].icon,
                    title: controller.examinationTileList[index].title.tr,
                    onTap: () {
                      controller.selectIndex.value = index;
                      AppFunctions.getStudentDashboardNavigation(
                          title: controller.examinationTileList[index].value);
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
