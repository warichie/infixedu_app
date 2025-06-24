import 'package:flutter/material.dart';
import 'package:infixedu/app/data/constants/app_colors.dart';
import 'package:infixedu/app/data/constants/app_text.dart';
import 'package:infixedu/app/data/constants/app_text_style.dart';
import 'package:infixedu/app/style/bottom_sheet/bottom_sheet_shpe.dart';
import 'package:infixedu/app/utilities/api_urls.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:infixedu/app/utilities/message/snack_bars.dart';
import 'package:infixedu/app/utilities/widgets/bottom_sheet_tile/bottom_sheet_tile.dart';
import 'package:infixedu/app/utilities/widgets/loader/loading.controller.dart';
import 'package:infixedu/config/global_variable/global_variable_controller.dart';
import 'package:infixedu/domain/base_client/base_client.dart';
import 'package:infixedu/domain/core/model/admin/admin_transport_model/admin_transport_list_response_model.dart';
import 'package:get/get.dart';

class AdminTransportDetailsController extends GetxController {
  /// Loading Controller
  LoadingController loadingController = Get.find();

  RxList<AdminTransportData> adminTransportList = <AdminTransportData>[].obs;

  Future<AdminTransportListResponseModel> getAdminTransportList() async {
    try {
      adminTransportList.clear();
      loadingController.isLoading = true;

      final response = await BaseClient().getData(
          url: InfixApi.getAdminTransportList, header: GlobalVariable.header);

      AdminTransportListResponseModel adminTransportListResponseModel =
          AdminTransportListResponseModel.fromJson(response);

      if (adminTransportListResponseModel.success == true) {
        loadingController.isLoading = false;

        if (adminTransportListResponseModel.data!.isNotEmpty) {
          for (var element in adminTransportListResponseModel.data!) {
            adminTransportList.add(element);
          }
        }
      } else {
        loadingController.isLoading = false;
        showBasicFailedSnackBar(
          message: adminTransportListResponseModel.message ??
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

    return AdminTransportListResponseModel();
  }

  void showBookListDetailsBottomSheet(
      {required int index, Color? bottomSheetBackgroundColor}) {
    Get.bottomSheet(
      Container(
          height: Get.height * 0.55,
          color: bottomSheetBackgroundColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              10.verticalSpacing,
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Routes".tr,
                  style: AppTextStyle.fontSize14BlackW500,
                ),
              ),
              BottomSheetTile(
                title: "Vehicle No".tr,
                value: adminTransportList[index].vehicleNo,
                color: AppColors.homeworkWidgetColor,
              ),
              BottomSheetTile(
                title: "Vehicle Model".tr,
                value: adminTransportList[index].vehicleModel,
                color: Colors.white,
              ),
              BottomSheetTile(
                title: "Made Year".tr,
                value: adminTransportList[index].madeYear != null
                    ? adminTransportList[index].madeYear.toString()
                    : '',
                color: AppColors.homeworkWidgetColor,
              ),
              BottomSheetTile(
                title: "Driver Name".tr,
                value: adminTransportList[index].driverName,
                color: Colors.white,
              ),
              BottomSheetTile(
                title: "License".tr,
                value: adminTransportList[index].drivingLicense,
                color: AppColors.homeworkWidgetColor,
              ),
              BottomSheetTile(
                title: "Driver Contact".tr,
                value: adminTransportList[index].driverContactNo,
                color: Colors.white,
              ),
            ],
          )),
      shape: defaultBottomSheetShape(),
    );
  }

  @override
  void onInit() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getAdminTransportList();
    });
    super.onInit();
  }
}
