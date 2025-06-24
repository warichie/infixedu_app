import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/data/constants/app_colors.dart';
import 'package:infixedu/app/data/constants/app_text_style.dart';
import 'package:infixedu/app/data/constants/image_path.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_divider.dart';
import 'package:infixedu/app/utilities/widgets/image_view/cache_image_view.dart';
import 'package:get/get.dart';

class SetAttendanceTile extends StatelessWidget {
  final bool isImageEmpty;
  final String? imageUrl;
  final String? studentName;
  final String? studentClass;
  final String? section;
  final Function()? onPresentButtonTap;
  final Function()? onAbsentButtonTap;
  final Function()? onLateButtonTap;
  final Function()? onHalfDayButtonTap;
  final String? title;
  final String? groupValue;
  final String? value;
  final Function(String? value)? onChanged;
  final int? index;
  final String attendanceType;
  final Function()? onAddNoteTap;

  const SetAttendanceTile({
    super.key,
    this.isImageEmpty = false,
    this.imageUrl,
    this.studentName,
    this.studentClass,
    this.section,
    this.onPresentButtonTap,
    this.onAbsentButtonTap,
    this.onLateButtonTap,
    this.onHalfDayButtonTap,
    this.title,
    this.groupValue,
    this.onChanged,
    this.index,
    this.value,
    required this.attendanceType,
    this.onAddNoteTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              height: Get.width * 0.17,
              width: Get.width * 0.17,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: ClipRRect(
                child: CacheImageView(
                  url: imageUrl,
                  errorImageLocal: ImagePath.dp,
                ),
              ),
            ),
            5.h.horizontalSpacing,
            Flexible(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                            child: Text(
                          studentName ?? "",
                          style: TextStyle(
                              fontSize: 13.sp, fontWeight: FontWeight.w400),
                        )),
                        InkWell(
                          onTap: onAddNoteTap,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: AppColors.primaryColor),
                            child: Center(
                              child: Text(
                                "Add Note".tr,
                                style: AppTextStyle.textStyle12WhiteW400,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    5.h.verticalSpacing,
                    Text(
                        "${"Class".tr}: $studentClass  |  ${"Section".tr}: $section",
                        style: TextStyle(
                            fontSize: 12.sp, fontWeight: FontWeight.w400)),
                    8.h.verticalSpacing,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        /// Present
                        Flexible(
                          child: InkWell(
                            onTap: onPresentButtonTap,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                    width: 1,
                                    color: attendanceType == "P"
                                        ? Colors.transparent
                                        : AppColors.primaryColor),
                                color: attendanceType == "P"
                                    ? AppColors.appButtonColor
                                    : Colors.white,
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(5),
                                child: Center(
                                  child: Text(
                                    "Present".tr,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: attendanceType == "P"
                                        ? AppTextStyle.textStyle12WhiteW500
                                        : AppTextStyle
                                            .cardTextStyle12PurpleW400,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        4.horizontalSpacing,

                        /// Absent
                        Flexible(
                          child: InkWell(
                            onTap: onAbsentButtonTap,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                    width: 1,
                                    color: attendanceType == "A"
                                        ? Colors.transparent
                                        : AppColors.primaryColor),
                                color: attendanceType == "A"
                                    ? AppColors.appButtonColor
                                    : Colors.white,
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(5),
                                child: Center(
                                  child: Text(
                                    "Absent".tr,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: attendanceType == "A"
                                        ? AppTextStyle.textStyle12WhiteW500
                                        : AppTextStyle
                                            .cardTextStyle12PurpleW400,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        4.horizontalSpacing,

                        /// Late
                        Flexible(
                          child: InkWell(
                            onTap: onLateButtonTap,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  width: 1,
                                  color: attendanceType == "L"
                                      ? Colors.transparent
                                      : AppColors.primaryColor,
                                ),
                                color: attendanceType == "L"
                                    ? AppColors.appButtonColor
                                    : Colors.white,
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(5),
                                child: Center(
                                  child: Text(
                                    "Late".tr,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: attendanceType == "L"
                                        ? AppTextStyle.textStyle12WhiteW500
                                        : AppTextStyle
                                            .cardTextStyle12PurpleW400,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        4.horizontalSpacing,

                        /// Half Day
                        Flexible(
                          child: InkWell(
                            onTap: onHalfDayButtonTap,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                    width: 1,
                                    color: attendanceType == "F"
                                        ? Colors.transparent
                                        : AppColors.primaryColor),
                                color: attendanceType == "F"
                                    ? AppColors.appButtonColor
                                    : Colors.white,
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(5),
                                child: Center(
                                  child: Text(
                                    "Half Day".tr,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: attendanceType == "F"
                                        ? AppTextStyle.textStyle12WhiteW500
                                        : AppTextStyle
                                            .cardTextStyle12PurpleW400,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        10.verticalSpacing,
        CustomDivider(
          width: Get.width,
          color: AppColors.customDividerColor,
        )
      ],
    );
  }
}
