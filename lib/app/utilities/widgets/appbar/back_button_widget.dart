import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({super.key, this.onTap, this.color = Colors.white});

  final Function()? onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        onTap != null ? onTap!() : Get.back();
      },
      child: Container(
        color: Colors.transparent,
        margin: ScreenUtil().deviceType(Get.context!) == DeviceType.tablet ? EdgeInsets.only(right: 5.w) : null,
        height: 40,
        width: 40,
        child: Platform.isAndroid
            ?  Icon(Icons.arrow_back, color: color,size: 20.w,)
            :  Icon(Icons.arrow_back_ios_new_outlined, color: color ,size: 17.w
        ),
      ),
    );
  }
}
