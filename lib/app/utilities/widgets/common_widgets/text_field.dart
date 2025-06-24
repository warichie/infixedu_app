import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/data/constants/app_text_style.dart';
import 'package:get/get.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final Color? fillColor;
  final String? hintText;
  final bool focusBorderActive;
  final bool enableBorderActive;
  final bool obsCureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Function()? iconOnTap;
  final TextInputType? textInputType;
  final TextStyle? labelTextStyle;
  final Color? enableBorderActiveColor;
  final int? maxLine;
  final int? minLine;
  final Function()? onTap;
  final bool readOnly;
  final EdgeInsets? contentPadding;
  final TextStyle? hintTextStyle;
  final TextStyle? textStyle;
  final InputBorder? inputBorder;
  final double? height;
  final double? borderRadius;
  final List<TextInputFormatter>? inputFormatter;

  const CustomTextFormField({
    this.controller,
    this.fillColor,
    this.hintText,
    this.focusBorderActive = false,
    this.enableBorderActive = false,
    this.suffixIcon,
    this.iconOnTap,
    this.obsCureText = false,
    this.textInputType,
    this.labelTextStyle,
    this.enableBorderActiveColor,
    this.maxLine,
    this.minLine,
    this.onTap,
    this.readOnly = false,
    super.key,
    this.contentPadding,
    this.hintTextStyle,
    this.inputBorder,
    this.prefixIcon,
    this.textStyle,
    this.height,
    this.inputFormatter,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    TextDirection textDirection = Directionality.of(context);

    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: height?.h ?? 36.h,
        child: TextFormField(
          style: textStyle ?? AppTextStyle.customTextFieldTextStyle,
          controller: controller,
          obscureText: obsCureText,
          keyboardType: textInputType,
          minLines: minLine ?? 1,
          maxLines: maxLine ?? 1,
          inputFormatters: inputFormatter,
          readOnly: readOnly,
          decoration: InputDecoration(
              filled: true,
              border: inputBorder,
              fillColor: fillColor ?? const Color(0xFFFDFBFF),
              hintText: hintText ?? 'Enter text'.tr,
              hintStyle: hintTextStyle ?? AppTextStyle.hintTextStyle,
              prefix: prefixIcon,
              suffixIcon: suffixIcon != null
                  ? Padding(
                      padding: EdgeInsets.only(right: 16.w),
                      child: InkWell(onTap: iconOnTap, child: suffixIcon),
                    )
                  : null,
              focusedBorder: focusBorderActive
                  ? OutlineInputBorder(
                      borderSide: BorderSide(
                        color: const Color(0xFF635976).withOpacity(0.2),
                      ),
                      borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
                    )
                  : null,
              enabledBorder: enableBorderActive
                  ? OutlineInputBorder(
                      borderSide: BorderSide(
                        color: enableBorderActiveColor ??
                            const Color(0xFF635976).withOpacity(0.2),
                      ),
                      borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
                    )
                  : null,
              contentPadding:
                  contentPadding ?? EdgeInsets.fromLTRB(16.w, 2.h, 10.w, 16.h)),
        ),
      ),
    );
  }
}
