import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/data/constants/app_colors.dart';
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
import 'package:infixedu/domain/core/model/admin/admin_fees_model/fees_group_list_response_model.dart';
import 'package:infixedu/domain/core/model/post_request_response_model.dart';
import 'package:get/get.dart';

class AdminFeesGroupController extends GetxController {
  LoadingController loadingController = Get.find();
  RxBool createUpdateLoader = false.obs;
  RxBool deleteLoader = false.obs;
  RxBool isBottomSheetOpen = true.obs;

  TextEditingController titleTextController = TextEditingController();
  TextEditingController descriptionTextController = TextEditingController();

  RxList<FeesGroupData> feesGroupList = <FeesGroupData>[].obs;
  Rx<FeesGroupData> feesGroupInitialValue =
      FeesGroupData(id: -1, name: "Select Fees Group").obs;
  RxString feesGroupNullValue = "".obs;
  RxInt groupId = 0.obs;

  Future<FeesGroupListResponseModel> getFeesGroupList() async {
    try {
      feesGroupList.clear();
      loadingController.isLoading = true;
      final response = await BaseClient().getData(
          url: InfixApi.getFeesGroupList, header: GlobalVariable.header);
      FeesGroupListResponseModel feesGroupListResponseModel =
          FeesGroupListResponseModel.fromJson(response);

      if (feesGroupListResponseModel.success == true) {
        if (feesGroupListResponseModel.data!.isNotEmpty) {
          for (int i = 0; i < feesGroupListResponseModel.data!.length; i++) {
            feesGroupList.add(feesGroupListResponseModel.data![i]);
          }

          feesGroupInitialValue.value = feesGroupList[0];
          groupId.value = feesGroupList[0].id!;
        }
      } else {
        loadingController.isLoading = false;
        showBasicFailedSnackBar(
            message: feesGroupListResponseModel.message ??
                'Something went wrong'.tr);
      }
    } catch (e, t) {
      loadingController.isLoading = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      loadingController.isLoading = false;
    }

    return FeesGroupListResponseModel();
  }

  Future<void> createFeesGroup() async {
    try {
      createUpdateLoader.value = true;
      final response = await BaseClient().postData(
        url: InfixApi.createFeesGroup,
        header: GlobalVariable.header,
        payload: {
          "name": titleTextController.text,
          "description": descriptionTextController.text,
        },
      );
      FeesGroupListResponseModel feesGroupListResponseModel =
          FeesGroupListResponseModel.fromJson(response);

      if (feesGroupListResponseModel.success == true) {
        createUpdateLoader.value = false;
        titleTextController.clear();
        descriptionTextController.clear();
        Get.back();
        showBasicSuccessSnackBar(
            message: feesGroupListResponseModel.message ??
                'Created Successfully'.tr);
        if (feesGroupListResponseModel.data!.isNotEmpty) {
          feesGroupList.add(
            FeesGroupData(
              id: feesGroupListResponseModel.data!.first.id,
              name: feesGroupListResponseModel.data!.first.name,
              description: feesGroupListResponseModel.data!.first.description,
            ),
          );
        }
      } else {
        loadingController.isLoading = false;
        showBasicFailedSnackBar(
            message: feesGroupListResponseModel.message ??
                'Something went wrong'.tr);
      }
    } catch (e, t) {
      loadingController.isLoading = false;
      debugPrint('$e');
      debugPrint('$t');
    } finally {
      createUpdateLoader.value = false;
    }
  }

  Future<void> deleteSingleFees(
      {required int feesId, required int index}) async {
    try {
      deleteLoader.value = true;
      final response = await BaseClient().postData(
          url: InfixApi.deleteSingleFeesGroup(feesId: feesId),
          header: GlobalVariable.header);
      PostRequestResponseModel postRequestResponseModel =
          PostRequestResponseModel.fromJson(response);

      if (postRequestResponseModel.success == true) {
        deleteLoader.value = false;
        Get.back();
        feesGroupList.removeAt(index);
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
  }

  Future<void> updateSingleFeesGroup(
      {required int feesId, required int index}) async {
    try {
      createUpdateLoader.value = true;

      final response = await BaseClient().postData(
        url: InfixApi.updateSingleFeesGroup,
        header: GlobalVariable.header,
        payload: {
          "id": feesId,
          "name": titleTextController.text,
          "description": descriptionTextController.text,
        },
      );

      FeesGroupListResponseModel feesGroupListResponseModel =
          FeesGroupListResponseModel.fromJson(response);
      if (feesGroupListResponseModel.success == true) {
        feesGroupList[index].id = feesGroupListResponseModel.data!.first.id;
        feesGroupList[index].name = feesGroupListResponseModel.data!.first.name;
        feesGroupList[index].description =
            feesGroupListResponseModel.data!.first.description;
        titleTextController.clear();
        descriptionTextController.clear();
        createUpdateLoader.value = false;
        feesGroupList.refresh();
        Get.back();
        showBasicSuccessSnackBar(
            message: feesGroupListResponseModel.message ?? 'Fees Updated'.tr);
      } else {
        createUpdateLoader.value = false;
        showBasicFailedSnackBar(
            message: feesGroupListResponseModel.message ??
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

  void showUploadDocumentsBottomSheet({
    Function()? onTapForSave,
    Color? bottomSheetBackgroundColor,
    String? header,
    TextEditingController? titleController,
    TextEditingController? descriptionController,
    Function()? onTapCancel,
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
                          titleTextController.clear();
                          descriptionTextController.clear();
                        },
                        child: Icon(
                          Icons.close,
                          size: 16.h,
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
                      controller: titleController,
                      enableBorderActive: true,
                      focusBorderActive: true,
                      hintText: "${"Title".tr} *",
                      fillColor: Colors.white,
                    ),
                    10.verticalSpacing,
                    CustomTextFormField(
                      controller: descriptionController,
                      enableBorderActive: true,
                      focusBorderActive: true,
                      fillColor: Colors.white,
                      hintText: "${"Description".tr} *",
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
                        onTap: onTapCancel,
                      ),
                      createUpdateLoader.value
                          ? const CircularProgressIndicator()
                          : SecondaryButton(
                              width: Get.width * 0.2,
                              title: "Save".tr,
                              textStyle: AppTextStyle.textStyle12WhiteW500,
                              onTap: onTapForSave,
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
      isDismissible: false,
    );
  }

  @override
  void onInit() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getFeesGroupList();
    });
    super.onInit();
  }
}
