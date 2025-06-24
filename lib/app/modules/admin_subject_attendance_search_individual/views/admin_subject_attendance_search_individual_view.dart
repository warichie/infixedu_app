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
import '../controllers/admin_subject_attendance_search_individual_controller.dart';

class AdminSubjectAttendanceSearchIndividualView
    extends GetView<AdminSubjectAttendanceSearchIndividualController> {
  const AdminSubjectAttendanceSearchIndividualView({super.key});

  @override
  Widget build(BuildContext context) {
    return InfixEduScaffold(
      title: "Subject Wise Attendance Search".tr,
      body: CustomBackground(
        customWidget: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 15),
          child: Obx(
            () => SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${"Select".tr} ${"Class".tr} *",
                    style: AppTextStyle.fontSize13BlackW400,
                  ),
                  10.h.verticalSpacing,
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
                    controller: controller.nameTextController,
                    enableBorderActive: true,
                    focusBorderActive: true,
                    hintText: "Name".tr,
                    fillColor: Colors.white,
                  ),
                  10.h.verticalSpacing,
                  CustomTextFormField(
                    controller: controller.rollTextController,
                    enableBorderActive: true,
                    focusBorderActive: true,
                    hintText: "Roll".tr,
                    fillColor: Colors.white,
                  ),
                  30.h.verticalSpacing,
                  controller.searchLoader.value
                      ? const SecondaryLoadingWidget(
                          isBottomNav: true,
                        )
                      : PrimaryButton(
                          text: "Search".tr,
                          onTap: () {
                            controller.getSearchStudentDataList(
                              classId: controller.adminStudentsSearchController
                                  .studentClassId.value,
                              sectionId: controller
                                  .adminStudentsSearchController
                                  .studentSectionId
                                  .value,
                              subjectId: controller
                                  .adminStudentsSearchController
                                  .studentSubjectId
                                  .value,
                              rollNo: controller.rollTextController.text,
                              name: controller.nameTextController.text,
                            );
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
