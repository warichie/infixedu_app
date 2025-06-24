import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/data/constants/app_text_style.dart';
import 'package:get/get.dart';

class DescriptionTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final TextInputType? textInputType;
  final int? maxLine;
  final int? minLine;

  const DescriptionTextFormField({
    this.controller,
    this.hintText,
    this.textInputType,
    this.maxLine,
    this.minLine,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: maxLine ?? 1,
      minLines: minLine ?? 1,
      style: AppTextStyle.hintTextStyle,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: const Color(0xFF635976).withOpacity(0.2),
          ),
          borderRadius: BorderRadius.circular(8), // Add border radius
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: const Color(0xFF635976).withOpacity(0.2),
          ),
          borderRadius: BorderRadius.circular(8), // Add border radius
        ),
        hintText: hintText ?? 'Enter text'.tr,
        hintStyle: AppTextStyle.hintTextStyle,
        //contentPadding: EdgeInsets.zero
      ),
    );
  }
}
