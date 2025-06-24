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
import '../controllers/admin_class_attendance_search_individual_controller.dart';

class AdminClassAttendanceSearchIndividualView
    extends GetView<AdminClassAttendanceSearchIndividualController> {
  const AdminClassAttendanceSearchIndividualView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => InfixEduScaffold(
        title: "Search Attendance".tr,
        body: CustomBackground(
          customWidget: Padding(
            padding: EdgeInsets.all(10.0.w),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${"Select".tr} ${"Class".tr} *",
                    style: AppTextStyle.fontSize13BlackW400,
                  ),
                  10.h.verticalSpacing,

                  /// Student Class List Dropdown
                  controller.loadingController.isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primaryColor,
                          ),
                        )
                      : DuplicateDropdown(
                          dropdownValue: controller
                              .adminStudentsSearchController.classValue.value,
                          dropdownList: controller
                              .adminStudentsSearchController.classList,
                          changeDropdownValue: (v) {
                            controller.adminStudentsSearchController.classValue
                                .value = v!;
                            controller.adminStudentsSearchController
                                .studentClassId.value = v.id;

                            controller.adminStudentsSearchController
                                .getStudentSectionList(
                              classId: controller.adminStudentsSearchController
                                  .studentClassId.value,
                            );
                          },
                        ),
                  10.h.verticalSpacing,
                  Text(
                    "${"Select".tr} ${"Section".tr} *",
                    style: AppTextStyle.fontSize13BlackW400,
                  ),
                  10.h.verticalSpacing,

                  /// Student Section List Dropdown
                  controller.adminStudentsSearchController.sectionLoader.value
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primaryColor,
                          ),
                        )
                      : DuplicateDropdown(
                          dropdownValue: controller
                              .adminStudentsSearchController.sectionValue.value,
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
                    textInputType: TextInputType.number,
                    hintText: "Roll".tr,
                    fillColor: Colors.white,
                  ),
                  30.h.verticalSpacing,
                  controller.adminStudentsSearchController.searchLoader.value
                      ? const CircularProgressIndicator(
                          color: AppColors.primaryColor,
                        )
                      : PrimaryButton(
                          text: "Search".tr,
                          onTap: () {
                            Get.toNamed(
                              Routes
                                  .ADMIN_CLASS_ATTENDANCE_SEARCH_INDIVIDUAL_LIST,
                              arguments: {
                                'class_id': controller
                                    .adminStudentsSearchController
                                    .studentClassId
                                    .value,
                                'section_id': controller
                                    .adminStudentsSearchController
                                    .studentSectionId
                                    .value,
                                'name': controller.nameTextController.text,
                                'roll_no': controller.rollTextController.text,
                              },
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
