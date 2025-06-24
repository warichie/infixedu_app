import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/data/constants/app_text_style.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:get/get.dart';

class CustomDropdown extends StatelessWidget {
  final String? dropdownValue;
  final String? hint;
  final List<String>? dropdownList;
  final Function(String? v)? changeDropdownValue;
  final Color? color;
  final Color dropdownColor;
  final Color? activeStatusColor;
  final bool dropdownText;

  const CustomDropdown({
    super.key,
    this.dropdownValue,
    this.dropdownList,
    this.changeDropdownValue,
    this.color,
    this.dropdownColor = Colors.white,
    this.dropdownText = true,
    this.activeStatusColor,
    this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFF635976).withOpacity(0.2),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0.w),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            //  itemHeight: 40.h,
            isExpanded: true,
            hint: Text(hint ?? ""),
            items: dropdownList!
                .map(
                  (String item) => DropdownMenuItem<String>(
                    value: item,
                    child: dropdownText
                        ? Text(
                            "${item ?? "Unknown"}".tr,
                            style: AppTextStyle.dropdownText,
                            overflow: TextOverflow.ellipsis,
                          )
                        : Row(
                            children: [
                              Container(
                                height: 8.w,
                                width: 8.w,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: activeStatusColor),
                              ),
                              10.horizontalSpacing,
                              Text(
                                "${item ?? "Unknown"}".tr,
                                style: AppTextStyle.cardTextStyle14WhiteW500,
                              ),
                            ],
                          ),
                  ),
                )
                .toList(),
            value: dropdownValue,
            iconSize: 26.h,
            dropdownColor: dropdownColor,
            iconEnabledColor: color ?? const Color(0xFF6B7280),
            onChanged: changeDropdownValue,
          ),
        ),
      ),
    );
  }
}
