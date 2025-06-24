import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../utilities/app_functions/functionality.dart';
import '../../../utilities/widgets/common_widgets/custom_background.dart';
import '../../../utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import '../../home/views/widgets/custom_card_tile.dart';
import '../controllers/online_exam_controller.dart';

class OnlineExamView extends GetView<OnlineExamController> {
  const OnlineExamView({super.key});
  @override
  Widget build(BuildContext context) {
    return InfixEduScaffold(
      title: 'Online Exam'.tr,
      body: CustomBackground(
        customWidget: Column(
          children: [
            GridView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.all(10.w),
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.onlineExamTileList.length,
              gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10.w
              ),
              itemBuilder: (context, index) {
                return Obx(
                      () => CustomCardTile(

                    icon: controller.onlineExamTileList[index].icon,
                    title: controller.onlineExamTileList[index].title.tr,
                    onTap: () {
                      controller.selectIndex.value = index;
                      AppFunctions.getStudentDashboardNavigation(
                          title: controller.onlineExamTileList[index].value);
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
