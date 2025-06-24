import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/data/constants/app_colors.dart';
import 'package:infixedu/app/data/constants/app_text_style.dart';
import 'package:infixedu/app/routes/app_pages.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/duplicate_dropdown.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/primary_button.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/text_field.dart';

import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../controllers/admin_subject_attendance_search_controller.dart';

class AdminSubjectAttendanceSearchView
    extends GetView<AdminSubjectAttendanceSearchController> {
  const AdminSubjectAttendanceSearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => InfixEduScaffold(
        title: "Subject Attendance Search".tr,
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

                  /// Student Class List
                  controller.adminStudentsSearchController.loadingController
                          .isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primaryColor,
                          ),
                        )
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

                  /// Student Section List
                  10.h.verticalSpacing,
                  Text(
                    "${"Select".tr} ${"Section".tr} *",
                    style: AppTextStyle.fontSize13BlackW400,
                  ),
                  10.h.verticalSpacing,
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
                            controller.adminStudentsSearchController
                                .getAdminStudentSubjectList(
                              classId: controller.adminStudentsSearchController
                                  .studentClassId.value,
                              sectionId: controller
                                  .adminStudentsSearchController
                                  .studentSectionId
                                  .value,
                            );
                          },
                        ),

                  /// Student Subject List
                  10.h.verticalSpacing,
                  Text(
                    "${"Select".tr} ${"Subject".tr} *",
                    style: AppTextStyle.fontSize13BlackW400,
                  ),
                  10.h.verticalSpacing,
                  controller.adminStudentsSearchController.subjectLoader.value
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primaryColor,
                          ),
                        )
                      : DuplicateDropdown(
                          dropdownValue: controller
                                  .adminStudentsSearchController
                                  .subjectList
                                  .isEmpty
                              ? controller.subjectNullValue.value
                              : controller.adminStudentsSearchController
                                  .subjectValue.value,
                          dropdownList: controller
                              .adminStudentsSearchController.subjectList,
                          changeDropdownValue: (v) {
                            controller.adminStudentsSearchController
                                .subjectValue.value = v!;
                            controller.adminStudentsSearchController
                                .studentSubjectId.value = v.id;
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
                    hintText: "${"Select Date".tr} *",
                    fillColor: Colors.white,
                    hintTextStyle: AppTextStyle.fontSize14lightBlackW400,
                    suffixIcon: Icon(
                      Iconsax.calendar5,
                      size: 16.w,
                    ),
                  ),
                  30.h.verticalSpacing,
                  PrimaryButton(
                    text: "Search".tr,
                    onTap: () {
                      if (controller.validation()) {
                        Get.toNamed(Routes.ADMIN_SUBJECT_ATTENDANCE_SEARCH_LIST,
                            arguments: {
                              'class_id': controller
                                  .adminStudentsSearchController
                                  .studentClassId
                                  .value,
                              'section_id': controller
                                  .adminStudentsSearchController
                                  .studentSectionId
                                  .value,
                              'subject_id': controller
                                  .adminStudentsSearchController
                                  .studentSubjectId
                                  .value,
                              'date':
                                  controller.selectedDateTextController.text,
                            });
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
