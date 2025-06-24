import 'package:flutter/material.dart';
import 'package:infixedu/app/data/constants/app_text.dart';
import 'package:infixedu/app/data/constants/app_text_style.dart';
import 'package:infixedu/app/style/bottom_sheet/bottom_sheet_shpe.dart';
import 'package:infixedu/app/utilities/api_urls.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:infixedu/app/utilities/message/snack_bars.dart';
import 'package:infixedu/app/utilities/widgets/loader/loading.controller.dart';
import 'package:infixedu/config/global_variable/global_variable_controller.dart';
import 'package:infixedu/domain/base_client/base_client.dart';
import 'package:infixedu/domain/core/model/admin/admin_notice_model/admin_staff_notice_response_model.dart';
import 'package:get/get.dart';

class AdminNoticeController extends GetxController {
  GlobalRxVariableController globalRxVariableController = Get.find();
  LoadingController loadingController = Get.find();

  RxList<AdminStaffNoticeData> adminStaffNoticeList =
      <AdminStaffNoticeData>[].obs;

  Future<AdminStaffNoticeResponseModel> getAdminStaffNotice() async {
    try {
      adminStaffNoticeList.clear();
      loadingController.isLoading = true;

      final response = await BaseClient().getData(
          url: globalRxVariableController.roleId.value == 1
              ? InfixApi.getAdminStaffNoticeList
              : InfixApi.getTeacherNoticeList,
          header: GlobalVariable.header);

      AdminStaffNoticeResponseModel adminStaffNoticeResponseModel =
          AdminStaffNoticeResponseModel.fromJson(response);

      if (adminStaffNoticeResponseModel.success == true) {
        loadingController.isLoading = false;
        if (adminStaffNoticeResponseModel.data!.isNotEmpty) {
          for (int i = 0; i < adminStaffNoticeResponseModel.data!.length; i++) {
            adminStaffNoticeList.add(adminStaffNoticeResponseModel.data![i]);
          }
        }
      } else {
        loadingController.isLoading = false;
        showBasicFailedSnackBar(
          message: adminStaffNoticeResponseModel.message ??
              AppText.somethingWentWrong.tr,
        );
      }
    } catch (e, t) {
      loadingController.isLoading = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      loadingController.isLoading = false;
    }

    return AdminStaffNoticeResponseModel();
  }

  void showNoticeDetailsBottomSheet(
      {required int index, Color? bottomSheetBackgroundColor}) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        height: Get.height * 0.45,
        width: Get.width,
        color: bottomSheetBackgroundColor,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                adminStaffNoticeList[index].noticeTitle ?? '',
                style: AppTextStyle.fontSize14BlackW500,
              ),
              10.verticalSpacing,
              Text(
                adminStaffNoticeList[index].noticeMessage ??
                    'No notice available'.tr,
                style: AppTextStyle.fontSize13BlackW400,
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
      shape: defaultBottomSheetShape(),
    );
  }

  @override
  void onInit() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getAdminStaffNotice();
    });
    super.onInit();
  }
}
