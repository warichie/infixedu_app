import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/data/constants/app_text_style.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:get/get.dart';
import '../../../data/constants/app_colors.dart';
import '../common_widgets/custom_divider.dart';

class BookListTile extends StatelessWidget {
  final String? bookName;
  final String? subject;
  final String? bookNumber;
  final String? view;
  final Color? color;
  final Function()? onTap;

  const BookListTile({
    super.key,
    this.bookName,
    this.subject,
    this.bookNumber,
    this.color,
    this.onTap,
    this.view,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: SizedBox(
            child: Row(
              children: [
                Container(
                  width: Get.width * 0.12,
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: AppColors.profileCardBackgroundColor),
                  child: Center(
                    child: Text(
                      bookNumber ?? "_",
                      style: AppTextStyle.textStyle10WhiteW400,
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.04,
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
                      color: const Color(0xFF45AE68)),
                  child: Center(
                    child: Text(
                      subject ?? "",
                      textAlign: TextAlign.center,
                      style: AppTextStyle.textStyle10WhiteW400,
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.04,
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
                        width: Get.width * 0.25,
                        child: Text(
                          bookName ?? "",
                          style: TextStyle(
                            color: Color(0xFF635976),
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      5.horizontalSpacing,
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
                              view ?? "View".tr,
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
        ),
        CustomDivider(
          width: Get.width,
          color: AppColors.transportDividerColor,
        )
      ],
    );
  }
}
