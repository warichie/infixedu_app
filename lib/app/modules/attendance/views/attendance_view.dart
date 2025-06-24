import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:get/get.dart';
import '../../../utilities/app_functions/functionality.dart';
import '../../../utilities/widgets/common_widgets/custom_background.dart';
import '../../home/views/widgets/custom_card_tile.dart';
import '../controllers/attendance_controller.dart';

class AttendanceView extends GetView<AttendanceController> {
  const AttendanceView({super.key});
  @override
  Widget build(BuildContext context) {
    return InfixEduScaffold(
      title: 'Attendance'.tr,
      body: CustomBackground(
        customWidget: Column(
          children: [
            GridView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.all(10.w),
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.attendanceTileList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, crossAxisSpacing: 10.w),
              itemBuilder: (context, index) {
                return Obx(() => CustomCardTile(
                      icon: controller.attendanceTileList[index].icon,
                      title: controller.attendanceTileList[index].value.tr,
                      onTap: () {
                        controller.selectIndex.value = index;
                        AppFunctions.getStudentDashboardNavigation(
                            title: controller.attendanceTileList[index].value);
                      },
                      isSelected: controller.selectIndex.value == index,
                    ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
