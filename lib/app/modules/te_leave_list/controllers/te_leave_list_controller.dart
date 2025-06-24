import 'package:flutter/material.dart';
import 'package:infixedu/app/data/constants/app_colors.dart';
import 'package:infixedu/app/style/bottom_sheet/bottom_sheet_shpe.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:infixedu/app/utilities/widgets/bottom_sheet_tile/bottom_sheet_tile.dart';
import 'package:infixedu/app/utilities/widgets/loader/loading.controller.dart';
import 'package:get/get.dart';

import '../../../data/constants/app_text_style.dart';

class TeLeaveListController extends GetxController {
  TabController? tabController;
  LoadingController loadingController = Get.find();

  RxString selectedOption = "P".obs;
  RxBool saveLoader = false.obs;
  RxString colorChoose = "Approved".obs;

  List<String> status = <String>[
    'Pending',
    'Approved',
    'Cancelled',
  ];

  void getStatusColor({required String color}) {
    debugPrint(color);
    switch (color) {
      case 'Approved':
        AppColors.activeStatusGreenColor;
        break;
      case 'Pending':
        AppColors.activeStatusYellowColor;
        break;
      case 'Cancelled':
        AppColors.activeStatusRedColor;
        break;
    }
  }

  void showPendingListDetailsBottomSheet({
    required int index,
    required String reason,
    required String leaveType,
    required String applyDate,
    required String leaveFrom,
    required String leaveTo,
  }) {
    Get.bottomSheet(
      Container(
          padding: const EdgeInsets.all(20),
          height: Get.height * 0.45,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              10.verticalSpacing,
              Text(
                "${"Reason".tr}: $reason",
                style: AppTextStyle.fontSize14BlackW500,
              ),
              20.verticalSpacing,
              BottomSheetTile(
                title: "Leave Type".tr,
                value: leaveType,
                color: AppColors.homeworkWidgetColor,
              ),
              BottomSheetTile(
                title: "Apply Date".tr,
                value: applyDate,
              ),
              BottomSheetTile(
                title: "Leave From".tr,
                value: leaveFrom,
                color: AppColors.homeworkWidgetColor,
              ),
              BottomSheetTile(
                title: "Leave To".tr,
                value: leaveTo,
              ),
            ],
          )),
      backgroundColor: Colors.white,
      shape: defaultBottomSheetShape(),
    );
  }
}
