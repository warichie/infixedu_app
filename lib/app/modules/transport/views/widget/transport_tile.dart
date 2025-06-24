import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/data/constants/app_colors.dart';
import 'package:infixedu/app/data/constants/app_text_style.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_divider.dart';
import 'package:get/get.dart';

class TransportTile extends StatelessWidget {
  final String? vehicle;
  final String? status;
  final String? route;
  final Function()? onTap;
  final Color? tileBackgroundColor;

  const TransportTile({
    super.key,
    this.vehicle,
    this.status,
    this.route,
    this.onTap,
    this.tileBackgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
          child: Row(
            children: [
              Container(
                width: Get.width * 0.13,
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: AppColors.profileCardBackgroundColor),
                child: Center(
                  child: Text(
                    vehicle ?? "",
                    style: AppTextStyle.textStyle10WhiteW400,
                  ),
                ),
              ),
              SizedBox(
                height: Get.height * 0.05,
                child: const VerticalDivider(
                  color: AppColors.transportDividerColor,
                  thickness: 1,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(7),
                width: Get.width * 0.2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  color: const Color(0xFF45AE68),
                ),
                child: Center(
                  child: Text(
                    (status ?? "").isEmpty ? "Not assigned".tr : status!,
                    style: AppTextStyle.textStyle10WhiteW400,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(
                height: Get.height * 0.05,
                child: const VerticalDivider(
                  color: AppColors.transportDividerColor,
                  thickness: 1,
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: Get.width * 0.27,
                      child: Text(
                        route ?? "",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF635976),
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: onTap,
                      child: Container(
                        padding: const EdgeInsets.all(7),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          color: const Color(0xFF862CFF),
                        ),
                        child: Center(
                          child: Text(
                            "View".tr,
                            style: AppTextStyle.textStyle10WhiteW400,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        CustomDivider(
          width: Get.width,
          color: AppColors.transportDividerColor,
        )
      ],
    );
  }
}
