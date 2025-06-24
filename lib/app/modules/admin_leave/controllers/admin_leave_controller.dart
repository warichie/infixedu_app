import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/data/constants/app_colors.dart';
import 'package:infixedu/app/data/constants/app_text.dart';
import 'package:infixedu/app/data/constants/image_path.dart';
import 'package:infixedu/app/modules/home/controllers/home_controller.dart';
import 'package:infixedu/app/style/bottom_sheet/bottom_sheet_shpe.dart';
import 'package:infixedu/app/utilities/api_urls.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:infixedu/app/utilities/file_downloader/file_download_utils.dart';
import 'package:infixedu/app/utilities/message/snack_bars.dart';
import 'package:infixedu/app/utilities/widgets/bottom_sheet_tile/bottom_sheet_tile.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/primary_button.dart';
import 'package:infixedu/app/utilities/widgets/custom_radio_button/custom_radio_button.dart';
import 'package:infixedu/app/utilities/widgets/loader/loading.controller.dart';
import 'package:infixedu/config/global_variable/global_variable_controller.dart';
import 'package:infixedu/domain/base_client/base_client.dart';
import 'package:infixedu/domain/core/model/admin/admin_leave_model/admin_approve_leave_response_model.dart';
import 'package:infixedu/domain/core/model/admin/admin_leave_model/admin_pending_leave_response_model.dart';
import 'package:infixedu/domain/core/model/admin/admin_leave_model/admin_rejected_leave_response_model.dart';
import 'package:infixedu/domain/core/model/post_request_response_model.dart';
import 'package:get/get.dart';

import '../../../data/constants/app_text_style.dart';
import '../../../utilities/widgets/common_widgets/alert_dialog.dart';
import '../../../utilities/widgets/permission_check/permission_check.dart';

class AdminLeaveController extends GetxController {
  TabController? tabController;
  int selectedIndex = 0;
  LoadingController loadingController = Get.find();
  HomeController homeController = Get.find();

  RxList<PendingLeaveData> pendingLeaveList = <PendingLeaveData>[].obs;
  RxList<ApproveLeaveData> approveLeaveList = <ApproveLeaveData>[].obs;
  RxList<RejectedLeaveData> rejectedLeaveList = <RejectedLeaveData>[].obs;

  List<String> status = <String>[
    'Pending',
    'Approved',
    'Cancelled',
  ];

  RxString selectedOption = "P".obs;
  RxBool saveLoader = false.obs;

  Future<AdminPendingLeaveResponseModel?> getAdminPendingLeave() async {
    pendingLeaveList.clear();
    try {
      loadingController.isLoading = true;

      final response = await BaseClient().getData(
        url: InfixApi.getAdminPendingLeaveList,
        header: GlobalVariable.header,
      );

      AdminPendingLeaveResponseModel adminPendingLeaveResponseModel =
          AdminPendingLeaveResponseModel.fromJson(response);
      if (adminPendingLeaveResponseModel.success == true) {
        loadingController.isLoading = false;
        if (adminPendingLeaveResponseModel.data!.isNotEmpty) {
          for (int i = 0;
              i < adminPendingLeaveResponseModel.data!.length;
              i++) {
            pendingLeaveList.add(adminPendingLeaveResponseModel.data![i]);
          }
        }
      }
    } catch (e, t) {
      loadingController.isLoading = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      loadingController.isLoading = false;
    }

    return AdminPendingLeaveResponseModel();
  }

  Future<AdminApproveLeaveResponseModel?> getAdminApproveLeave(
      {required bool isLoader}) async {
    approveLeaveList.clear();
    try {
      if (isLoader) {
        loadingController.isLoading = true;
      }

      final response = await BaseClient().getData(
        url: InfixApi.getAdminApproveLeaveList,
        header: GlobalVariable.header,
      );

      AdminApproveLeaveResponseModel adminApproveLeaveResponseModel =
          AdminApproveLeaveResponseModel.fromJson(response);
      if (adminApproveLeaveResponseModel.success == true) {
        if (isLoader) {
          loadingController.isLoading = false;
        }
        if (adminApproveLeaveResponseModel.data!.isNotEmpty) {
          for (int i = 0;
              i < adminApproveLeaveResponseModel.data!.length;
              i++) {
            approveLeaveList.add(adminApproveLeaveResponseModel.data![i]);
          }
        }
      }
    } catch (e, t) {
      if (isLoader) {
        loadingController.isLoading = false;
      }
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      if (isLoader) {
        loadingController.isLoading = false;
      }
    }

    return AdminApproveLeaveResponseModel();
  }

  Future<AdminRejectedLeaveResponseModel?> getAdminRejectedLeave(
      {required bool isLoader}) async {
    rejectedLeaveList.clear();
    try {
      if (isLoader) {
        loadingController.isLoading = true;
      }
      final response = await BaseClient().getData(
        url: InfixApi.getAdminRejectedLeaveList,
        header: GlobalVariable.header,
      );

      AdminRejectedLeaveResponseModel adminRejectedLeaveResponseModel =
          AdminRejectedLeaveResponseModel.fromJson(response);
      if (adminRejectedLeaveResponseModel.success == true) {
        if (isLoader) {
          loadingController.isLoading = false;
        }
        if (adminRejectedLeaveResponseModel.data!.isNotEmpty) {
          for (int i = 0;
              i < adminRejectedLeaveResponseModel.data!.length;
              i++) {
            rejectedLeaveList.add(adminRejectedLeaveResponseModel.data![i]);
          }
        }
      }
    } catch (e, t) {
      if (isLoader) {
        loadingController.isLoading = false;
      }
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      if (isLoader) {
        loadingController.isLoading = false;
      }
    }

    return AdminRejectedLeaveResponseModel();
  }

  void updateLeaveStatus(
      {required int leaveId,
      required String currentStatus,
      required String previousStatus,
      required int index}) async {
    try {
      saveLoader.value = true;
      final res = await BaseClient().postData(
        url: InfixApi.adminLeaveStatusUpdate(
            leaveId: leaveId, statusType: currentStatus),
        header: GlobalVariable.header,
      );

      PostRequestResponseModel postRequestResponseModel =
          PostRequestResponseModel.fromJson(res);
      if (postRequestResponseModel.success == true) {
        saveLoader.value = false;

        if (previousStatus == 'P' && currentStatus == 'A') {
          approveLeaveList.clear();
          pendingLeaveList.clear();
          getAdminApproveLeave(isLoader: true);
          getAdminPendingLeave();
          // approveLeaveList.add(
          //   ApproveLeaveData(
          //     id: pendingLeaveList[index].id,
          //     fullName: pendingLeaveList[index].fullName,
          //     applyDate: pendingLeaveList[index].applyDate,
          //     leaveTo: pendingLeaveList[index].leaveTo,
          //     leaveFrom: pendingLeaveList[index].leaveFrom,
          //     file: pendingLeaveList[index].file,
          //     type: pendingLeaveList[index].type,
          //     approveStatus: currentStatus,
          //   ),
          // );
          // pendingLeaveList.removeAt(index);
        } else if (previousStatus == 'P' && currentStatus == 'C') {
          rejectedLeaveList.clear();
          pendingLeaveList.clear();
          getAdminPendingLeave();
          getAdminRejectedLeave(isLoader: true);

          // rejectedLeaveList.add(
          //   RejectedLeaveData(
          //     id: pendingLeaveList[index].id,
          //     fullName: pendingLeaveList[index].fullName,
          //     applyDate: pendingLeaveList[index].applyDate,
          //     leaveTo: pendingLeaveList[index].leaveTo,
          //     leaveFrom: pendingLeaveList[index].leaveFrom,
          //     file: pendingLeaveList[index].file,
          //     type: pendingLeaveList[index].type,
          //     approveStatus: currentStatus,
          //   ),
          // );
          // pendingLeaveList.removeAt(index);
        } else if (previousStatus == 'A' && currentStatus == 'P') {
          approveLeaveList.clear();
          pendingLeaveList.clear();
          getAdminApproveLeave(isLoader: true);
          getAdminPendingLeave();
          // pendingLeaveList.add(
          //   PendingLeaveData(
          //     id: pendingLeaveList[index].id,
          //     fullName: pendingLeaveList[index].fullName,
          //     applyDate: pendingLeaveList[index].applyDate,
          //     leaveTo: pendingLeaveList[index].leaveTo,
          //     leaveFrom: pendingLeaveList[index].leaveFrom,
          //     file: pendingLeaveList[index].file,
          //     type: pendingLeaveList[index].type,
          //     approveStatus: currentStatus,
          //   ),
          // );
          // approveLeaveList.removeAt(index);
        } else if (previousStatus == 'A' && currentStatus == 'C') {
          approveLeaveList.clear();
          rejectedLeaveList.clear();
          getAdminApproveLeave(isLoader: true);
          getAdminRejectedLeave(isLoader: true);
          // rejectedLeaveList.add(
          //   RejectedLeaveData(
          //     id: pendingLeaveList[index].id,
          //     fullName: pendingLeaveList[index].fullName,
          //     applyDate: pendingLeaveList[index].applyDate,
          //     leaveTo: pendingLeaveList[index].leaveTo,
          //     leaveFrom: pendingLeaveList[index].leaveFrom,
          //     file: pendingLeaveList[index].file,
          //     type: pendingLeaveList[index].type,
          //     approveStatus: currentStatus,
          //   ),
          // );
          // approveLeaveList.removeAt(index);
        } else if (previousStatus == 'C' && currentStatus == 'P') {
          rejectedLeaveList.clear();
          pendingLeaveList.clear();
          getAdminRejectedLeave(isLoader: true);
          getAdminPendingLeave();
          // pendingLeaveList.add(

          //   PendingLeaveData(
          //     id: pendingLeaveList[index].id,
          //     fullName: pendingLeaveList[index].fullName,
          //     applyDate: pendingLeaveList[index].applyDate,
          //     leaveTo: pendingLeaveList[index].leaveTo,
          //     leaveFrom: pendingLeaveList[index].leaveFrom,
          //     file: pendingLeaveList[index].file,
          //     type: pendingLeaveList[index].type,
          //     approveStatus: currentStatus,
          //   ),
          // );
          // rejectedLeaveList.removeAt(index);
        } else if (previousStatus == 'C' && currentStatus == 'A') {
          approveLeaveList.clear();
          rejectedLeaveList.clear();
          getAdminApproveLeave(isLoader: true);
          getAdminRejectedLeave(isLoader: true);
          // approveLeaveList.add(
          //   ApproveLeaveData(
          //     id: pendingLeaveList[index].id,
          //     fullName: pendingLeaveList[index].fullName,
          //     applyDate: pendingLeaveList[index].applyDate,
          //     leaveTo: pendingLeaveList[index].leaveTo,
          //     leaveFrom: pendingLeaveList[index].leaveFrom,
          //     file: pendingLeaveList[index].file,
          //     type: pendingLeaveList[index].type,
          //     approveStatus: currentStatus,
          //   ),
          // );
          // rejectedLeaveList.removeAt(index);
        }

        selectedOption.value = 'P';
        Get.back();
        showBasicSuccessSnackBar(
            message:
                postRequestResponseModel.message ?? 'Updated successfully'.tr);
      } else {
        saveLoader.value = false;
        showBasicFailedSnackBar(
            message: postRequestResponseModel.message ??
                AppText.somethingWentWrong.tr);
      }
    } catch (e, t) {
      saveLoader.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      saveLoader.value = false;
    }
  }

  void showPendingListDetailsBottomSheet({
    required int index,
    required String reason,
    required Function() onTap,
    required String leaveType,
    required String applyDate,
    required String leaveFrom,
    required String leaveTo,
    required String file,
  }) {
    Get.bottomSheet(
      isScrollControlled: true,
      Obx(
        () => Container(
          padding: const EdgeInsets.all(20),
          height: Get.height * 0.73,
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 10.verticalSpacing,
                Text(
                  "${"Reason".tr}: $reason",
                  style: AppTextStyle.bottomSheetTitleColor,
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
                10.verticalSpacing,
                InkWell(
                  onTap: () async {
                    await PermissionCheck().checkPermissions(Get.context!);
                    Get.dialog(
                      CustomPopupDialogue(
                        onYesTap: () {
                          Get.back();
                          fileDownload(url: file, title: file.toString());
                        },
                        title: 'Confirmation'.tr,
                        subTitle: AppText.downloadMessage.tr,
                        noText: 'No'.tr,
                        yesText: 'Download'.tr,
                      ),
                    );
                  },
                  child: Container(
                    width: 130.w,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Attached File".tr,
                          style: AppTextStyle.textStyle12WhiteW400,
                        ),
                        10.horizontalSpacing,
                        Image.asset(
                          ImagePath.download,
                          scale: 5,
                          color: Colors.white,
                          width: 16.w,
                          height: 16.w,
                        ),
                      ],
                    ),
                  ),
                ),
                30.verticalSpacing,
                Text(
                  "Leave Status".tr,
                  style: AppTextStyle.fontSize14BlackW500,
                ),
                CustomRadioButton(
                  title: "Pending".tr,
                  value: "P",
                  groupValue: selectedOption.value,
                  onChanged: (value) {
                    selectedOption.value = value!;
                  },
                  activeColor: AppColors.primaryColor,
                ),
                CustomRadioButton(
                  title: "Approve".tr,
                  value: "A",
                  groupValue: selectedOption.value,
                  onChanged: (value) {
                    selectedOption.value = value!;
                  },
                  activeColor: AppColors.primaryColor,
                ),
                CustomRadioButton(
                  title: "Cancel".tr,
                  value: "C",
                  groupValue: selectedOption.value,
                  onChanged: (value) {
                    selectedOption.value = value!;
                  },
                  activeColor: AppColors.primaryColor,
                ),
                20.verticalSpacing,
                Obx(
                  () => saveLoader.value
                      ? const Center(
                          child: CircularProgressIndicator(
                          color: AppColors.primaryColor,
                        ))
                      : PrimaryButton(
                          text: "Save".tr,
                          onTap: onTap,
                        ),
                ),
                30.verticalSpacing,
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      shape: defaultBottomSheetShape(),
    );
  }

  void fileDownload({required String url, required String title}) {
    url == ''
        ? showBasicFailedSnackBar(
            message: 'No File Available'.tr,
          )
        : FileDownloadUtils().downloadFiles(url: url, title: title);
  }

  @override
  void onInit() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getAdminPendingLeave();
      getAdminApproveLeave(isLoader: false);
      getAdminRejectedLeave(isLoader: false);
    });

    super.onInit();
  }
}
