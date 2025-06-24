import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/data/constants/app_colors.dart';
import 'package:infixedu/app/data/constants/app_text_style.dart';
import 'package:infixedu/app/modules/home/views/widgets/custom_card_tile.dart';
import 'package:infixedu/app/utilities/app_functions/functionality.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';

import 'package:get/get.dart';

import '../controllers/admin_transport_controller.dart';

class AdminTransportView extends GetView<AdminTransportController> {
  const AdminTransportView({super.key});
  @override
  Widget build(BuildContext context) {
    return InfixEduScaffold(
      title: "Transport".tr,
      body: CustomBackground(
        customWidget: SingleChildScrollView(
          child: Column(
            children: [
              GridView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.all(10.w),
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.adminFeesTileList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10.w,
                    mainAxisSpacing: 10.w),
                itemBuilder: (context, index) {
                  return Obx(
                    () => CustomCardTile(
                      icon: controller.adminFeesTileList[index].icon,
                      title: controller.adminFeesTileList[index].title.tr,
                      iconColor: AppColors.primaryColor.withOpacity(0.7),
                      onTap: () {
                        controller.selectIndex.value = index;
                        AppFunctions.getAdminHomeNavigation(
                            title: controller.adminFeesTileList[index].value);
                      },
                      isSelected: controller.selectIndex.value == index,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
