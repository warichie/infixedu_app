import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/data/constants/app_colors.dart';
import 'package:infixedu/app/data/constants/app_text_style.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class EditProfileTextField extends StatelessWidget {
  final TextEditingController? controller;
  final Color? fillColor;
  final String? hintText;
  final bool focusBorderActive;
  final bool enableBorderActive;
  final bool obsCureText;
  final Widget? suffixIcon;
  final Widget? suffixIconDisable;
  final Function()? iconOnTap;
  final TextInputType? textInputType;
  final String? labelText;
  final TextStyle? labelTextStyle;
  final Color? enableBorderActiveColor;
  final int? maxLine;
  final bool readOnly;
  final double? height;

  const EditProfileTextField({
    this.controller,
    this.fillColor,
    this.hintText,
    this.focusBorderActive = true,
    this.enableBorderActive = true,
    this.suffixIcon,
    this.iconOnTap,
    this.obsCureText = false,
    this.textInputType,
    this.labelText,
    this.labelTextStyle,
    this.enableBorderActiveColor,
    this.maxLine,
    this.suffixIconDisable,
    this.readOnly = false,
    this.height,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height?.h ?? 36.h,
      child: TextFormField(
        style: TextStyle(
            color: AppColors.teacherTextColor,
            fontSize: 12.sp,
            fontWeight: FontWeight.w400),
        controller: controller,
        obscureText: obsCureText,
        keyboardType: textInputType,
        minLines: 1,
        maxLines: maxLine ?? 1,
        readOnly: readOnly,
        decoration: InputDecoration(
          filled: true,
          labelText: labelText ?? "label".tr,
          labelStyle: labelTextStyle ?? AppTextStyle.labelText,
          fillColor: fillColor ?? Colors.white,
          hintText: hintText ?? 'Enter text'.tr,
          suffixIcon: suffixIcon ??
              InkWell(
                onTap: iconOnTap,
                child: Icon(
                  Iconsax.edit_2,
                  size: 20.h,
                ),
              ),
          focusedBorder: focusBorderActive
              ? OutlineInputBorder(
                  borderSide: BorderSide(
                      color: const Color(0xFF635976).withOpacity(0.2)),
                  borderRadius: BorderRadius.circular(8.0),
                )
              : null,
          enabledBorder: enableBorderActive
              ? OutlineInputBorder(
                  borderSide: BorderSide(
                      color: enableBorderActiveColor ??
                          const Color(0xFF635976).withOpacity(0.2)),
                  borderRadius: BorderRadius.circular(8.0),
                )
              : null,
          contentPadding: const EdgeInsets.fromLTRB(16, 2, 0, 16),
        ),
      ),
    );
  }
}
