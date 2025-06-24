import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/data/constants/app_colors.dart';
import 'package:infixedu/app/data/constants/app_text_style.dart';
import 'package:infixedu/app/data/constants/image_path.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:infixedu/app/utilities/widgets/appbar/back_button_widget.dart';
import 'package:get/get.dart';

class FilesPopupDialog extends StatelessWidget {
  final TabController? tabController;
  final int tabBarLength;
  final List<Widget>? tabs;
  final Function(int)? onTap;
  final int? numberOfImage;
  final String? imageUrl;
  final Widget? imageWidget;
  final Widget? fileWidget;

  const FilesPopupDialog({
    super.key,
    this.tabController,
    required this.tabBarLength,
    this.tabs,
    this.onTap,
    this.numberOfImage,
    this.imageUrl,
    this.imageWidget,
    this.fileWidget,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabBarLength,
      child: Column(
        children: [
          20.h.verticalSpacing,
          Row(
            children: [
              15.w.horizontalSpacing,
              BackButtonWidget(
                color: Colors.black,
              ),
              30.horizontalSpacing,
              Text(
                "Images and Files".tr,
                style: AppTextStyle.fontSize16lightBlackW500,
              ),
            ],
          ),
          20.h.verticalSpacing,
          TabBar(
            labelColor: AppColors.profileValueColor,
            unselectedLabelColor: Colors.black,
            unselectedLabelStyle: AppTextStyle.fontSize12LightGreyW500,
            labelStyle: AppTextStyle.fontSize12LightGreyW500,
            indicatorColor: AppColors.profileIndicatorColor,
            indicatorSize: TabBarIndicatorSize.tab,
            controller: tabController,
            tabs: tabs!,
            onTap: onTap,
          ),
          10.verticalSpacing,
          Expanded(
            child: TabBarView(
              controller: tabController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                imageWidget!,
                fileWidget!,
              ],
            ),
          )
        ],
      ),
    );
  }
}
