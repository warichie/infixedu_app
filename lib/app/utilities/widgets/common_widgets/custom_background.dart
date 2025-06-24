import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomBackground extends StatelessWidget {
  final Widget customWidget;
  final double? height;
  final double? width;
  final Color? color;

  const CustomBackground({
    super.key,
    required this.customWidget,
    this.height,
    this.width,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10.0.w, right: 10.w, top: 15.w,),
      child: Container(
        height:  Get.height,
        width:  Get.width,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
            color: color ?? Colors.white),
        child: customWidget,
      ),
    );
  }
}
