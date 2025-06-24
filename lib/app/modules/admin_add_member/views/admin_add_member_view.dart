import 'package:flutter/material.dart';
import 'package:infixedu/app/data/constants/app_colors.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/duplicate_dropdown.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/primary_button.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/text_field.dart';
import 'package:infixedu/app/utilities/widgets/customised_loading_widget/customised_loading_widget.dart';

import 'package:get/get.dart';

import '../controllers/admin_add_member_controller.dart';

class AdminAddMemberView extends GetView<AdminAddMemberController> {
  const AdminAddMemberView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => InfixEduScaffold(
        title: "Add Member".tr,
        body: CustomBackground(
          customWidget: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 15,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CustomTextFormField(
                    controller: controller.uniqueIdTextController,
                    enableBorderActive: true,
                    focusBorderActive: true,
                    hintText: "${"Enter ID".tr}*",
                    fillColor: Colors.white,
                  ),
                  10.verticalSpacing,

                  /// Role dropdown
                  controller.rolesLoader.value
                      ? const CircularProgressIndicator(
                          color: AppColors.primaryColor,
                        )
                      : DuplicateDropdown(
                          dropdownValue: controller.rolesDropdownValue.value,
                          dropdownList: controller.rolesList,
                          changeDropdownValue: (value) {
                            controller.rolesDropdownValue.value = value!;
                            controller.rolesId.value = value.id;
                            if (!(value.id == 2 || value.id == 3)) {
                              controller.getUserNameList(
                                  roleId: controller.rolesId.value);
                            }

                            if (value.id == 2 || value.id == 3) {
                              controller.getClassList(
                                  roleId: controller.rolesId.value);
                            }
                          },
                        ),

                  /// Student or Parents class
                  controller.rolesId.value == 2 || controller.rolesId.value == 3
                      ? Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: controller.classLoader.value
                              ? const CircularProgressIndicator(
                                  color: AppColors.primaryColor,
                                )
                              : DuplicateDropdown(
                                  dropdownValue:
                                      controller.classDropdownValue.value,
                                  dropdownList: controller.classList,
                                  changeDropdownValue: (value) async {
                                    controller.classDropdownValue.value =
                                        value!;
                                    controller.classId.value = value.id;

                                    await controller.getSectionList(
                                        classId: controller.classId.value);
                                  },
                                ),
                        )
                      : const SizedBox(),

                  /// Student or Parents section
                  controller.rolesId.value == 2 || controller.rolesId.value == 3
                      ? controller.sectionLoader.value
                          ? const CircularProgressIndicator(
                              color: AppColors.primaryColor,
                            )
                          : Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: DuplicateDropdown(
                                dropdownValue:
                                    controller.sectionDropdownValue.value,
                                dropdownList: controller.sectionList,
                                changeDropdownValue: (value) {
                                  controller.sectionDropdownValue.value =
                                      value!;
                                  controller.sectionId.value = value.id;

                                  if (controller.rolesId.value == 2) {
                                    controller.getStudentList(
                                        classId: controller.classId.value,
                                        sectionId: controller.sectionId.value);
                                  } else if (controller.rolesId.value == 3) {
                                    controller.getParentsList(
                                        classId: controller.classId.value,
                                        sectionId: controller.sectionId.value);
                                  }
                                },
                              ),
                            )
                      : const SizedBox(),
                  controller.rolesId.value == 2 || controller.rolesId.value == 3
                      ? 0.verticalSpacing
                      : 10.verticalSpacing,

                  /// Member Name
                  controller.rolesId.value == 2 || controller.rolesId.value == 3
                      ? const SizedBox()
                      : controller.userNameLoader.value
                          ? const CircularProgressIndicator(
                              color: AppColors.primaryColor,
                            )
                          : DuplicateDropdown(
                              dropdownValue:
                                  controller.userNameDropdownValue.value,
                              dropdownList: controller.userNameList,
                              changeDropdownValue: (value) {
                                controller.userNameDropdownValue.value = value!;
                                controller.nameId.value = value.id;
                                controller.userId.value = value.userId;
                              },
                            ),

                  /// Student dropdown
                  controller.rolesId.value == 2
                      ? controller.studentLoader.value
                          ? const CircularProgressIndicator(
                              color: AppColors.primaryColor,
                            )
                          : DuplicateDropdown(
                              dropdownValue:
                                  controller.studentDropdownValue.value,
                              dropdownList: controller.studentList,
                              changeDropdownValue: (value) {
                                controller.studentDropdownValue.value = value!;
                                controller.studentId.value = value.id;
                                controller.userId.value = value.userId;
                              },
                            )
                      : const SizedBox(),
                  controller.rolesId.value == 3
                      ? controller.parentLoader.value
                          ? const CircularProgressIndicator(
                              color: AppColors.primaryColor,
                            )
                          : DuplicateDropdown(
                              dropdownValue:
                                  controller.parentsDropdownValue.value,
                              dropdownList: controller.parentsList,
                              changeDropdownValue: (value) {
                                controller.parentsDropdownValue.value = value!;
                                controller.parentsId.value = value.id;
                                controller.userId.value = value.userId;
                              },
                            )
                      : const SizedBox(),
                  (controller.rolesId.value == 2 ||
                              controller.rolesId.value == 3
                          ? Get.height * 0.3
                          : Get.height * 0.48)
                      .verticalSpacing,
                  controller.loadingController.isLoading
                      ? const SecondaryLoadingWidget(
                          isBottomNav: true,
                        )
                      : PrimaryButton(
                          text: "Save".tr,
                          onTap: () {
                            if (controller.validation()) {
                              controller.adminAddMember();
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
