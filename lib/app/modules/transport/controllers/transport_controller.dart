import 'package:flutter/material.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:infixedu/app/utilities/widgets/bottom_sheet_tile/bottom_sheet_tile.dart';
import 'package:infixedu/app/utilities/widgets/loader/loading.controller.dart';
import 'package:get/get.dart';

import '../../../../config/global_variable/global_variable_controller.dart';
import '../../../../domain/base_client/base_client.dart';
import '../../../../domain/core/model/transport_response_model/transport_response_model.dart';
import '../../../data/constants/app_colors.dart';
import '../../../data/constants/app_text_style.dart';
import '../../../style/bottom_sheet/bottom_sheet_shpe.dart';
import '../../../utilities/api_urls.dart';

class TransportController extends GetxController {
  GlobalRxVariableController globalRxVariableController = Get.find();
  LoadingController loadingController = Get.find();

  List<TransportDataList> transportDataList = [];

  Future<TransportResponseModel?> getAllTransportList(
      {required int studentId}) async {
    try {
      loadingController.isLoading = true;

      final response = await BaseClient().getData(
        url: InfixApi.getStudentTransport(studentId: studentId),
        header: GlobalVariable.header,
      );

      TransportResponseModel transportResponseModel =
          TransportResponseModel.fromJson(response);
      if (transportResponseModel.success == true) {
        loadingController.isLoading = false;
        if (transportResponseModel.data!.isNotEmpty) {
          for (int i = 0; i < transportResponseModel.data!.length; i++) {
            transportDataList.add(transportResponseModel.data![i]);
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
    return TransportResponseModel();
  }

  void showTransportDetailsBottomSheet(
      {required int index, Color? bottomSheetBackgroundColor}) {
    Get.bottomSheet(
      Container(
        color: bottomSheetBackgroundColor,
        height: Get.height * 0.45,
        child: transportDataList.isNotEmpty
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  10.verticalSpacing,
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      transportDataList[index].route ?? "",
                      style: AppTextStyle.fontSize14BlackW500,
                    ),
                  ),
                  BottomSheetTile(
                    title: "Vehicle".tr,
                    value: transportDataList[index].vehicle,
                    color: AppColors.homeworkWidgetColor,
                  ),
                  BottomSheetTile(
                    title: "Vehicle Model".tr,
                    value: transportDataList[index].vehicleModel,
                    color: Colors.white,
                  ),
                  BottomSheetTile(
                    title: "Made".tr,
                    value: (transportDataList[index].made == 0 ||
                            transportDataList[index].made == null)
                        ? ''
                        : transportDataList[index].made.toString(),
                    color: AppColors.homeworkWidgetColor,
                  ),
                  BottomSheetTile(
                    title: "Driver Name".tr,
                    value: transportDataList[index].driverName,
                    color: Colors.white,
                  ),
                  globalRxVariableController.roleId.value == 2
                      ? const SizedBox()
                      : BottomSheetTile(
                          title: "Driver License".tr,
                          value: transportDataList[index].driverLicense,
                          color: AppColors.homeworkWidgetColor,
                        ),
                  BottomSheetTile(
                    title: "Driver Contact".tr,
                    value: transportDataList[index].driverContact,
                    color: Colors.white,
                  ),
                ],
              )
            : Center(
                child: Text(
                  "No Details Available".tr,
                  style: AppTextStyle.fontSize16lightBlackW500,
                ),
              ),
      ),
      backgroundColor: Colors.white,
      shape: defaultBottomSheetShape(),
    );
  }

  @override
  void onInit() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getAllTransportList(
        studentId: globalRxVariableController.studentId.value!,
      );
    });

    super.onInit();
  }
}
