import 'package:flutter/material.dart';
import 'package:infixedu/app/data/constants/app_text_style.dart';

class CustomRadioButton extends StatelessWidget {
  final String? groupValue;
  final String value;
  final String? title;
  final Function(String?)? onChanged;
  final Color? activeColor;

  const CustomRadioButton({
    super.key,
    this.groupValue,
    this.onChanged,
    this.activeColor,
    required this.value,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title ?? "",
        style: AppTextStyle.fontSize13BlackW400,
      ),
      leading: Radio(
        value: value,
        groupValue: groupValue,
        onChanged: onChanged,
        activeColor: activeColor,
      ),
    );
  }
}
