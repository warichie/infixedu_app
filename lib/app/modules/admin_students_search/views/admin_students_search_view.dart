import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/data/constants/app_text_style.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:infixedu/app/utilities/message/snack_bars.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/duplicate_dropdown.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/primary_button.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/text_field.dart';
import 'package:infixedu/app/utilities/widgets/customised_loading_widget/customised_loading_widget.dart';
import 'package:get/get.dart';

import '../../../data/constants/app_colors.dart';
import '../controllers/admin_students_search_controller.dart';

class AdminStudentsSearchView extends GetView<AdminStudentsSearchController> {
  const AdminStudentsSearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => InfixEduScaffold(
        title: "Students".tr,
        body: CustomBackground(
          customWidget: Padding(
            padding: const EdgeInsets.all(10.0),
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
                          dropdownValue: controller.classValue.value,
                          dropdownList: controller.classList,
                          changeDropdownValue: (v) {
                            controller.classValue.value = v!;
                            controller.studentClassId.value = v.id;

                            controller.getStudentSectionList(
                              classId: controller.studentClassId.value,
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
                  controller.sectionLoader.value
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primaryColor,
                          ),
                        )
                      : DuplicateDropdown(
                          dropdownValue: controller.sectionValue.value,
                          dropdownList: controller.sectionList,
                          changeDropdownValue: (v) {
                            controller.sectionValue.value = v!;
                            controller.studentSectionId.value = v.id;
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
                  controller.searchLoader.value
                      ? const SecondaryLoadingWidget(
                          isBottomNav: true,
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: PrimaryButton(
                            text: "Search".tr,
                            onTap: () {
                              if (controller.rollTextController.text.trim() ==
                                  '0') {
                                showBasicFailedSnackBar(
                                    message: "'0' ${"is not a valid roll".tr}");
                                return;
                              }
                              controller.getSearchStudentDataList(
                                classId: controller.studentClassId.value,
                                sectionId: controller.studentSectionId.value,
                                rollNo: controller.rollTextController.text,
                                name: controller.nameTextController.text,
                              );
                            },
                          ),
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
