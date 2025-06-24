import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/data/constants/app_colors.dart';
import 'package:infixedu/app/modules/home/views/widgets/custom_card_tile.dart';
import 'package:infixedu/app/utilities/app_functions/functionality.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';

import 'package:get/get.dart';

import '../controllers/admin_content_controller.dart';

class AdminContentView extends GetView<AdminContentController> {
  const AdminContentView({super.key});

  @override
  Widget build(BuildContext context) {
    return InfixEduScaffold(
      title: "Content".tr,
      body: CustomBackground(
        customWidget: Column(
          children: [
            GridView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.all(10.w),
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.contentTileList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10.w,
                //mainAxisExtent: 10.w
              ),
              itemBuilder: (context, index) {
                return Obx(() => CustomCardTile(
                      icon: controller.contentTileList[index].icon,
                      title: controller.contentTileList[index].title.tr,
                      iconColor: AppColors.primaryColor,
                      onTap: () {
                        controller.selectIndex.value = index;
                        AppFunctions.getAdminHomeNavigation(
                            title: controller.contentTileList[index].value);
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
