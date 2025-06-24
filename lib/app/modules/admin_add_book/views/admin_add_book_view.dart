import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/data/constants/app_colors.dart';
import 'package:infixedu/app/data/constants/app_text_style.dart';
import 'package:infixedu/app/data/constants/image_path.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_background.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_scaffold_widget.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/description_text_field.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/duplicate_dropdown.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/primary_button.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/text_field.dart';
import 'package:infixedu/app/utilities/widgets/customised_loading_widget/customised_loading_widget.dart';

import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../controllers/admin_add_book_controller.dart';

class AdminAddBookView extends GetView<AdminAddBookController> {
  const AdminAddBookView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => InfixEduScaffold(
        title: "Add Book".tr,
        body: CustomBackground(
          customWidget: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0.w, vertical: 15.w),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  10.h.verticalSpacing,
                  Text(
                    "${"Add Book Category".tr}*",
                    style: AppTextStyle.fontSize13BlackW400,
                  ),
                  5.h.verticalSpacing,

                  /// Book Category dropdown List
                  controller.loadingController.isLoading
                      ? const SecondaryLoadingWidget()
                      : DuplicateDropdown(
                          dropdownValue: controller.bookCategoryInitValue.value,
                          dropdownList: controller.bookCategoryList,
                          changeDropdownValue: (value) {
                            controller.bookCategoryInitValue.value = value!;
                            controller.bookCategoryId.value = value.id;
                          },
                        ),
                  10.h.verticalSpacing,
                  Text(
                    '${"Add Subject".tr}*',
                    style: AppTextStyle.fontSize13BlackW400,
                  ),
                  5.h.verticalSpacing,

                  /// Book Subject dropdown List
                  DuplicateDropdown(
                    dropdownValue: controller.bookSubjectInitValue.value,
                    dropdownList: controller.bookSubjectList,
                    changeDropdownValue: (value) {
                      controller.bookSubjectInitValue.value = value!;
                      controller.bookSubjectId.value = value.id;
                    },
                  ),
                  10.h.verticalSpacing,

                  /// Book title Text Field
                  CustomTextFormField(
                    controller: controller.titleTextController,
                    enableBorderActive: true,
                    focusBorderActive: true,
                    hintText: '${"Title".tr}*',
                    // hintTextStyle: AppTextStyle.fontSize14lightBlackW400,
                    fillColor: Colors.white,
                  ),
                  10.h.verticalSpacing,

                  /// Book Number Text Field
                  CustomTextFormField(
                    controller: controller.bookNumberTextController,
                    enableBorderActive: true,
                    focusBorderActive: true,
                    hintText: "Book Number".tr,
                    fillColor: Colors.white,
                    textInputType: TextInputType.number,
                  ),
                  10.h.verticalSpacing,

                  /// ISBN Text Field
                  CustomTextFormField(
                    controller: controller.isbnTextController,
                    enableBorderActive: true,
                    focusBorderActive: true,
                    hintText: "ISBN".tr,
                    fillColor: Colors.white,
                  ),
                  10.h.verticalSpacing,

                  ///Publisher Name Text Field
                  CustomTextFormField(
                    controller: controller.publisherNameTextController,
                    enableBorderActive: true,
                    focusBorderActive: true,
                    hintText: "Publisher Name".tr,
                    fillColor: Colors.white,
                  ),
                  10.h.verticalSpacing,

                  /// Author Name Text Field
                  CustomTextFormField(
                    controller: controller.authorNameTextController,
                    enableBorderActive: true,
                    focusBorderActive: true,
                    hintText: "Author Name".tr,
                    fillColor: Colors.white,
                  ),
                  10.h.verticalSpacing,

                  /// Rack Number Text Field
                  CustomTextFormField(
                    controller: controller.rackNumberTextController,
                    enableBorderActive: true,
                    focusBorderActive: true,
                    hintText: "Rack Number".tr,
                    fillColor: Colors.white,
                  ),
                  10.h.verticalSpacing,

                  /// Quantity Text Field
                  CustomTextFormField(
                    controller: controller.quantityTextController,
                    enableBorderActive: true,
                    focusBorderActive: true,
                    hintText: "${"Quantity".tr}*",
                    fillColor: Colors.white,
                    textInputType: TextInputType.number,
                  ),
                  10.h.verticalSpacing,

                  /// Price Text Field
                  CustomTextFormField(
                    controller: controller.priceTextController,
                    enableBorderActive: true,
                    focusBorderActive: true,
                    hintText: '${"Price".tr}*',
                    fillColor: Colors.white,
                    textInputType: TextInputType.number,
                  ),
                  10.h.verticalSpacing,

                  /// Date Text Field
                  CustomTextFormField(
                    iconOnTap: () {
                      controller.changeApplyDate();
                    },
                    readOnly: true,
                    controller: controller.dateTextController,
                    enableBorderActive: true,
                    focusBorderActive: true,
                    hintText: "${"Select Upload Date".tr}*",
                    fillColor: Colors.white,
                    suffixIcon: Icon(
                      Iconsax.calendar5,
                      size: 16.w,
                    ),
                  ),
                  10.h.verticalSpacing,

                  /// Description Text Field
                  DescriptionTextFormField(
                    controller: controller.descriptionTextController,
                    hintText: "Description".tr,
                    minLine: 2,
                    maxLine: 3,
                  ),

                  30.h.verticalSpacing,
                  controller.addBookLoader.value
                      ? const SecondaryLoadingWidget(
                          isBottomNav: true,
                        )
                      : PrimaryButton(
                          text: "Save".tr,
                          onTap: () {
                            if (controller.validation()) {
                              controller.addAdminBook(
                                bookCategoryId: controller.bookCategoryId.value,
                                bookSubjectId: controller.bookSubjectId.value,
                              );
                            }
                          },
                        ),

                  20.h.verticalSpacing,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
