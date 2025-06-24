import 'package:flutter/material.dart';
import 'package:infixedu/app/data/constants/app_colors.dart';
import 'package:infixedu/app/data/constants/app_text.dart';
import 'package:infixedu/app/data/constants/app_text_style.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_divider.dart';
import 'package:get/get.dart';

class IndividualDetailsTile extends StatelessWidget {
  final String? currentAddress;
  final String? permanentAddress;
  final String? phone;
  final String? title;
  final String? qualification;
  final String? maritalStatus;
  final String? joiningDate;

  const IndividualDetailsTile({
    super.key,
    this.currentAddress,
    this.permanentAddress,
    this.phone,
    this.title,
    this.qualification,
    this.maritalStatus,
    this.joiningDate,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: Get.width,
          color: Colors.white,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            color: const Color(0xFFF5F5F5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${"Current Address".tr}: ${currentAddress ?? AppText.noDataAvailable.tr}",
                  style: AppTextStyle.fontSize13BlackW400,
                ),
                Text(
                  "${"Permanent Address".tr}: ${permanentAddress ?? AppText.noDataAvailable.tr}",
                  style: AppTextStyle.fontSize13BlackW400,
                ),
                10.verticalSpacing,
                Text(
                  "${"Phone".tr}: ${phone ?? AppText.noDataAvailable.tr}",
                  style: AppTextStyle.fontSize13BlackW400,
                ),
              ],
            ),
          ),
        ),
        // CustomDivider(color: AppColors.profileDividerColor, width: Get.width,),
        // 10.verticalSpacing,
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 15.0),
        //   child: Text(
        //     "Title: ${title ?? AppText.noDataAvailable}",
        //     style: AppTextStyle.fontSize13BlackW400,
        //   ),
        // ),
        // 10.verticalSpacing,
        // CustomDivider(color: AppColors.profileDividerColor, width: Get.width,),
        // 10.verticalSpacing,
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 15.0),
        //   child: Text(
        //     "Qualification: ${qualification ?? AppText.noDataAvailable}",
        //     style: AppTextStyle.fontSize13BlackW400,
        //   ),
        // ),
        10.verticalSpacing,
        CustomDivider(
          color: AppColors.profileDividerColor,
          width: Get.width,
        ),
        10.verticalSpacing,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Text(
            "${"Marital Status".tr}: ${maritalStatus?.toUpperCase() ?? AppText.noDataAvailable.tr}",
            style: AppTextStyle.fontSize13BlackW400,
          ),
        ),
        10.verticalSpacing,
        CustomDivider(
          color: AppColors.profileDividerColor,
          width: Get.width,
        ),
        10.verticalSpacing,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Text(
            "${"Joining Date".tr}: ${joiningDate ?? AppText.noDataAvailable.tr}",
            style: AppTextStyle.fontSize13BlackW400,
          ),
        ),
        10.verticalSpacing,
        CustomDivider(
          color: AppColors.profileDividerColor,
          width: Get.width,
        ),
      ],
    );
  }
}
