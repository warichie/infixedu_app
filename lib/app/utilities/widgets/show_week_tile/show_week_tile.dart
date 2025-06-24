import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShowWeekTile extends StatelessWidget {
  final String title;
  final Color? color;
  final TextStyle? textStyle;

  const ShowWeekTile({
    super.key,
    required this.title,
    this.color,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(4.h),
      child: Text(
        title,
        style: TextStyle(
            color: color,
            fontSize: 13.sp,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600),
      ),
    );
  }
}
