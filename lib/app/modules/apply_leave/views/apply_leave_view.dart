// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/data/constants/app_colors.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:infixedu/app/utilities/widgets/bottom_nav_button/bottom_nav_button.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_browse_icon.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/duplicate_dropdown.dart';
import 'package:infixedu/app/utilities/widgets/customised_loading_widget/customised_loading_widget.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../data/constants/app_text_style.dart';
import '../../../utilities/widgets/common_widgets/custom_divider.dart';
import '../../../utilities/widgets/common_widgets/text_field.dart';
import '../controllers/apply_leave_controller.dart';

class ApplyLeaveView extends GetView<ApplyLeaveController> {
  const ApplyLeaveView({super.key});

  @override
  Widget build(BuildContext context) {
    return InfixEduScaffold(
        title: "Apply Leave".tr,
        body: CustomBackground(
          customWidget: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0.w, vertical: 30),
            child: SingleChildScrollView(
              child: Obx(
                () => Column(
                  children: [
                    controller.isLoading.value
                        ? const CircularProgressIndicator(
                            color: AppColors.primaryColor,
                          )
                        : DuplicateDropdown(
                            hint: '${"Select leave type".tr} *',
                            dropdownValue: controller.dropdownValue.value,
                            dropdownList: controller.applyLeaveTypeList,
                            changeDropdownValue: (v) {
                              controller.dropdownValue.value = v!;
                              controller.leaveTypeId.value = v.id;
                            },
                          ),
                    10.h.verticalSpacing,

                    /// Text Field
                    CustomTextFormField(
                      iconOnTap: () {
                        controller.changeApplyDate();
                      },
                      readOnly: true,
                      controller: controller.applyDateTextController,
                      enableBorderActive: true,
                      focusBorderActive: true,
                      hintText: "${"Apply Date".tr} *".tr,
                      fillColor: Colors.white,
                      suffixIcon: Icon(
                        Iconsax.calendar5,
                        size: 16.w,
                      ),
                    ),
                    10.h.verticalSpacing,
                    CustomTextFormField(
                      iconOnTap: () {
                        controller.changeFromDate();
                      },
                      readOnly: true,
                      controller: controller.fromDateTextController,
                      enableBorderActive: true,
                      focusBorderActive: true,
                      hintText: "${"From Date".tr} *".tr,
                      fillColor: Colors.white,
                      suffixIcon: Icon(
                        Iconsax.calendar5,
                        size: 16.w,
                      ),
                    ),
                    10.h.verticalSpacing,
                    CustomTextFormField(
                      iconOnTap: () {
                        controller.changeToDate();
                      },
                      readOnly: true,
                      controller: controller.toDateTextController,
                      enableBorderActive: true,
                      focusBorderActive: true,
                      hintText: "${"To Date".tr} *".tr,
                      fillColor: Colors.white,
                      suffixIcon: Icon(
                        Iconsax.calendar5,
                        size: 16.w,
                      ),
                    ),
                    10.h.verticalSpacing,
                    CustomTextFormField(
                      enableBorderActive: true,
                      focusBorderActive: true,
                      readOnly: true,
                      hintText: controller.file.value.path.isNotEmpty
                          ? controller.file.value.toString().split('/').last
                          : 'Select File'.tr,
                      fillColor: Colors.white,
                      suffixIcon: const CustomBrowseIcon(),
                      iconOnTap: () {
                        controller.pickFile();
                        debugPrint("Browser ::: ${controller.file}");
                      },
                    ),
                    10.h.verticalSpacing,
                    CustomTextFormField(
                      controller: controller.reasonTextController,
                      enableBorderActive: true,
                      focusBorderActive: true,
                      hintText: "Reason".tr,
                      fillColor: Colors.white,
                    ),
                    20.h.verticalSpacing,
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomNavBar: Obx(
          () => controller.loadingController.isLoading
              ? const SecondaryLoadingWidget(
                  isBottomNav: true,
                )
              : BottomNavButton(
                  onTap: () {
                    if (controller.validation()) {
                      controller.applyLeave();
                    }
                  },
                  text: 'Apply'.tr,
                ),
        )

        /// Button
        );
  }
}
