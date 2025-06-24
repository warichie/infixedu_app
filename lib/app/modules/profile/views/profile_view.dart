import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/data/constants/app_text.dart';
import 'package:infixedu/app/data/constants/app_text_style.dart';
import 'package:infixedu/app/data/constants/image_path.dart';
import 'package:infixedu/app/modules/profile/controllers/profile_controller.dart';
import 'package:infixedu/app/routes/app_pages.dart';
import 'package:infixedu/app/utilities/widgets/appbar/back_button_widget.dart';
import 'package:infixedu/app/utilities/widgets/customised_loading_widget/customised_loading_widget.dart';
import 'package:infixedu/app/utilities/widgets/delete_tile/delete_tile.dart';
import 'package:infixedu/app/modules/profile/views/widget/guardian_info.dart';
import 'package:infixedu/app/modules/profile/views/widget/others_tile.dart';
import 'package:infixedu/app/modules/profile/views/widget/parents_info.dart';
import 'package:infixedu/app/modules/profile/views/widget/tranport_widget.dart';
import 'package:infixedu/app/modules/profile/views/widget/pages_widget.dart';
import 'package:infixedu/app/modules/profile/views/widget/personal_profile_widget.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:infixedu/app/utilities/widgets/loader/loading.widget.dart';
import 'package:infixedu/app/utilities/widgets/no_data_available/no_data_available_widget.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../data/constants/app_colors.dart';
import '../../../utilities/widgets/common_widgets/alert_dialog.dart';
import '../../../utilities/widgets/image_view/cache_image_view.dart';
import '../../../utilities/widgets/permission_check/permission_check.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<ProfileController>()) {
      Get.put(ProfileController());
    }

    log("controller.globalRxVariableController.roleId.value ::: ${controller.globalRxVariableController.roleId.value}");
    return Obx(
      () => InfixEduScaffold(
        actions: [
          controller.globalRxVariableController.roleId.value == 4
              ? const SizedBox()
              : InkWell(
                  onTap: () {
                    Get.toNamed(Routes.PROFILE_EDIT, arguments: {
                      "profile_personal": controller.profilePersonal
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Icon(
                      Iconsax.edit_2,
                      color: Colors.white.withOpacity(0.9),
                      size: 20.h,
                    ),
                  ),
                )
        ],
        leadingIcon: controller.globalRxVariableController.roleId.value == 2
            ? const SizedBox()
            : BackButtonWidget(),
        title: "Profile".tr,
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              CustomBackground(
                customWidget: Obx(
                  () => Column(
                    children: [
                      /// Student Details Card
                      Card(
                        elevation: 5,
                        margin: EdgeInsets.zero,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(7.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color:
                                          AppColors.profileCardBackgroundColor),
                                  child: Padding(
                                    padding: const EdgeInsets.all(7.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        controller
                                                    .profileDataController
                                                    .profilePhoto
                                                    .value
                                                    .isEmpty ||
                                                controller.profileDataController
                                                        .profilePhoto.value ==
                                                    ''
                                            ? Container(
                                                height: 75,
                                                width: 75,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: AssetImage(
                                                        ImagePath.dp),
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                              )
                                            : SizedBox(
                                                height: 75,
                                                width: 75,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      8.circularRadius,
                                                  child: CacheImageView(
                                                    url: controller
                                                        .profileDataController
                                                        .profilePhoto
                                                        .toString(),
                                                    errorImageLocal:
                                                        ImagePath.errorImage,
                                                    boxShape:
                                                        BoxShape.rectangle,
                                                  ),
                                                ),
                                              ),
                                        10.w.horizontalSpacing,
                                        Flexible(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Flexible(
                                                    child: Text(
                                                      '${controller.profileDataController.firstName} ${controller.profileDataController.lastName}',
                                                      style: AppTextStyle
                                                          .fontSize18WhiteW700,
                                                    ),
                                                  ),
                                                  // Padding(
                                                  //   padding:
                                                  //       const EdgeInsets.all(
                                                  //           7.0),
                                                  //   child: Container(
                                                  //     height: 20,
                                                  //     width: 18,
                                                  //     decoration: BoxDecoration(
                                                  //       image: DecorationImage(
                                                  //         image: AssetImage(
                                                  //             ImagePath.camera),
                                                  //       ),
                                                  //     ),
                                                  //   ),
                                                  // ),
                                                ],
                                              ),
                                              Text(
                                                '${AppText.profileClass.tr}: ${controller.profilePersonal?.studentClass ?? ""}  |  ${AppText.profileSection.tr}: ${controller.profilePersonal?.section ?? ""}',
                                                style: AppTextStyle
                                                    .fontSize14LightPinkW400,
                                              ),
                                              Text(
                                                '${AppText.profileAdmission.tr}: ${controller.profilePersonal?.admissionNo ?? ""}  |  ${AppText.profileRoll.tr}: ${controller.profilePersonal?.roll ?? ""}',
                                                style: AppTextStyle
                                                    .fontSize12LightPinkW400,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30.0),
                                child: PageWidget(
                                  controller: controller,
                                ),
                              ),
                              5.h.verticalSpacing,
                            ],
                          ),
                        ),
                      ),
                      30.h.verticalSpacing,
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                          child: PageView(
                            controller: controller.profilePageController,
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              /// Personal Tab
                              controller.personalLoader.value
                                  ? const SecondaryLoadingWidget()
                                  : Column(
                                      children: [
                                        controller.profilePersonalPermissions
                                                    ?.dateOfBirth ==
                                                1
                                            ? ProfilePersonalWidget(
                                                icon: Iconsax.calendar,
                                                title: AppText.dateOfBirth.tr,
                                                value:
                                                    '${controller.profileDataController.dateOfBirth}',
                                              )
                                            : const SizedBox(),
                                        ProfilePersonalWidget(
                                          icon: Iconsax.chart,
                                          title: AppText.age.tr,
                                          value: controller.profilePersonal?.age
                                              .toString(),
                                        ),
                                        controller.profilePersonalPermissions
                                                    ?.phoneNumber ==
                                                1
                                            ? ProfilePersonalWidget(
                                                icon: Iconsax.call,
                                                title: AppText.phoneNumber.tr,
                                                value:
                                                    '${controller.profileDataController.phoneNumber}',
                                              )
                                            : const SizedBox(),
                                        controller.profilePersonalPermissions
                                                    ?.emailAddress ==
                                                1
                                            ? ProfilePersonalWidget(
                                                icon: Iconsax.sms,
                                                title: AppText.email.tr,
                                                value:
                                                    '${controller.profileDataController.email}',
                                              )
                                            : const SizedBox(),
                                        controller.profilePersonalPermissions
                                                    ?.permanentAddress ==
                                                1
                                            ? ProfilePersonalWidget(
                                                icon: Iconsax.location,
                                                title:
                                                    AppText.presentAddress.tr,
                                                value:
                                                    '${controller.profileDataController.presentAddress}',
                                              )
                                            : const SizedBox(),
                                      ],
                                    ),

                              /// Parents
                              controller.parentLoader.value
                                  ? const LoadingWidget()
                                  : SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          ParentsInfo(
                                            designation:
                                                AppText.profileFather.tr,
                                            icon: ImagePath.parentsProfile,
                                            name: controller.profileParents
                                                    ?.fathersName ??
                                                AppText.noDataAvailable.tr,
                                            phone: controller.profileParents
                                                    ?.fathersMobile ??
                                                AppText.noDataAvailable.tr,
                                            occupation: controller
                                                    .profileParents
                                                    ?.fathersOccupation ??
                                                AppText.noDataAvailable.tr,
                                            permissionForName: controller
                                                .profileParentsPermissions
                                                ?.fathersName,
                                            permissionForOccupation: controller
                                                .profileParentsPermissions
                                                ?.fathersOccupation,
                                            permissionForPhone: controller
                                                .profileParentsPermissions
                                                ?.fathersPhone,
                                            permissionForPhoto: controller
                                                .profileParentsPermissions
                                                ?.fathersName,
                                            imageUrl: controller
                                                .profileParents?.fathersPhoto,
                                          ),
                                          20.h.verticalSpacing,
                                          ParentsInfo(
                                            designation:
                                                AppText.profileMother.tr,
                                            icon: ImagePath.parentsProfile,
                                            name: controller.profileParents
                                                    ?.mothersName ??
                                                AppText.noDataAvailable.tr,
                                            phone: controller.profileParents
                                                    ?.mothersMobile ??
                                                AppText.noDataAvailable.tr,
                                            occupation: controller
                                                    .profileParents
                                                    ?.mothersOccupation ??
                                                AppText.noDataAvailable.tr,
                                            permissionForName: controller
                                                .profileParentsPermissions
                                                ?.mothersName,
                                            permissionForOccupation: controller
                                                .profileParentsPermissions
                                                ?.mothersOccupation,
                                            permissionForPhone: controller
                                                .profileParentsPermissions
                                                ?.mothersPhone,
                                            permissionForPhoto: controller
                                                .profileParentsPermissions
                                                ?.mothersPhoto,
                                            imageUrl: controller
                                                .profileParents?.mothersPhoto,
                                          ),
                                          20.h.verticalSpacing,
                                          GuardianInfo(
                                            designation:
                                                AppText.profileGuardian.tr,
                                            icon: ImagePath.parentsProfile,
                                            name: controller.profileParents
                                                    ?.guardiansName ??
                                                AppText.noDataAvailable,
                                            email: controller.profileParents
                                                    ?.guardiansEmail ??
                                                AppText.noDataAvailable.tr,
                                            phone: controller.profileParents
                                                    ?.guardiansMobile ??
                                                AppText.noDataAvailable.tr,
                                            occupation: controller
                                                    .profileParents
                                                    ?.guardiansOccupation ??
                                                AppText.noDataAvailable.tr,
                                            relation: controller.profileParents
                                                    ?.guardiansRelation ??
                                                AppText.noDataAvailable.tr,
                                            imageUrl: controller
                                                .profileParents?.guardiansPhoto,
                                            // other: "No data available",
                                            permissionForName: controller
                                                .profileParentsPermissions
                                                ?.guardiansName,
                                            permissionForOccupation: controller
                                                .profileParentsPermissions
                                                ?.guardiansOccupation,
                                            permissionForPhone: controller
                                                .profileParentsPermissions
                                                ?.guardiansPhone,
                                            permissionForPhoto: controller
                                                .profileParentsPermissions
                                                ?.guardiansPhoto,
                                            permissionForEmail: controller
                                                .profileParentsPermissions
                                                ?.guardiansEmail,
                                          ),
                                          SizedBox(
                                            height: Get.height * 0.3,
                                          ),
                                        ],
                                      ),
                                    ),

                              /// Transport
                              controller.transportLoader.value
                                  ? const LoadingWidget()
                                  : Column(
                                      children: [
                                        controller.profileTransportPermissions
                                                    ?.route ==
                                                1
                                            ? TransportWidget(
                                                title:
                                                    AppText.transportRoute.tr,
                                                value: controller
                                                    .profileTransport?.route,
                                              )
                                            : const SizedBox(),
                                        controller.profileTransportPermissions
                                                    ?.vehicle ==
                                                1
                                            ? TransportWidget(
                                                title: AppText
                                                    .transportVehicleNo.tr,
                                                value: controller
                                                    .profileTransport?.vehicle,
                                              )
                                            : const SizedBox(),
                                        TransportWidget(
                                          title: AppText.transportDriverName.tr,
                                          value: controller
                                              .profileTransport?.driver,
                                        ),
                                        TransportWidget(
                                          title:
                                              AppText.transportDriverPhoneNo.tr,
                                          value: controller
                                              .profileTransport?.mobile,
                                        ),
                                        controller.profileTransportPermissions
                                                    ?.dormitoryName ==
                                                1
                                            ? TransportWidget(
                                                title: AppText
                                                    .transportDormitory.tr,
                                                value: controller
                                                    .profileTransport
                                                    ?.dormitory,
                                              )
                                            : const SizedBox(),
                                      ],
                                    ),

                              ///Others
                              controller.othersLoader.value
                                  ? const LoadingWidget()
                                  : Column(
                                      children: [
                                        controller.profileOthersPermissions
                                                    ?.height ==
                                                1
                                            ? OthersTile(
                                                title: "Height".tr,
                                                value: controller.profileOthers
                                                        ?.height ??
                                                    AppText.noDataAvailable.tr,
                                              )
                                            : const SizedBox(),
                                        controller.profileOthersPermissions
                                                    ?.weight ==
                                                1
                                            ? OthersTile(
                                                title: "Weight".tr,
                                                value: controller.profileOthers
                                                        ?.weight ??
                                                    AppText.noDataAvailable.tr,
                                              )
                                            : const SizedBox(),
                                        controller.profileOthersPermissions
                                                    ?.nationalIdNumber ==
                                                0
                                            ? OthersTile(
                                                title: "National ID Number".tr,
                                                value: controller.profileOthers
                                                        ?.nationalIdNo ??
                                                    AppText.noDataAvailable.tr,
                                              )
                                            : const SizedBox(),
                                        controller.profileOthersPermissions
                                                    ?.localIdNumber ==
                                                1
                                            ? OthersTile(
                                                title: "Local ID Number".tr,
                                                value: controller.profileOthers
                                                        ?.localIdNo ??
                                                    AppText.noDataAvailable.tr,
                                              )
                                            : const SizedBox(),
                                        controller.profileOthersPermissions
                                                    ?.bankName ==
                                                1
                                            ? OthersTile(
                                                title: "Bank Name".tr,
                                                value: controller.profileOthers
                                                        ?.bankName ??
                                                    AppText.noDataAvailable.tr,
                                              )
                                            : const SizedBox(),
                                        controller.profileOthersPermissions
                                                    ?.bankAccountNumber ==
                                                1
                                            ? OthersTile(
                                                title: "Bank Account Number".tr,
                                                value: controller.profileOthers
                                                        ?.bankAccountNo ??
                                                    AppText.noDataAvailable.tr,
                                              )
                                            : const SizedBox(),
                                      ],
                                    ),

                              /// Documents Section
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  controller.globalRxVariableController.roleId
                                              .value ==
                                          4
                                      ? const SizedBox()
                                      : InkWell(
                                          onTap: () => controller
                                              .showUploadDocumentsBottomSheet(
                                            bottomSheetBackgroundColor:
                                                Colors.white,
                                            onTap: () {
                                              controller.pickFile();
                                            },
                                            onTapForSave: () {
                                              if (controller.formValidation()) {
                                                controller.uploadDocuments();
                                              }
                                            },
                                          ),
                                          child: Container(
                                            width: 200.w,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 10),
                                            decoration: BoxDecoration(
                                              color: AppColors.appButtonColor,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Transform.flip(
                                                  flipY: true,
                                                  child: Image.asset(
                                                    ImagePath.download,
                                                    scale: 4,
                                                    color: Colors.white,
                                                    height: 20.w,
                                                    width: 20.w,
                                                  ),
                                                ),
                                                5.w.horizontalSpacing,
                                                Text(
                                                  "Upload Document".tr,
                                                  style: AppTextStyle
                                                      .cardTextStyle14WhiteW500,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                  10.h.verticalSpacing,

                                  /// Documents Tiles
                                  controller.documentLoader.value
                                      ? const CircularProgressIndicator(
                                          color: AppColors.primaryColor,
                                        )
                                      : controller.documentsDataList.isNotEmpty
                                          ? Expanded(
                                              child: ListView.builder(
                                                physics:
                                                    const BouncingScrollPhysics(),
                                                itemCount: controller
                                                    .documentsDataList.length,
                                                itemBuilder: (context, index) {
                                                  return DeleteTile(
                                                      title:
                                                          "${index + 1}. ${controller.documentsDataList[index].title}",
                                                      subTitle: controller
                                                          .documentsDataList[
                                                              index]
                                                          .file
                                                          ?.split('/')
                                                          .last,
                                                      leftIconBackgroundColor:
                                                          AppColors
                                                              .appButtonColor,
                                                      leftIcon:
                                                          Iconsax.import_1,
                                                      rightIconBackgroundColor:
                                                          const Color(
                                                              0xFFED3B3B),
                                                      rightIcon: Iconsax.trash,

                                                      /// Delete button
                                                      tapRightButton: () =>
                                                          Get.dialog(
                                                            Obx(
                                                              () =>
                                                                  CustomPopupDialogue(
                                                                onYesTap: () {
                                                                  controller.deleteDocument(
                                                                      documentId: controller
                                                                          .documentsDataList[
                                                                              index]
                                                                          .id!,
                                                                      index:
                                                                          index);
                                                                },
                                                                isLoading:
                                                                    controller
                                                                        .deleteLoader
                                                                        .value,
                                                                title:
                                                                    'Confirmation'
                                                                        .tr,
                                                                subTitle: AppText
                                                                    .deleteDocumentsWarningMsg
                                                                    .tr,
                                                                noText:
                                                                    'Cancel'.tr,
                                                                yesText:
                                                                    'Delete'.tr,
                                                              ),
                                                            ),
                                                          ),

                                                      /// Download button
                                                      tapLeftButton: () async {
                                                        await PermissionCheck()
                                                            .checkPermissions(
                                                                Get.context!);
                                                        Get.dialog(
                                                          CustomPopupDialogue(
                                                            onYesTap: () {
                                                              Get.back();

                                                              controller.fileDownload(
                                                                  url: controller
                                                                          .documentsDataList[
                                                                              index]
                                                                          .file ??
                                                                      "",
                                                                  title: controller
                                                                          .documentsDataList[
                                                                              index]
                                                                          .title ??
                                                                      "");
                                                            },
                                                            title:
                                                                'Confirmation'
                                                                    .tr,
                                                            subTitle: AppText
                                                                .downloadMessage
                                                                .tr,
                                                            noText: 'No'.tr,
                                                            yesText:
                                                                'Download'.tr,
                                                          ),
                                                        );
                                                      });
                                                },
                                              ),
                                            )
                                          : const NoDataAvailableWidget(),
                                  210.h.verticalSpacing,
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
