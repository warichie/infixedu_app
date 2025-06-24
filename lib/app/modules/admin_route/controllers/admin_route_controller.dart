import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/data/constants/app_colors.dart';
import 'package:infixedu/app/data/constants/app_text.dart';
import 'package:infixedu/app/data/constants/app_text_style.dart';
import 'package:infixedu/app/style/bottom_sheet/bottom_sheet_shpe.dart';
import 'package:infixedu/app/utilities/api_urls.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:infixedu/app/utilities/message/snack_bars.dart';
import 'package:infixedu/app/utilities/widgets/button/primary_button.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/text_field.dart';
import 'package:infixedu/app/utilities/widgets/loader/loading.controller.dart';
import 'package:infixedu/config/global_variable/global_variable_controller.dart';
import 'package:infixedu/domain/base_client/base_client.dart';
import 'package:infixedu/domain/core/model/admin/admin_transport_model/admin_transport_route_response_model.dart';
import 'package:infixedu/domain/core/model/post_request_response_model.dart';
import 'package:get/get.dart';

class AdminRouteController extends GetxController {
  LoadingController loadingController = Get.find();
  RxBool saveLoader = false.obs;
  RxBool createUpdateLoader = false.obs;
  RxBool deleteLoader = false.obs;
  RxInt tabIndex = 0.obs;

  TabController? tabController;
  TextEditingController routeTitleTextController = TextEditingController();
  TextEditingController routeFareTextController = TextEditingController();

  List<String> tabs = <String>[
    'Add New',
    'Route List',
  ];

  RxList<AdminTransportRouteData> adminTransportRouteList =
      <AdminTransportRouteData>[].obs;

  /// Get Transport List
  Future<AdminTransportRouteResponseModel> getAdminTransportRouteList() async {
    try {
      adminTransportRouteList.clear();
      loadingController.isLoading = true;

      final response = await BaseClient().getData(
          url: InfixApi.getAdminTransportRouteList,
          header: GlobalVariable.header);

      AdminTransportRouteResponseModel adminTransportRouteResponseModel =
          AdminTransportRouteResponseModel.fromJson(response);

      if (adminTransportRouteResponseModel.success == true) {
        loadingController.isLoading = false;
        if (adminTransportRouteResponseModel.data!.isNotEmpty) {
          for (int i = 0;
              i < adminTransportRouteResponseModel.data!.length;
              i++) {
            adminTransportRouteList
                .add(adminTransportRouteResponseModel.data![i]);
          }
        }
      } else {
        loadingController.isLoading = false;
        showBasicFailedSnackBar(
          message: adminTransportRouteResponseModel.message ??
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

    return AdminTransportRouteResponseModel();
  }

  /// Add Transport
  Future<AdminTransportRouteResponseModel> addTransportRoute() async {
    try {
      saveLoader.value = true;
      final response = await BaseClient().postData(
        url: InfixApi.postAdminTransportRoute,
        header: GlobalVariable.header,
        payload: {
          "title": routeTitleTextController.text,
          "far": routeFareTextController.text,
        },
      );

      AdminTransportRouteResponseModel adminTransportRouteResponseModel =
          AdminTransportRouteResponseModel.fromJson(response);
      if (adminTransportRouteResponseModel.success == true) {
        saveLoader.value = false;

        if (adminTransportRouteResponseModel.data!.isNotEmpty) {
          adminTransportRouteList.add(
            AdminTransportRouteData(
              id: adminTransportRouteResponseModel.data![0].id,
              title: adminTransportRouteResponseModel.data![0].title,
              fare: adminTransportRouteResponseModel.data![0].fare,
            ),
          );
        }

        routeTitleTextController.clear();
        routeFareTextController.clear();
        showBasicSuccessSnackBar(
            message: adminTransportRouteResponseModel.message ??
                'Something went wrong'.tr);
      } else {
        saveLoader.value = false;
        showBasicFailedSnackBar(
            message: adminTransportRouteResponseModel.message ??
                'Something went wrong'.tr);
      }
    } catch (e, t) {
      saveLoader.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      saveLoader.value = false;
    }

    return AdminTransportRouteResponseModel();
  }

  /// Delete Single Fees Type
  Future<PostRequestResponseModel> deleteSingleRoute(
      {required int routeId, required int index}) async {
    try {
      deleteLoader.value = true;
      final response = await BaseClient().postData(
          url: InfixApi.deleteRoute(routeId: routeId),
          header: GlobalVariable.header);
      PostRequestResponseModel postRequestResponseModel =
          PostRequestResponseModel.fromJson(response);

      if (postRequestResponseModel.success == true) {
        deleteLoader.value = false;
        Get.back();
        adminTransportRouteList.removeAt(index);
        showBasicSuccessSnackBar(
            message: postRequestResponseModel.message ?? 'Data deleted'.tr);
      } else {
        deleteLoader.value = false;
        showBasicFailedSnackBar(
            message:
                postRequestResponseModel.message ?? 'Something went wrong'.tr);
      }
    } catch (e, t) {
      deleteLoader.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      deleteLoader.value = false;
    }

    return PostRequestResponseModel();
  }

  /// Update or Edit Fees Type
  Future<void> updateRoute({
    required int routeId,
    required int index,
  }) async {
    try {
      createUpdateLoader.value = true;

      final response = await BaseClient().postData(
        url: InfixApi.postAdminRouteUpdate,
        header: GlobalVariable.header,
        payload: {
          "route_id": routeId,
          "title": routeTitleTextController.text,
          "far": routeFareTextController.text,
        },
      );

      AdminTransportRouteResponseModel adminTransportRouteResponseModel =
          AdminTransportRouteResponseModel.fromJson(response);
      if (adminTransportRouteResponseModel.success == true) {
        adminTransportRouteList[index].id =
            adminTransportRouteResponseModel.data!.first.id;
        adminTransportRouteList[index].title =
            adminTransportRouteResponseModel.data!.first.title;
        adminTransportRouteList[index].fare =
            adminTransportRouteResponseModel.data!.first.fare;

        routeTitleTextController.clear();
        routeFareTextController.clear();
        createUpdateLoader.value = false;
        adminTransportRouteList.refresh();
        Get.back();
      } else {
        createUpdateLoader.value = false;
        showBasicFailedSnackBar(
            message: adminTransportRouteResponseModel.message ??
                'Something went wrong'.tr);
      }
    } catch (e, t) {
      createUpdateLoader.value = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      createUpdateLoader.value = false;
    }
  }

  bool validation() {
    if (routeTitleTextController.text.isEmpty) {
      showBasicFailedSnackBar(message: 'Select Route Title'.tr);
      return false;
    }

    if (routeFareTextController.text.isEmpty) {
      showBasicFailedSnackBar(message: 'Select Route Fare'.tr);
      return false;
    }

    return true;
  }

  void showUploadDocumentsBottomSheet({
    Color? bottomSheetBackgroundColor,
    String? header,
    required int routeId,
    required int index,
  }) {
    Get.bottomSheet(
      Container(
        height: Get.height * 0.45,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(8),
              topLeft: Radius.circular(8),
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
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8),
                    topLeft: Radius.circular(8),
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
                          routeTitleTextController.clear();
                          routeFareTextController.clear();
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
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    CustomTextFormField(
                      controller: routeTitleTextController,
                      enableBorderActive: true,
                      focusBorderActive: true,
                      hintText: "${"Title".tr} *",
                      fillColor: Colors.white,
                    ),
                    10.verticalSpacing,
                    CustomTextFormField(
                      controller: routeFareTextController,
                      enableBorderActive: true,
                      focusBorderActive: true,
                      fillColor: Colors.white,
                      hintText: "${"Fare".tr} *",
                    ),
                  ],
                ),
              ),
              Obx(
                () => Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SecondaryButton(
                        width: Get.width * 0.15,
                        title: "Cancel".tr,
                        color: Colors.white,
                        textStyle: AppTextStyle.fontSize13BlackW400,
                        borderColor: AppColors.primaryColor,
                        onTap: (() => Get.back()),
                      ),
                      createUpdateLoader.value
                          ? const CircularProgressIndicator()
                          : SecondaryButton(
                              width: Get.width * 0.2,
                              title: "Save".tr,
                              textStyle: AppTextStyle.textStyle12WhiteW500,
                              onTap: (() => updateRoute(
                                    routeId: routeId,
                                    index: index,
                                  )),
                            ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
      shape: defaultBottomSheetShape(),
      // isDismissible: false,
    );
  }

  @override
  void onInit() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getAdminTransportRouteList();
    });
    super.onInit();
  }
}
