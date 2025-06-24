import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/data/constants/app_colors.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/duplicate_dropdown.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/text_field.dart';

import 'package:get/get.dart';

import '../../../utilities/widgets/common_widgets/primary_button.dart';
import '../controllers/admin_add_room_controller.dart';

class AdminAddRoomView extends GetView<AdminAddRoomController> {
  const AdminAddRoomView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => InfixEduScaffold(
        title: "Add Room".tr,
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
                        hintText: "${"Room Name".tr}*",
                        fillColor: Colors.white,
                        controller: controller.roomNameTextController,
                      ),
                      10.h.verticalSpacing,
                      CustomTextFormField(
                        textInputType: TextInputType.number,
                        enableBorderActive: true,
                        focusBorderActive: true,
                        hintText: "${"Number of Bed".tr}*",
                        fillColor: Colors.white,
                        controller: controller.numberOfBedTextController,
                      ),
                      10.h.verticalSpacing,
                      CustomTextFormField(
                        textInputType: TextInputType.number,
                        enableBorderActive: true,
                        focusBorderActive: true,
                        hintText: "${"Cost Per Bed".tr}*",
                        fillColor: Colors.white,
                        controller: controller.costPerBedTextController,
                      ),
                      10.h.verticalSpacing,
                      controller.loadingController.isLoading
                          ? const CircularProgressIndicator()
                          : DuplicateDropdown(
                              dropdownValue: controller.dormitoryValue.value,
                              dropdownList: controller.dormitoryList,
                              changeDropdownValue: (v) {
                                controller.dormitoryValue.value = v;
                                controller.dormitoryId.value = v.id;
                              },
                            ),
                      10.h.verticalSpacing,
                      controller.isLoading.value
                          ? const CircularProgressIndicator()
                          : DuplicateDropdown(
                              dropdownValue: controller.roomTypeValue.value,
                              dropdownList: controller.roomTypeList,
                              changeDropdownValue: (v) {
                                controller.roomTypeValue.value = v;
                                controller.roomTypeId.value = v.id;
                              },
                            ),
                      10.h.verticalSpacing,
                      CustomTextFormField(
                        enableBorderActive: true,
                        focusBorderActive: true,
                        hintText: "Description".tr,
                        fillColor: Colors.white,
                        controller: controller.descriptionTextController,
                      ),
                      40.h.verticalSpacing,
                      controller.saveLoader.value
                          ? const CircularProgressIndicator(
                              color: AppColors.primaryColor,
                            )
                          : PrimaryButton(
                              text: "Save".tr,
                              onTap: () {
                                if (controller.validation()) {
                                  controller.addDormitoryRoom();
                                }
                              },
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
