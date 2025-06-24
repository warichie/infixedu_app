import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/data/constants/app_colors.dart';
import 'package:infixedu/app/data/constants/app_text_style.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/duplicate_dropdown.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/primary_button.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/text_field.dart';
import 'package:infixedu/app/utilities/widgets/customised_loading_widget/customised_loading_widget.dart';

import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../controllers/admin_class_attendance_search_controller.dart';

class AdminClassAttendanceSearchView
    extends GetView<AdminClassAttendanceSearchController> {
  const AdminClassAttendanceSearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => InfixEduScaffold(
        title: "Class Attendance Search".tr,
        body: CustomBackground(
          customWidget: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 15),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${"Select".tr} ${"Class".tr} *",
                    style: AppTextStyle.fontSize13BlackW400,
                  ),
                  10.h.verticalSpacing,

                  /// Class Dropdown
                  controller.adminStudentsSearchController.loadingController
                          .isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : DuplicateDropdown(
                          dropdownValue: controller
                                  .adminStudentsSearchController
                                  .classList
                                  .isEmpty
                              ? controller.classNullValue.value
                              : controller.adminStudentsSearchController
                                  .classValue.value,
                          dropdownList: controller
                              .adminStudentsSearchController.classList,
                          changeDropdownValue: (v) {
                            controller.adminStudentsSearchController.classValue
                                .value = v!;
                            controller.adminStudentsSearchController
                                .studentClassId.value = v.id;
                            controller.adminStudentsSearchController
                                .getStudentSectionList(
                                    classId: controller
                                        .adminStudentsSearchController
                                        .studentClassId
                                        .value);
                          },
                        ),
                  10.h.verticalSpacing,
                  Text(
                    "${"Select".tr} ${"Section".tr} *",
                    style: AppTextStyle.fontSize13BlackW400,
                  ),
                  10.h.verticalSpacing,

                  /// Section Dropdown
                  controller.adminStudentsSearchController.sectionLoader.value
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primaryColor,
                          ),
                        )
                      : DuplicateDropdown(
                          dropdownValue: controller
                                  .adminStudentsSearchController
                                  .sectionList
                                  .isEmpty
                              ? controller.sectionNullValue.value
                              : controller.adminStudentsSearchController
                                  .sectionValue.value,
                          dropdownList: controller
                              .adminStudentsSearchController.sectionList,
                          changeDropdownValue: (v) {
                            controller.adminStudentsSearchController
                                .sectionValue.value = v!;
                            controller.adminStudentsSearchController
                                .studentSectionId.value = v.id;
                          },
                        ),
                  10.h.verticalSpacing,
                  CustomTextFormField(
                    iconOnTap: () {
                      controller.selectDate();
                    },
                    readOnly: true,
                    controller: controller.selectedDateTextController,
                    enableBorderActive: true,
                    focusBorderActive: true,
                    hintText: "${"Select Date".tr}*",
                    fillColor: Colors.white,
                    suffixIcon: Icon(
                      Iconsax.calendar5,
                      size: 16.w,
                    ),
                  ),

                  30.h.verticalSpacing,
                  controller.isLoading.value
                      ? const SecondaryLoadingWidget(
                          isBottomNav: true,
                        )
                      : PrimaryButton(
                          text: "Search".tr,
                          onTap: () {
                            if (controller.validation()) {
                              controller.getStudentAttendanceList(
                                studentClassId: controller
                                    .adminStudentsSearchController
                                    .studentClassId
                                    .value,
                                studentSectionId: controller
                                    .adminStudentsSearchController
                                    .studentSectionId
                                    .value,
                                selectedDate:
                                    controller.selectedDateTextController.text,
                              );
                            }
                          },
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
