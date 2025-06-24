import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/primary_button.dart';

class BottomNavButton extends StatelessWidget {
  final double? height;
  final double? width;
  final double? borderRadius;
  final Color? color;
  final String text;
  final TextStyle? textStyle;
  final Function()? onTap;
  final EdgeInsets? padding;

  const BottomNavButton({
    super.key,
    this.height,
    this.width,
    this.borderRadius,
    this.color,
    required this.text,
    this.textStyle,
    this.onTap,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: Get.height * 0.13,
      margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 0),
      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10.w),
      color: Colors.white,
      child: PrimaryButton(
        text: text,
        onTap: onTap,
      ),
    );
  }
}
