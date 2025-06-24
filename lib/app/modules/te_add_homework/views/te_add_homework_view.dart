import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/data/constants/app_text_style.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_browse_icon.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/description_text_field.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/duplicate_dropdown.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/primary_button.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/text_field.dart';

import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../controllers/te_add_homework_controller.dart';

class TeAddHomeworkView extends GetView<TeAddHomeworkController> {
  const TeAddHomeworkView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => InfixEduScaffold(
        title: "Add Homework".tr,
        body: CustomBackground(
          customWidget: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 10.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${"Select".tr} ${"Class".tr} *',
                    style: AppTextStyle.fontSize13BlackW400,
                  ),
                  5.h.verticalSpacing,

                  /// Class Dropdown
                  controller.classLoader.value
                      ? const Center(child: CircularProgressIndicator())
                      : DuplicateDropdown(
                          dropdownValue:
                              controller.teacherClassInitialValue.value,
                          dropdownList: controller.teacherClassList,
                          changeDropdownValue: (value) {
                            controller.teacherClassInitialValue.value = value!;
                            controller.teacherClassId.value = value.id;
                            controller.getTeacherSubjectList(
                                classId: controller.teacherClassId.value);
                          },
                        ),
                  10.h.verticalSpacing,

                  Text(
                    '${"Select".tr} ${"Subject".tr} *',
                    style: AppTextStyle.fontSize13BlackW400,
                  ),
                  5.h.verticalSpacing,

                  /// subject Dropdown
                  controller.subjectLoader.value
                      ? const Center(child: CircularProgressIndicator())
                      : DuplicateDropdown(
                          dropdownValue:
                              controller.teacherSubjectInitialValue.value,
                          dropdownList: controller.teacherSubjectList,
                          changeDropdownValue: (value) {
                            controller.teacherSubjectInitialValue.value =
                                value!;
                            controller.teacherSubjectId.value = value.id;
                            controller.getTeacherSectionList(
                                classId: controller.teacherClassId.value,
                                subjectId: controller.teacherSubjectId.value);
                          },
                        ),
                  10.h.verticalSpacing,

                  Text(
                    '${"Select".tr} ${"Section".tr} *',
                    style: AppTextStyle.fontSize13BlackW400,
                  ),
                  5.h.verticalSpacing,

                  /// Class Dropdown
                  controller.sectionLoader.value
                      ? const Center(child: CircularProgressIndicator())
                      : DuplicateDropdown(
                          dropdownValue:
                              controller.teacherSectionInitialValue.value,
                          dropdownList: controller.teacherSectionList,
                          changeDropdownValue: (value) {
                            controller.teacherSectionInitialValue.value =
                                value!;
                            controller.teacherSectionId.value = value.id;
                          },
                        ),

                  10.h.verticalSpacing,
                  CustomTextFormField(
                    iconOnTap: () {
                      controller.assignDate();
                    },
                    readOnly: true,
                    controller: controller.assignDateTextController,
                    enableBorderActive: true,
                    focusBorderActive: true,
                    hintText: "${"Assign Date".tr} *",
                    fillColor: Colors.white,
                    suffixIcon: Icon(
                      Iconsax.calendar5,
                      size: 16.w,
                    ),
                  ),
                  10.h.verticalSpacing,
                  CustomTextFormField(
                    iconOnTap: () {
                      controller.submissionDate();
                    },
                    readOnly: true,
                    controller: controller.submissionDateTextController,
                    enableBorderActive: true,
                    focusBorderActive: true,
                    hintText: "${"Submission Date".tr} *",
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
                    hintText: controller.homeworkFile.value.path.isNotEmpty
                        ? controller.homeworkFile.value
                            .toString()
                            .split('/')
                            .last
                        : 'Select File'.tr,
                    fillColor: Colors.white,
                    suffixIcon: const CustomBrowseIcon(),
                    iconOnTap: () {
                      controller.pickFile();
                      debugPrint("Browser ::: ${controller.homeworkFile}");
                    },
                  ),
                  10.h.verticalSpacing,
                  CustomTextFormField(
                    controller: controller.marksTextController,
                    enableBorderActive: true,
                    focusBorderActive: true,
                    hintText: "${"Marks".tr} *",
                    textInputType: TextInputType.number,
                    fillColor: Colors.white,
                    iconOnTap: () {
                      debugPrint("Browser");
                    },
                  ),
                  10.h.verticalSpacing,

                  /// Description field
                  DescriptionTextFormField(
                    controller: controller.descriptionTextController,
                    hintText: "${"Description".tr} *",
                    maxLine: 3,
                    minLine: 2,
                  ),

                  /// Save Button
                  30.h.verticalSpacing,
                  controller.loadingController.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : PrimaryButton(
                          text: "Save".tr,
                          onTap: () {
                            if (controller.validation()) {
                              controller.addTeacherHomework();
                            }
                          },
                        ),

                  30.h.verticalSpacing,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
