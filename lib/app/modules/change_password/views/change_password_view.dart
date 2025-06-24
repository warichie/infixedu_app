import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/data/constants/app_colors.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:infixedu/app/utilities/widgets/button/primary_button.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/text_field.dart';
import 'package:infixedu/app/utilities/widgets/customised_loading_widget/customised_loading_widget.dart';

import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../controllers/change_password_controller.dart';

class ChangePasswordView extends GetView<ChangePasswordController> {
  const ChangePasswordView({super.key});
  @override
  Widget build(BuildContext context) {
    return InfixEduScaffold(
      title: "Change Password".tr,
      body: CustomBackground(
        customWidget: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: SingleChildScrollView(
            child: Obx(() => Column(
                  children: [
                    20.h.verticalSpacing,
                    CustomTextFormField(
                      obsCureText: controller.currentPassObscureText.value,
                      enableBorderActive: true,
                      focusBorderActive: true,
                      hintText: "Current Password".tr,
                      fillColor: Colors.white,
                      controller: controller.currentPasswordController,
                      suffixIcon: Icon(
                        controller.currentPassObscureText.value
                            ? Iconsax.lock
                            : Iconsax.unlock,
                        color: AppColors.loginIconColor,
                      ),
                      iconOnTap: () {
                        controller.currentPassObscureText.value =
                            !controller.currentPassObscureText.value;
                      },
                    ),
                    10.h.verticalSpacing,
                    CustomTextFormField(
                      obsCureText: controller.newPassObscureText.value,
                      enableBorderActive: true,
                      focusBorderActive: true,
                      hintText: "New Password".tr,
                      fillColor: Colors.white,
                      controller: controller.newPasswordController,
                      iconOnTap: () {
                        controller.newPassObscureText.value =
                            !controller.newPassObscureText.value;
                      },
                      suffixIcon: Icon(
                        controller.newPassObscureText.value
                            ? Iconsax.lock
                            : Iconsax.unlock,
                        color: AppColors.loginIconColor,
                      ),
                    ),
                    10.h.verticalSpacing,
                    CustomTextFormField(
                      obsCureText: controller.confirmPassObscureText.value,
                      enableBorderActive: true,
                      focusBorderActive: true,
                      hintText: "Confirm Password".tr,
                      fillColor: Colors.white,
                      controller: controller.confirmPasswordController,
                      suffixIcon: Icon(
                        controller.confirmPassObscureText.value
                            ? Iconsax.lock
                            : Iconsax.unlock,
                        color: AppColors.loginIconColor,
                      ),
                      iconOnTap: () {
                        controller.confirmPassObscureText.value =
                            !controller.confirmPassObscureText.value;
                      },
                    ),
                    30.h.verticalSpacing,
                    Obx(() => controller.passLoader.value
                        ? const SecondaryLoadingWidget()
                        : SecondaryButton(
                            onTap: () {
                              if (controller.validation()) {
                                controller.changePassword();
                              }
                            },
                            title: "Save".tr,
                            height: 25.h,
                            radius: 30,
                          ))
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
