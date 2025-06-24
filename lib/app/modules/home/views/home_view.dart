import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/data/constants/app_text.dart';
import 'package:infixedu/app/modules/home/views/widgets/custom_card_tile.dart';
import 'package:infixedu/app/routes/app_pages.dart';
import 'package:infixedu/app/utilities/app_functions/functionality.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:infixedu/app/utilities/widgets/button/icon_button.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:infixedu/app/utilities/widgets/custom_app_bar/primary_app_bar.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../utilities/widgets/common_widgets/alert_dialog.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return InfixEduScaffold(
      leadingIcon: const SizedBox(),
      appBar: Obx(
        () => PrimaryAppBar(
          title:
              '${"Welcome".tr} ${controller.globalRxVariableController.fullName.value} | ${controller.globalRxVariableController.roleName.value?.tr}',
          // title: controller.globalRxVariableController.roleId.value == 1
          //     ? 'Welcome to Admin'.tr
          //     : 'Welcome to our school'.tr,
          actions: [
            CustomIconButton(
              icon: Iconsax.messages,
              onPressed: () {
                Get.toNamed(Routes.CHAT);
              },
            ),
            CustomIconButton(
              icon: Icons.exit_to_app,
              onPressed: () {
                Get.dialog(
                  CustomPopupDialogue(
                    onYesTap: () {
                      controller.logout();
                    },
                    title: 'Confirmation'.tr,
                    subTitle:
                        "${"Are you sure".tr}\n${"you want to logout".tr}?",
                    noText: 'Cancel'.tr,
                    yesText: 'Logout'.tr,
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: CustomBackground(
          customWidget: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                GridView.builder(
                  shrinkWrap: true,
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.homeTileList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10.w,
                      mainAxisSpacing: 10.w),
                  itemBuilder: (context, index) {
                    return Obx(
                      () => CustomCardTile(
                        icon: controller.homeTileList[index].icon,
                        title: controller.homeTileList[index].title.tr,
                        onTap: () {
                          controller.selectIndex.value = index;
                          AppFunctions.routingDecisionForRoleId(
                              roleId: controller
                                  .globalRxVariableController.roleId.value!,
                              title: controller.homeTileList[index].value);

                          // controller.selectIndex.value = index;
                          // AppFunctions.getStudentDashboardNavigation(
                          //     title: list[index].value);
                          // AppFunctions.getAdminHomeNavigation(
                          //     title: list[index].value);
                        },
                        isSelected: controller.selectIndex.value == index,
                      ),
                    );
                  },
                ),
                40.h.verticalSpacing,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
