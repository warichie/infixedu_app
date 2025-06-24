import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/data/constants/app_colors.dart';
import 'package:infixedu/app/modules/home/views/widgets/custom_card_tile.dart';
import 'package:infixedu/app/utilities/app_functions/functionality.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';

import 'package:get/get.dart';

import '../controllers/admin_dormitory_controller.dart';

class AdminDormitoryView extends GetView<AdminDormitoryController> {
  const AdminDormitoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return InfixEduScaffold(
      title: "Dormitory".tr,
      body: CustomBackground(
        customWidget: Column(
          children: [
            GridView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.all(10.w),
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.dormitoryTileList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10.w,
                  mainAxisSpacing: 10.w),
              itemBuilder: (context, index) {
                return Obx(() => CustomCardTile(
                      icon: controller.dormitoryTileList[index].icon,
                      title: controller.dormitoryTileList[index].title.tr,
                      iconColor: AppColors.primaryColor.withOpacity(0.7),
                      onTap: () {
                        controller.selectIndex.value = index;
                        AppFunctions.getAdminHomeNavigation(
                            title: controller.dormitoryTileList[index].value);
                      },
                      isSelected: controller.selectIndex.value == index,
                    ));
              },
            )
          ],
        ),
      ),
    );
  }
}
