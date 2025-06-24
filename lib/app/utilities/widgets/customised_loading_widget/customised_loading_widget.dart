import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/data/constants/app_colors.dart';

class SecondaryLoadingWidget extends StatelessWidget {
  final bool isBottomNav;

  const SecondaryLoadingWidget({
    super.key,
    this.isBottomNav = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: isBottomNav ? 65.h : 100.h,
      margin: EdgeInsets.symmetric(horizontal: isBottomNav ? 10 : 0),
      padding: EdgeInsets.symmetric(
          vertical: isBottomNav ? 10 : 0, horizontal: isBottomNav ? 10 : 0),
      color: isBottomNav ? Colors.white : Colors.transparent,
      child: Center(
        child: Platform.isIOS
            ? CupertinoActivityIndicator(
                color: AppColors.primaryColor,
                radius: 24.w,
              )
            : const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(
                  AppColors.primaryColor,
                ),
              ),
      ),
    );
  }
}
