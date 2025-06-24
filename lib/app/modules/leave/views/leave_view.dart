import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';

import 'package:get/get.dart';

import '../../../utilities/app_functions/functionality.dart';
import '../../home/views/widgets/custom_card_tile.dart';
import '../controllers/leave_controller.dart';

class LeaveView extends GetView<LeaveController> {
  const LeaveView({super.key});
  @override
  Widget build(BuildContext context) {
    return InfixEduScaffold(
      title: "Leave".tr,
      body: CustomBackground(
        customWidget: Column(
          children: [
            GridView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.all(10.w),
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.leaveTileList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, crossAxisSpacing: 10.w),
              itemBuilder: (context, index) {
                return Obx(
                  () => CustomCardTile(
                    icon: controller.leaveTileList[index].icon,
                    title: controller.leaveTileList[index].title.tr,
                    onTap: () {
                      controller.selectIndex.value = index;
                      AppFunctions.getStudentDashboardNavigation(
                          title: controller.leaveTileList[index].value);
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
