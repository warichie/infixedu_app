import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/data/constants/app_text_style.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:infixedu/app/utilities/widgets/custom_checkbox/custom_checkbox.dart';
import 'package:get/get.dart';

import '../../../../data/constants/app_colors.dart';

class SuggestedSearchTile extends StatelessWidget {
  final String? profileImage;
  final String? name;
  final Function()? onTap;
  final Function()? onTapSend;
  final bool checkboxValue;
  final Function(bool?)? onCheckboxTap;
  final bool isForward;
  final bool isSearch;

  const SuggestedSearchTile({
    super.key,
    this.profileImage,
    this.name,
    this.onTap,
    this.checkboxValue = false,
    this.onCheckboxTap,
    this.isForward = false,
    this.onTapSend,
    this.isSearch = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0.h),
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.center,
              children: <Widget>[
                Container(
                  height: 50.w,
                  width: 50.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: AssetImage(profileImage ?? ""),
                        fit: BoxFit.cover),
                  ),
                ),
                Positioned(
                  right: 0.w,
                  top: 10.h,
                  child: Container(
                    height: 8.w,
                    width: 8.w,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.activeStatusGreenColor),
                  ), //Icon
                ),
              ], //<Widget>[]
            ),
            20.h.horizontalSpacing,
            Expanded(
              child: Text(
                name ?? "",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyle.fontSize13BlackW400,
              ),
            ),
            const Spacer(),
            isForward
                ? InkWell(
                    onTap: onTapSend,
                    child: Container(
                      padding: EdgeInsets.all(5.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: AppColors.primaryColor,
                      ),
                      child: Text(
                        "Forward".tr,
                        style: AppTextStyle.textStyle12WhiteW400,
                      ),
                    ),
                  )
                : isSearch
                    ? const SizedBox()
                    : CustomCheckbox(
                        checkboxValue: checkboxValue,
                        onChange: onCheckboxTap,
                      )
          ],
        ),
      ),
    );
  }
}
