import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomElevatedButton extends StatelessWidget {
  final Function() onPressed;
  final String text;
  final Color? backgroundColor;
  final TextStyle? textStyle;
  final double? topLeft;
  final double? topRight;
  final double? bottomLeft;
  final double? bottomRight;

  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.backgroundColor,
    this.textStyle,
    this.topLeft,
    this.topRight,
    this.bottomLeft,
    this.bottomRight,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
            backgroundColor: backgroundColor ?? Colors.purpleAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(topLeft ?? .0),
                bottomLeft: Radius.circular(bottomLeft ?? .0),
                topRight: Radius.circular(topRight ?? .0),
                bottomRight: Radius.circular(bottomRight ?? .0),
              ),
            )),
        child: Text(
          text,
          style:
              textStyle ?? TextStyle(fontSize: 12.sp, color: Colors.white),
        ),
      ),
    );
  }
}
