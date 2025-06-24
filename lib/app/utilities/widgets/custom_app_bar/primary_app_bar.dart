import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/data/constants/app_colors.dart';
import '../../../data/constants/image_path.dart';

class PrimaryAppBar extends StatelessWidget {
  final String title;
  final List<Widget>? actions;

  const PrimaryAppBar({super.key, required this.title, this.actions});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10.0.h, left: 10.w, right: 10.w),
      child: AppBar(
        backgroundColor: AppColors.primaryColor.withOpacity(0),
        elevation: 0,
        title: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 20.h,
                  width: 60.w,
                  alignment: Alignment.centerLeft,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(ImagePath.appLogo),
                    ),
                  ),
                ),
                Text(
                  title,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w400),
                )
              ],
            ),
          ],
        ),
        actions: actions,
      ),
    );
  }
}
