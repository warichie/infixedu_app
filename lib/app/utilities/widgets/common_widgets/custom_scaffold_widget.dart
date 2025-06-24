import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/data/constants/app_colors.dart';
import 'package:infixedu/app/utilities/widgets/appbar/custom_appbar.dart';
import 'package:get/get.dart';

class InfixEduScaffold extends StatelessWidget {
  final String? title;
  final Widget? leadingIcon;
  final Widget? body;
  final Widget? appBar;
  final List<Widget>? actions;
  final Widget? bottomNavBar;
  final Widget? floatingActionButton;
  final Widget? titleWidget;
  final double? appBarHeight;
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  const InfixEduScaffold({
    super.key,
    this.title,
    this.body,
    this.appBar,
    this.leadingIcon,
    this.actions,
    this.bottomNavBar,
    this.floatingActionButton,
    this.titleWidget,
    this.appBarHeight,
    this.floatingActionButtonLocation,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.backgroundPrimaryColor,
              AppColors.backgroundSecondaryColor
            ]),
      ),
      // height: Get.height,
      width: Get.width,
      child: Scaffold(
        backgroundColor: Colors.white.withOpacity(0),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(appBarHeight?.h ?? 47.h),
          child: appBar ??
              CustomAppBar(
                leadingIcon: leadingIcon,
                title: title,
                actions: actions,
                titleWidget: titleWidget,
              ),
        ),
        body: body,
        bottomNavigationBar: bottomNavBar,
        floatingActionButton: floatingActionButton,
        floatingActionButtonLocation: floatingActionButtonLocation,
      ),
    );
  }
}
