import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/data/constants/app_colors.dart';
import 'package:infixedu/app/data/constants/app_text_style.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';

class CustomCheckbox extends StatelessWidget {
  final bool checkboxValue;
  final Function(bool?)? onChange;
  final String? checkboxTitle;
  final OutlinedBorder? shape;
  const CustomCheckbox(
      {super.key,
      this.checkboxValue = false,
      this.onChange,
      this.checkboxTitle,
      this.shape});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        16.w.horizontalSpacing,

        // Checkbox(
        //   value: checkboxValue,
        //   onChanged: onChange,
        //   shape: shape,
        //   materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        //     visualDensity: VisualDensity.comfortable
        // ),

        InkWell(
          onTap: () {
            if (onChange != null) {
              onChange!(!checkboxValue);
            }
          },
          child: Container(
            height: 16.w,
            width: 16.w,
            decoration: BoxDecoration(
                borderRadius: 16.w.circularRadius,
                color: checkboxValue ? AppColors.primaryColor : null,
                border: Border.all(color: AppColors.primaryColor)),
            child: checkboxValue
                ? Icon(Icons.check, color: Colors.white, size: 14.w)
                : null,
          ),
        ),

        15.w.horizontalSpacing,
        Text(
          checkboxTitle ?? "",
          style: AppTextStyle.fontSize13BlackW400,
        ),
      ],
    );
  }
}
