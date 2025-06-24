import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/data/constants/app_colors.dart';
import 'package:infixedu/app/data/constants/app_text.dart';
import 'package:infixedu/app/data/constants/app_text_style.dart';
import 'package:infixedu/app/data/constants/image_path.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_divider.dart';
import 'package:infixedu/app/utilities/widgets/image_view/cache_image_view.dart';
import 'package:get/get.dart';

class StudentListTile extends StatelessWidget {
  final bool isPhotoAvailable;
  final String? imageURL;
  final String? studentName;
  final String? studentClass;
  final String? studentSection;
  final String? classSection;
  final List<dynamic>? classSectionList;
  final Function()? onTap;
  final bool isMultipleSectionAvailable;
  final TextStyle? textStyle;

  const StudentListTile({
    super.key,
    this.isPhotoAvailable = false,
    this.imageURL,
    this.studentName,
    this.studentClass,
    this.studentSection,
    this.classSectionList,
    this.onTap,
    this.isMultipleSectionAvailable = false,
    this.classSection,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.all(10.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 40.w,
                  width: 40.w,
                  child: CacheImageView(
                    url: '$imageURL',
                    errorImageLocal: ImagePath.dp,
                  ),
                ),
                10.w.horizontalSpacing,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        studentName ?? AppText.noDataAvailable.tr,
                        style: textStyle ?? AppTextStyle.fontSize10GreyW500,
                      ),
                      3.h.verticalSpacing,
                      isMultipleSectionAvailable
                          ? Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    classSectionList!
                                        .map((e) => e.classSection.toString())
                                        .join(', '),
                                    style: AppTextStyle.fontSize10GreyW400,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            )
                          : Text(
                              classSection ?? '',
                              style: AppTextStyle.fontSize10GreyW400,
                            ),
                    ],
                  ),
                ),
                10.w.horizontalSpacing,
              ],
            ),
          ),
        ),
        CustomDivider(
          width: Get.width,
          color: AppColors.customDividerColor,
        ),
      ],
    );
  }
}
