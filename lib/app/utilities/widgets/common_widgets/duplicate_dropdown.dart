import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/data/constants/app_text_style.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:get/get.dart';

class DuplicateDropdown extends StatelessWidget {
  final dynamic dropdownValue;
  final List<dynamic>? dropdownList;
  final Function(dynamic v)? changeDropdownValue;
  final Color? color;
  final Color dropdownColor;
  final Color? activeStatusColor;
  final bool dropdownText;
  final String? hint;
  final TextStyle? textStyle;
  final bool isChat;
  final EdgeInsets? padding;
  final double? sidePadding;
  final double? borderRadius;
  final double? height;

  const DuplicateDropdown({
    super.key,
    this.dropdownValue,
    this.dropdownList,
    this.changeDropdownValue,
    this.color,
    this.dropdownColor = Colors.white,
    this.dropdownText = true,
    this.activeStatusColor,
    this.hint,
    this.textStyle,
    this.isChat = false,
    this.padding,
    this.borderRadius,
    this.sidePadding,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height?.h ?? 36.h,
      padding: EdgeInsets.symmetric(horizontal: sidePadding?.w ?? 10.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius?.w ?? 8.w),
        border: Border.all(
          color: const Color(0xFF635976).withOpacity(0.2),
        ),
      ),
      child: Padding(
        padding: padding ?? EdgeInsets.all(5.0.w),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<dynamic>(
            iconSize: 26.h,
            // itemHeight: 40.h,
            hint: Text(
              hint ?? "",
              style: AppTextStyle.hintTextStyle,
            ),
            menuMaxHeight: (Get.height * 0.4).w,
            isExpanded: true,
            items: dropdownList!
                .map(
                  (dynamic item) => DropdownMenuItem<dynamic>(
                    value: item,
                    child: dropdownText
                        ? Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.w),
                            child: Text(
                              "${item.name ?? "Unknown"}".tr,
                              style: textStyle ?? AppTextStyle.dropdownText,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        : Row(
                            children: [
                              Container(
                                height: 8.w,
                                width: 8.w,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(item.statusColor)),
                              ),
                              10.w.horizontalSpacing,
                              Text(
                                "${item.name ?? "Unknown"}".tr,
                                style: AppTextStyle.cardTextStyle14WhiteW500,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                  ),
                )
                .toList(),
            value: dropdownValue,
            dropdownColor: dropdownColor,
            iconEnabledColor: color ?? const Color(0xFF6B7280),
            onChanged: changeDropdownValue,
          ),
        ),
      ),
    );
  }
}
