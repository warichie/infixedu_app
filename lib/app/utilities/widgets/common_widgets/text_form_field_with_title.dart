import 'package:flutter/material.dart';
import 'package:infixedu/app/data/constants/app_text_style.dart';

import '../../../data/constants/app_colors.dart';
import '../../../data/constants/app_dimens.dart';
import '../../extensions/widget.extensions.dart';

// ignore: must_be_immutable
class TextFormFieldWithTitle extends StatelessWidget {
  final String? title;
  final String? hintText;
  final TextEditingController? controller;
  String? initialValue;
  FocusNode? focusNode;
  FocusNode? nextNode;
  TextInputType? keyboardType;
  TextStyle? style;
  TextAlign textAlign;
  bool autofocus = false;
  AutovalidateMode? autovalidateMode;
  bool readOnly = false;
  bool obscureText = false;
  ValueChanged<String>? onChanged;
  final Function()? onTap;
  VoidCallback? onEditingComplete;
  ValueChanged<String>? onFieldSubmitted;
  FormFieldSetter<String>? onSaved;
  FormFieldValidator<String>? validator;
  Color? cursorColor;
  TextCapitalization textCapitalization;
  final bool required;
  final bool isOptional;
  final bool clickable;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Color? backgroundColor;
  final Widget? prefix;

  TextFormFieldWithTitle({
    super.key,
    this.title,
    this.hintText,
    this.controller,
    this.autovalidateMode,
    this.focusNode,
    this.nextNode,
    this.initialValue,
    this.keyboardType,
    this.style,
    this.textAlign = TextAlign.start,
    this.autofocus = false,
    this.readOnly = false,
    this.obscureText = false,
    this.onChanged,
    this.onTap,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.onSaved,
    this.validator,
    this.cursorColor,
    this.textCapitalization = TextCapitalization.none,
    this.required = false,
    this.isOptional = false,
    this.clickable = false,
    this.suffixIcon,
    this.prefixIcon,
    this.backgroundColor,
    this.prefix,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: clickable ? onTap : null,
          child: Container(
            height: 21.5,
            decoration: BoxDecoration(
                borderRadius: AppDimens.padding4.circularRadius,
                color: backgroundColor ?? Colors.white,
                border:
                    Border.all(color: AppColors.appColorB5C1CB, width: 0.5)),
            alignment: Alignment.centerLeft,
            child: IgnorePointer(
              ignoring: clickable,
              child: Row(
                children: [
                  prefixIcon ?? 0.horizontalSpacing,
                  Expanded(
                    child: TextFormField(
                      controller: controller,
                      textAlign: textAlign,
                      focusNode: focusNode,
                      initialValue: initialValue,
                      keyboardType: keyboardType,
                      style: style ??
                          AppTextStyle.inter(
                            color: AppColors.appColor324844,
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                      autofocus: autofocus,
                      readOnly: readOnly,
                      obscureText: obscureText,
                      onChanged: onChanged,
                      onEditingComplete: onEditingComplete,
                      textCapitalization: textCapitalization,
                      onTap: clickable ? null : onTap,
                      onFieldSubmitted: (v) {
                        focusNode?.unfocus();
                        nextNode?.requestFocus();
                        onFieldSubmitted?.call(v);
                      },
                      onSaved: onSaved,
                      validator: validator,
                      // enabled: !clickable,
                      cursorColor: cursorColor,
                      autovalidateMode: autovalidateMode,
                      decoration: InputDecoration(
                        prefix: prefix,
                        hintText: hintText,

                        contentPadding: const EdgeInsets.fromLTRB(14, 2, 0, 14),
                        hintStyle: AppTextStyle.inter(
                          color: AppColors.hintTextColor,
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                        ),

                        enabledBorder: InputBorder.none,
                        border: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        // suffixIcon: suffixIcon,
                      ),
                    ),
                  ),
                  suffixIcon ?? AppDimens.padding14.horizontalSpacing,
                  if (suffixIcon != null) AppDimens.padding14.horizontalSpacing,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
