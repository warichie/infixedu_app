import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/data/constants/app_colors.dart';
import 'package:infixedu/app/data/constants/app_text_style.dart';
import 'package:infixedu/app/data/constants/image_path.dart';
import 'package:infixedu/app/modules/group_chat/controllers/group_chat_controller.dart';
import 'package:infixedu/app/style/bottom_sheet/bottom_sheet_shpe.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_divider.dart';
import 'package:infixedu/app/utilities/widgets/image_view/cache_image_view.dart';
import 'package:infixedu/config/global_variable/global_variable_controller.dart';
import 'package:get/get.dart';

import '../../../../utilities/widgets/popup_item_tile/popup_item_tile.dart';

class GroupChatHelper {
  GroupChatController groupChatController = Get.find();
  GlobalRxVariableController globalRxVariableController = Get.find();

  PopupMenuButton<int> popupMenu({required Function(int) onTap}) {
    return PopupMenuButton(
      padding: EdgeInsets.zero,
      color: Colors.white,
      iconColor: Colors.white,
      icon: Icon(
        Icons.more_vert,
        size: 16.h,
      ),
      menuPadding: EdgeInsets.all(10.w),
      onSelected: onTap,
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 1,
          height: 40.h,
          child: PopupItemTile(title: "Add People".tr),
        ),
        PopupMenuItem(
          value: 2,
          height: 40.h,
          child: PopupItemTile(title: "File".tr),
        ),
        PopupMenuItem(
          value: 3,
          height: 40.h,
          child: PopupItemTile(title: "Members".tr),
        ),
        if (globalRxVariableController.roleId.value == 1)
          PopupMenuItem(
            value: 4,
            height: 40.h,
            child: PopupItemTile(title: "Delete".tr),
          ),
        PopupMenuItem(
          value: 5,
          height: 40.h,
          child: PopupItemTile(title: "Leave Group".tr),
        ),
      ],
    );
  }

  void showGroupMemberListBottomSheet({
    Color? bottomSheetBackgroundColor,
    String? header,
    Function()? onDeleteTap,
  }) {
    Get.bottomSheet(
      Obx(
        () => Container(
          height: Get.height,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(8.r),
                topLeft: Radius.circular(8.r),
              ),
              color: bottomSheetBackgroundColor),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: Get.height * 0.1,
                  width: Get.width,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8.r),
                      topLeft: Radius.circular(8.r),
                    ),
                    color: AppColors.primaryColor,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        header ?? "",
                        style: AppTextStyle.cardTextStyle14WhiteW500,
                      ),
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white),
                        child: InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Icon(
                            Icons.close,
                            size: 16.w,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.4,
                  child: ListView.builder(
                      itemCount: groupChatController.groupChatMemberList.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15.0, vertical: 10),
                              child: Row(
                                children: [
                                  groupChatController.groupChatMemberList[index]
                                              .image ==
                                          ""
                                      ? Container(
                                          height: Get.height * 0.07,
                                          width: Get.width * 0.13,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(ImagePath.dp),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.r),
                                          ),
                                        )
                                      : SizedBox(
                                          height: Get.height * 0.055,
                                          width: Get.width * 0.11,
                                          child: ClipRRect(
                                            borderRadius: 6.circularRadius,
                                            child: CacheImageView(
                                              url: groupChatController
                                                  .groupChatMemberList[index]
                                                  .image,
                                              errorImageLocal:
                                                  ImagePath.errorImage,
                                            ),
                                          ),
                                        ),
                                  20.w.horizontalSpacing,
                                  Text(
                                    groupChatController
                                            .groupChatMemberList[index]
                                            .fullName ??
                                        "",
                                    style: AppTextStyle.fontSize13BlackW400,
                                  ),
                                  const Spacer(),
                                  InkWell(
                                    onTap: () {
                                      groupChatController
                                          .removeSingleMemberFromGroup(
                                              groupId: groupChatController
                                                  .groupId.value,
                                              userId: groupChatController
                                                  .groupChatMemberList[index]
                                                  .userId!,
                                              index: index,
                                              context: context);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.asset(
                                        ImagePath.delete,
                                        width: 16.w,
                                        height: 16.w,
                                        color: AppColors.activeStatusRedColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const CustomDivider(
                              color: AppColors.customDividerColor,
                            )
                          ],
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      shape: defaultBottomSheetShape(),
    );
  }
}
