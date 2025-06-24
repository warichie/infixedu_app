import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SearchField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String searchKey)? onChange;
  final Function()? onTap;
  final bool isTextFieldEmpty;
  final Widget? icon;
  final TextStyle? hintTextStyle;
  final double? borderRadius;
  final Color? fillColor;

  const SearchField({
    super.key,
    required this.controller,
    this.onChange,
    this.isTextFieldEmpty = false,
    this.onTap,
    this.icon,
    this.hintTextStyle, this.borderRadius, this.fillColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
   //   height: 36.h,
      child: TextField(
        style: TextStyle(fontSize: 13.sp,fontWeight: FontWeight.w300),
        decoration: InputDecoration(
            hintText: "Search".tr,
            hintStyle: hintTextStyle,
            suffixIcon: icon,
            filled: true,

            fillColor: fillColor ?? const Color(0xFFF2F0F6),
            focusedBorder: OutlineInputBorder(
              borderSide:
              BorderSide(color: const Color(0xFF635976).withOpacity(0.2)),
              borderRadius: BorderRadius.circular(borderRadius ?? 2.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide:
              BorderSide(color: const Color(0xFF635976).withOpacity(0.2)),
              borderRadius: BorderRadius.circular(borderRadius ?? 2.0),
            ),
            contentPadding:  EdgeInsets.symmetric(horizontal: 12.w)),
        controller: controller,
        onChanged: onChange,
        onSubmitted: _onSearchFieldChanged,
      ),
    );
  }

  _onSearchFieldChanged(String value) async {
    value = controller.text;
    debugPrint(controller.text);
  }
}
