import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/data/constants/app_colors.dart';
import 'package:infixedu/app/data/constants/image_path.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../data/constants/app_dimens.dart';
import '../../../data/constants/app_text.dart';
import '../../../service/image/image_picker_utils.dart';
import '../../../utilities/widgets/common_widgets/custom_background.dart';
import '../../../utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import '../../../utilities/widgets/image_view/cache_image_view.dart';
import 'widget/edit_profile_text_field.dart';
import '../controllers/profile_edit_controller.dart';

class ProfileEditView extends GetView<ProfileEditController> {
  const ProfileEditView({super.key});

  @override
  Widget build(BuildContext context) {
    return InfixEduScaffold(
      title: "Edit Profile".tr,
      actions: const [SizedBox()],
      body: CustomBackground(
        customWidget: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                50.h.verticalSpacing,

                Obx(
                  () => Stack(
                    alignment: AlignmentDirectional.center,
                    children: <Widget>[
                      controller.profileDataController.profilePickedImage.value
                              .path.isEmpty
                          ? controller.profileDataController.profilePhoto
                                      .isEmpty ||
                                  controller.profileDataController.profilePhoto
                                          .value ==
                                      ''
                              ? Container(
                                  height: 100.w,
                                  width: 100.w,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: AssetImage(
                                            ImagePath.editProfileImage),
                                        fit: BoxFit.cover),
                                  ),
                                )
                              : SizedBox(
                                  height: 100.w,
                                  width: 100.w,
                                  child: ClipRRect(
                                    borderRadius: 100.w.circularRadius,
                                    child: CacheImageView(
                                      url: controller
                                          .profileDataController.profilePhoto
                                          .toString(),
                                      errorImageLocal:
                                          'assets/image/production/avatar.png',
                                    ),
                                  ),
                                )
                          : ClipRRect(
                              borderRadius: AppDimens.radius100.circularRadius,
                              child: Image.file(
                                height: 100.w,
                                width: 100.w,
                                File(controller.profileDataController
                                    .profilePickedImage.value.path),
                                fit: BoxFit.cover,
                              ),
                            ),
                      Positioned(
                          bottom: 10.w,
                          right: 0,
                          child: InkWell(
                            onTap: () {
                              FlutterImagePickerUtils.imagePickerModalSheet(
                                context: context,
                                fromGallery: () async {
                                  controller.profileDataController
                                          .profilePickedImage.value =
                                      await FlutterImagePickerUtils
                                          .getImageGallery(
                                    context,
                                  );
                                  if (controller
                                      .profileDataController
                                      .profilePickedImage
                                      .value
                                      .path
                                      .isNotEmpty) {
                                    controller.profilePhotoUpdate(
                                        file: controller.profileDataController
                                            .profilePickedImage.value.path);
                                  }
                                },
                                fromCamera: () async {
                                  controller.profileDataController
                                          .profilePickedImage.value =
                                      await FlutterImagePickerUtils
                                          .getImageCamera(
                                    context,
                                  );
                                  if (controller
                                      .profileDataController
                                      .profilePickedImage
                                      .value
                                      .path
                                      .isNotEmpty) {
                                    controller.profilePhotoUpdate(
                                        file: controller.profileDataController
                                            .profilePickedImage.value.path);
                                  }
                                },
                              );
                            },
                            child: Container(
                              height: 25.w,
                              width: 25.w,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.primaryColor),
                              child: Center(
                                child: Image.asset(
                                  ImagePath.edit,
                                  height: 12.w,
                                  width: 12.w,
                                ),
                              ),
                            ),
                          ) //Icon
                          ),
                    ], //<Widget>[]
                  ),
                ),
                //
                30.h.verticalSpacing,

                /// First Name Field
                EditProfileTextField(
                  labelText: AppText.editProfileFirstName.tr,
                  controller: controller.firstNameTextController,
                  iconOnTap: () => controller.userProfileInfoUpdate(),
                ),
                15.h.verticalSpacing,

                /// Lst Name Field
                EditProfileTextField(
                  iconOnTap: () => controller.userProfileInfoUpdate(),
                  labelText: AppText.editProfileLastName.tr,
                  hintText: AppText.editProfileLastName.tr,
                  controller: controller.lastNameTextController,
                ),
                15.h.verticalSpacing,

                /// Email Field
                EditProfileTextField(
                  labelText: AppText.editProfileEmail.tr,
                  readOnly:
                      controller.globalRxVariableController.roleId.value == 1
                          ? false
                          : true,
                  suffixIcon:
                      controller.globalRxVariableController.roleId.value == 1
                          ? InkWell(
                              onTap: () => controller.userProfileInfoUpdate(),
                              child: Image.asset(
                                ImagePath.editBlack,
                                height: 10,
                                width: 10,
                                scale: 3,
                              ),
                            )
                          : const SizedBox(),
                  hintText: AppText.editProfileEmail.tr,
                  controller: controller.emailTextController,
                ),
                15.h.verticalSpacing,

                /// Phone Number Field
                EditProfileTextField(
                  labelText: AppText.editProfilePhoneNumber.tr,
                  suffixIcon:
                      controller.globalRxVariableController.roleId.value == 1
                          ? InkWell(
                              onTap: () => controller.userProfileInfoUpdate(),
                              child: Image.asset(
                                ImagePath.editBlack,
                                height: 10,
                                width: 10,
                                scale: 3,
                              ),
                            )
                          : const SizedBox(),
                  readOnly:
                      controller.globalRxVariableController.roleId.value == 1
                          ? false
                          : true,
                  hintText: AppText.editProfilePhoneNumber.tr,
                  controller: controller.phoneNumberTextController,
                ),
                15.h.verticalSpacing,

                /// Date of Birth Field
                EditProfileTextField(
                  readOnly: true,
                  labelText: AppText.editProfileDateOfBirth.tr,
                  suffixIcon: InkWell(
                    onTap: () {
                      controller.dateOfBirth();
                    },
                    child: Icon(
                      Iconsax.calendar5,
                      size: 16.w,
                    ),
                  ),
                  hintText: AppText.editProfileDateOfBirth.tr,
                  controller: controller.dateOfBirthTextController,
                ),
                15.h.verticalSpacing,

                /// Current Address
                EditProfileTextField(
                  iconOnTap: () => controller.userProfileInfoUpdate(),
                  labelText: AppText.editProfileCurrentAddress.tr,
                  hintText: AppText.editProfileCurrentAddress.tr,
                  controller: controller.currentAddressTextController,
                ),
                50.h.verticalSpacing,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
