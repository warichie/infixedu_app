import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/data/constants/app_colors.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/primary_button.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/text_field.dart';
import 'package:infixedu/app/utilities/widgets/custom_dropdown.dart';

import 'package:get/get.dart';

import '../controllers/admin_add_dormitory_controller.dart';

class AdminAddDormitoryView extends GetView<AdminAddDormitoryController> {
  const AdminAddDormitoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => InfixEduScaffold(
        title: "Add Dormitory".tr,
        body: CustomBackground(
          customWidget: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 15),
                  child: Column(
                    children: [
                      20.h.verticalSpacing,
                      CustomTextFormField(
                        enableBorderActive: true,
                        focusBorderActive: true,
                        hintText: "${"Dormitory Name".tr}*",
                        fillColor: Colors.white,
                        controller: controller.dormitoryNameController,
                      ),
                      10.h.verticalSpacing,
                      CustomTextFormField(
                        enableBorderActive: true,
                        focusBorderActive: true,
                        hintText: "${"Intake".tr}*",
                        fillColor: Colors.white,
                        textInputType: TextInputType.number,
                        controller: controller.dormitoryIntakeController,
                      ),
                      10.h.verticalSpacing,
                      CustomTextFormField(
                        enableBorderActive: true,
                        focusBorderActive: true,
                        hintText: "${"Address".tr}*",
                        fillColor: Colors.white,
                        controller: controller.dormitoryAddressController,
                      ),
                      10.h.verticalSpacing,
                      CustomDropdown(
                        dropdownValue: controller.dropdownValue.value,
                        dropdownList: controller.dropdownList,
                        changeDropdownValue: (v) {
                          controller.dropdownValue.value = v!;
                          controller.dormitoryType.value = v[0];
                        },
                      ),
                      10.h.verticalSpacing,
                      CustomTextFormField(
                        enableBorderActive: true,
                        focusBorderActive: true,
                        hintText: "Description".tr,
                        fillColor: Colors.white,
                        controller: controller.dormitoryDescriptionController,
                      ),
                      40.h.verticalSpacing,
                      Obx(
                        () => controller.loadingController.isLoading
                            ? const CircularProgressIndicator(
                                color: AppColors.primaryColor,
                              )
                            : PrimaryButton(
                                text: "Save".tr,
                                onTap: () {
                                  controller.dormitoryType.value =
                                      controller.dropdownValue.value[0];
                                  if (controller.validation()) {
                                    controller.addDormitory();
                                  }
                                },
                              ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
