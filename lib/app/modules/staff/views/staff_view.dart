import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/data/constants/app_colors.dart';
import 'package:infixedu/app/data/constants/image_path.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:infixedu/app/utilities/widgets/customised_loading_widget/customised_loading_widget.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../home/views/widgets/custom_card_tile.dart';
import '../controllers/staff_controller.dart';

class StaffView extends GetView<StaffController> {
  const StaffView({super.key});

  @override
  Widget build(BuildContext context) {
    return InfixEduScaffold(
      title: "Staff".tr,
      body: CustomBackground(
        customWidget: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Obx(
                () => controller.isLoading.value
                    ? const SecondaryLoadingWidget()
                    : GridView.builder(
                        padding: EdgeInsets.all(10.w),
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: controller.staffRoleList.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 10.w,
                            mainAxisSpacing: 10.w),
                        itemBuilder: (context, index) {
                          return Obx(
                            () => CustomCardTile(
                              icon: ImagePath.add,
                              title: controller.staffRoleList[index].name?.tr ??
                                  "",
                              iconColor:
                                  AppColors.primaryColor.withOpacity(0.7),
                              onTap: () {
                                controller.selectIndex.value = index;
                                Get.toNamed(
                                  Routes.STAFF_LIST,
                                  arguments: {
                                    "staff_role_id":
                                        controller.staffRoleList[index].id,
                                    "staff_role_name":
                                        controller.staffRoleList[index].name
                                  },
                                );
                              },
                              isSelected: controller.selectIndex.value == index,
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
