import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/data/constants/app_colors.dart';
import 'package:infixedu/app/data/constants/app_text_style.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:get/get.dart';

class CustomTextFieldWithTile extends StatelessWidget {
  final String? title;
  final String? value;
  final String? hintTex;
  final Color? color;
  final TextEditingController controller;
  final bool readOnly;
  final TextInputType? keyboardType;

  const CustomTextFieldWithTile({
    super.key,
    this.title,
    this.value,
    this.color,
    required this.controller,
    this.hintTex,
    this.readOnly = false,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: Get.height * 0.04,
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.homeworkWidgetColor,
        ),
        color: color,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            width: 141.w,
            child: Text(
              title ?? "",
              style: AppTextStyle.fontSize10GreyW500,
            ),
          ),
          VerticalDivider(
            color: AppColors.bottomSheetDividerColor,
            thickness: 1,
          ),
          // Text('data'),
          Flexible(
            child: Container(
              margin: EdgeInsets.only(right: 12.w),
              //  height: 22.h,
              decoration: BoxDecoration(
                  borderRadius: 0.5.circularRadius,
                  color: Colors.white,
                  border:
                      Border.all(color: AppColors.appColorB5C1CB, width: 0.5)),
              child: TextField(
                controller: controller,
                keyboardType: keyboardType,
                readOnly: readOnly,
                style: TextStyle(
                  color: AppColors.textColor635976,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w400,
                ),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.fromLTRB(10, -6, 10, 14),
                  hintText: hintTex ?? "${"Input".tr}...",
                  enabledBorder: InputBorder.none,
                  border: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
