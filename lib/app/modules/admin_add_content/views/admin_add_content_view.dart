import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/data/constants/app_colors.dart';
import 'package:infixedu/app/data/constants/app_text_style.dart';
import 'package:infixedu/app/data/constants/image_path.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_browse_icon.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/description_text_field.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/duplicate_dropdown.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/primary_button.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/text_field.dart';
import 'package:infixedu/app/utilities/widgets/custom_checkbox/custom_checkbox.dart';
import 'package:infixedu/app/utilities/widgets/custom_dropdown.dart';
import 'package:infixedu/app/utilities/widgets/customised_loading_widget/customised_loading_widget.dart';

import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../controllers/admin_add_content_controller.dart';

class AdminAddContentView extends GetView<AdminAddContentController> {
  const AdminAddContentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => InfixEduScaffold(
        title: "Add Content".tr,
        body: CustomBackground(
          customWidget: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0.w, horizontal: 15),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  10.verticalSpacing,

                  Text('${"Content Type".tr}*',
                      style: AppTextStyle.fontSize14BlackW500),
                  5.h.verticalSpacing,
                  CustomDropdown(
                    dropdownValue: controller.contentInitialValue.value,
                    dropdownList: controller.contentList,
                    changeDropdownValue: (value) {
                      controller.contentInitialValue.value = value!;
                      controller.contentType.value = controller
                          .contentInitialValue.value
                          .substring(0, 2)
                          .toLowerCase();
                    },
                  ),
                  15.h.verticalSpacing,

                  /// Title
                  CustomTextFormField(
                    controller: controller.titleTextController,
                    enableBorderActive: true,
                    focusBorderActive: true,
                    hintText: "${"Title".tr}*",
                    fillColor: Colors.white,
                  ),
                  15.h.verticalSpacing,
                  Text(
                    "${"Available For".tr}*",
                    style: AppTextStyle.fontSize14BlackW500,
                  ),

                  //All Admin radio button
                  CustomCheckbox(
                    checkboxValue: controller.isAdminSelected.value,
                    checkboxTitle: "All Admin".tr,
                    onChange: (bool? value) {
                      controller.isAdminSelected.value = value!;
                      controller.isStudent.value = true;
                      controller.isAdminSelected.value
                          ? controller.availableForList.add('admin')
                          : controller.availableForList.remove('admin');
                    },
                    shape: const CircleBorder(),
                  ),

                  10.h.verticalSpacing,
                  //student radio button
                  CustomCheckbox(
                    checkboxValue: controller.isStudentSelected.value,
                    checkboxTitle: "Student".tr,
                    onChange: (bool? value) {
                      controller.isStudentSelected.value = value!;
                      controller.isStudent.value = true;
                      controller.isStudentSelected.value
                          ? controller.availableForList.add('student')
                          : controller.availableForList.remove('student');
                    },
                    shape: const CircleBorder(),
                  ),

                  10.h.verticalSpacing,
                  controller.isStudentSelected.value
                      ? CustomCheckbox(
                          checkboxValue: controller.isAllStudent.value,
                          checkboxTitle: "All Students".tr,
                          onChange: (bool? value) {
                            controller.isAllStudent.value = value!;
                            controller.isStudent.value = false;
                            controller.isAllStudent.value
                                ? controller.allClasses.value = 'on'
                                : controller.allClasses.value = '';
                          },
                        )
                      : const SizedBox(),

                  10.h.verticalSpacing,

                  /// Student Class List Dropdown
                  controller.isStudentSelected.value &&
                          controller.isAllStudent.value == false
                      ? controller.loadingController.isLoading
                          ? const CircularProgressIndicator(
                              color: AppColors.primaryColor,
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
                                controller.adminStudentsSearchController
                                    .classValue.value = v!;
                                controller.adminStudentsSearchController
                                    .studentClassId.value = v.id;
                                controller.adminStudentsSearchController
                                    .getStudentSectionList(classId: v.id);
                              },
                            )
                      : const SizedBox(),
                  10.h.verticalSpacing,

                  /// Student Section List Dropdown
                  controller.isStudentSelected.value &&
                          controller.isAllStudent.value == false
                      ? controller.sectionLoader.value
                          ? const CircularProgressIndicator(
                              color: AppColors.primaryColor,
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
                            )
                      : const SizedBox(),

                  10.h.verticalSpacing,
                  // assign date
                  CustomTextFormField(
                    iconOnTap: () {
                      controller.selectDate();
                    },
                    readOnly: true,
                    controller: controller.selectedDateTextController,
                    enableBorderActive: true,
                    focusBorderActive: true,
                    hintText: "${"Assign Date".tr}*",
                    fillColor: Colors.white,
                    suffixIcon: Icon(
                      Iconsax.calendar5,
                      size: 16.w,
                    ),
                  ),
                  10.h.verticalSpacing,

                  /// Select File
                  CustomTextFormField(
                    enableBorderActive: true,
                    focusBorderActive: true,
                    readOnly: true,
                    hintText: controller.contentFile.value.path.isNotEmpty
                        ? controller.contentFile.value
                            .toString()
                            .split('/')
                            .last
                        : 'Select File'.tr,
                    fillColor: Colors.white,
                    suffixIcon: const CustomBrowseIcon(),
                    iconOnTap: () {
                      controller.pickFile();
                    },
                  ),
                  10.h.verticalSpacing,

                  /// Description
                  DescriptionTextFormField(
                    controller: controller.descriptionTextController,
                    hintText: "Description".tr,
                    maxLine: 3,
                    minLine: 2,
                  ),

                  /// Save button
                  30.h.verticalSpacing,
                  controller.saveLoader.value
                      ? const SecondaryLoadingWidget(
                          isBottomNav: true,
                        )
                      : PrimaryButton(
                          text: "Save".tr,
                          onTap: () {
                            if (controller.validation()) {
                              controller.uploadContent();
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
