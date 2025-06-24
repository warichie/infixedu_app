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

class StaffTile extends StatelessWidget {
  final String? staffName;
  final String? staffPhoneNo;
  final String? staffAddress;
  final String? staffImage;
  final Function()? onTap;
  final bool isImageEmpty;
  final String? imageUrl;

  const StaffTile({
    super.key,
    this.staffName,
    this.staffPhoneNo,
    this.staffAddress,
    this.onTap,
    this.staffImage,
    this.isImageEmpty = false,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  height: 40.w,
                  width: 40.w,
                  child: CacheImageView(
                    // height: 40.w,
                    // width: 40.w,
                    url: imageUrl,
                    //fit: BoxFit.contain,
                    errorImageLocal: ImagePath.dp,
                  ),
                ),
                20.w.horizontalSpacing,
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${"Name".tr} :  ${staffName ?? AppText.noDataAvailable}",
                      style: AppTextStyle.blackFontSize12W400,
                    ),
                    Text(
                        "${"Address".tr} : ${staffAddress ?? AppText.noDataAvailable}",
                        style: AppTextStyle.blackFontSize12W400),
                    Text(
                        "${"Phone".tr} : ${staffPhoneNo ?? AppText.noDataAvailable}",
                        style: AppTextStyle.blackFontSize12W400),
                  ],
                )
              ],
            ),
            CustomDivider(
              width: Get.width,
              color: AppColors.transportDividerColor,
            ),
          ],
        ),
      ),
    );
  }
}
