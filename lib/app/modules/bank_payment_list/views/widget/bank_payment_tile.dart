import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/data/constants/app_colors.dart';
import 'package:infixedu/app/data/constants/app_text_style.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:get/get.dart';

class BankPaymentTile extends StatelessWidget {
  final Color? color;
  final Function()? onTapDetails;
  final Function()? onTapApprove;
  final Function()? onTapReject;
  final String? studentName;
  final String? date;
  final String? amount;
  final String? currency;
  final String? status;
  final bool isApproved;
  final bool isRejected;
  final String? isPending;
  final Color? statusColor;

  const BankPaymentTile({
    super.key,
    this.color,
    this.onTapDetails,
    this.studentName,
    this.date,
    this.amount,
    this.status,
    this.statusColor,
    this.onTapApprove,
    this.onTapReject,
    this.currency,
    this.isPending,
    this.isApproved = false,
    this.isRejected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(3.0),
      ),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(3), color: color),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            status != null
                ? Container(
                    width: Get.width * 0.2,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: statusColor),
                    child: Center(
                      child: Text(
                        ((status ?? "").capitalizeFirst ?? '').tr,
                        style: AppTextStyle.textStyle10WhiteW400,
                      ),
                    ),
                  )
                : const SizedBox(),
            5.verticalSpacing,
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                  child: Text(
                    studentName ?? "",
                    style: AppTextStyle.fontSize14BlackW500,
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap: onTapDetails,
                  child: Container(
                    width: Get.width * 0.2,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: AppColors.primaryColor),
                    child: Center(
                      child: Text(
                        "Details".tr,
                        style: AppTextStyle.textStyle10WhiteW400,
                      ),
                    ),
                  ),
                ),
                10.horizontalSpacing,
                InkWell(
                  onTap: onTapReject,
                  child: Container(
                    width: Get.width * 0.09,
                    height: Get.height * 0.04,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isRejected
                          ? AppColors.disabledColor
                          : AppColors.bankPaymentStatusRedColor,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: Get.width * 0.065,
                          height: Get.height * 0.03,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isRejected
                                ? AppColors.disabledColor
                                : AppColors.bankPaymentStatusRedColor,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.close,
                              color: Colors.white,
                              size: Get.width * 0.045,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                5.horizontalSpacing,
                InkWell(
                  onTap: onTapApprove,
                  child: Container(
                    width: Get.width * 0.09,
                    height: Get.height * 0.04,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isApproved
                          ? AppColors.disabledColor
                          : AppColors.bankPaymentStatusGreenColor,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: Get.width * 0.065,
                          height: Get.height * 0.03,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isApproved
                                ? AppColors.disabledColor
                                : AppColors.bankPaymentStatusGreenColor,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.done,
                              color: Colors.white,
                              size: Get.width * 0.045,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Text(
              "$currency$amount",
              style: TextStyle(
                  color: Color(0xFF3E4347),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400),
            )
          ],
        ),
      ),
    );
  }
}
