import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/data/constants/app_colors.dart';
import 'package:infixedu/app/data/constants/app_text.dart';
import 'package:infixedu/app/data/constants/image_path.dart';
import 'package:infixedu/app/modules/home/views/widgets/custom_card_tile.dart';
import 'package:infixedu/app/routes/app_pages.dart';
import 'package:infixedu/app/utilities/app_functions/functionality.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:infixedu/app/utilities/widgets/appbar/back_button_widget.dart';
import 'package:infixedu/app/utilities/widgets/button/icon_button.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/alert_dialog.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';

import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../controllers/child_home_controller.dart';

class ChildHomeView extends GetView<ChildHomeController> {
  const ChildHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return InfixEduScaffold(
      // appBar: AppBar(
      //   centerTitle: true,
      //   backgroundColor: AppColors.primaryColor.withOpacity(0),
      //   elevation: 0,
      //   title: Container(
      //     padding: EdgeInsets.only(top: 10.0.h),
      //     child: Row(
      //       children: [
      //         Padding(
      //           padding: const EdgeInsets.only(right: 10.0),
      //           child: BackButtonWidget(),
      //         ),
      //         Column(
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           mainAxisAlignment: MainAxisAlignment.center,
      //           children: [
      //             Container(
      //               height: 20.h,
      //               width: 66.w,
      //               decoration: const BoxDecoration(
      //                 image: DecorationImage(
      //                   image: AssetImage(ImagePath.appLogo),
      //                 ),
      //               ),
      //             ),
      //              Text(
      //               'Welcome to our school',
      //               style: TextStyle(
      //                   color: Colors.white,
      //                   fontSize: 10.sp,
      //                   fontWeight: FontWeight.w400),
      //             )
      //           ],
      //         ),
      //       ],
      //     ),
      //   ),
      //   actions: [
      //     CustomIconButton(
      //       icon: Iconsax.messages,
      //       onPressed: () {
      //         Get.toNamed(Routes.CHAT);
      //       },
      //     ),
      //     CustomIconButton(
      //       icon: Icons.exit_to_app,
      //       onPressed: () {
      //         Get.dialog(
      //           CustomPopupDialogue(
      //             onYesTap: () {
      //               controller.logout();
      //             },
      //             title: 'Confirmation'.tr,
      //             subTitle: AppText.logoutWarningMsg,
      //             noText: 'Cancel'.tr,
      //             yesText: 'Logout'.tr,
      //           ),
      //         );
      //       },
      //     ),
      //   ],
      // ),

      appBarHeight: 70,
      titleWidget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 20.h,
            width: 50.w,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(ImagePath.appLogo),
              ),
            ),
          ),
          Text(
            'Welcome to our school'.tr,
            style: TextStyle(
                color: Colors.white,
                fontSize: 10.sp,
                fontWeight: FontWeight.w400),
          )
        ],
      ),

      actions: [
        CustomIconButton(
          icon: Iconsax.messages,
          onPressed: () {
            Get.toNamed(Routes.CHAT);
          },
        ),
        InkWell(
          onTap: () {
            Get.dialog(
              CustomPopupDialogue(
                onYesTap: () {
                  controller.logout();
                },
                title: 'Confirmation'.tr,
                subTitle: "${"Are you sure".tr}\n${"you want to logout".tr}?",
                noText: 'Cancel'.tr,
                yesText: 'Logout'.tr,
              ),
            );
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0.w),
            child: Icon(
              Icons.logout_outlined,
              size: 20.w,
              color: Colors.white,
            ),
          ),
        )
      ],

      body: SafeArea(
        child: CustomBackground(
          customWidget: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                GridView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.all(10.w),
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
                              roleId: 2,
                              title: controller.homeTileList[index].value);
                        },
                        isSelected: controller.selectIndex.value == index,
                      ),
                    );
                  },
                ),
                40.verticalSpacing,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
