import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/data/constants/app_colors.dart';
import 'package:infixedu/app/data/constants/app_text_style.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_divider.dart';
import 'package:get/get.dart';

class TransportDetailsTile extends StatelessWidget {
  final String? route;
  final String? vehicleNo;

  final Function()? onTap;

  const TransportDetailsTile({
    super.key,
    this.route,
    this.vehicleNo,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: Get.width * 0.7,
                child: Text(
                  "${"Routes".tr}: ${route ?? ""}",
                  style: AppTextStyle.fontSize13BlackW400,
                ),
              ),
              InkWell(
                onTap: onTap,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: AppColors.primaryColor,
                  ),
                  child: Text(
                    "View".tr,
                    style: AppTextStyle.textStyle12WhiteW400,
                  ),
                ),
              )
            ],
          ),
          10.h.verticalSpacing,
          SizedBox(
            width: Get.width * 0.7,
            child: Text(
              "${"Vehicle No".tr}: ${vehicleNo ?? ""}",
              style: AppTextStyle.fontSize13BlackW400,
            ),
          ),
          10.h.verticalSpacing,
          const CustomDivider(
            color: AppColors.customDividerColor,
          ),
        ],
      ),
    );
  }
}
