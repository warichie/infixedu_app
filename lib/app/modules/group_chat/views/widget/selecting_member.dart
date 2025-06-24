import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/data/constants/app_text_style.dart';
import 'package:infixedu/app/data/constants/image_path.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:infixedu/app/utilities/widgets/appbar/back_button_widget.dart';
import 'package:get/get.dart';

class SelectingMember extends StatelessWidget {
  final TextEditingController searchTextController;
  final Function(String) onChange;
  final Function()? backOnTap;
  final String? iconData;
  final Function()? onAddButtonTap;
  final TextStyle? textStyle;

  const SelectingMember({
    super.key,
    required this.searchTextController,
    this.iconData,
    required this.onChange,
    this.onAddButtonTap,
    this.textStyle,
    this.backOnTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        20.h.verticalSpacing,
        Row(
          children: [
            BackButtonWidget(
              color: Colors.black,
              onTap: backOnTap,
            ),
            10.w.horizontalSpacing,
            Text(
              "Add People".tr,
              style: AppTextStyle.fontSize16lightBlackW500,
            ),
            const Spacer(),
            InkWell(
              onTap: onAddButtonTap,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Add".tr,
                  style: textStyle,
                ),
              ),
            ),
            20.w.horizontalSpacing,
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20.0.w,
            vertical: 15.h,
          ),
          child: TextField(
            controller: searchTextController,
            decoration: InputDecoration(
              hintText: 'Search'.tr,
              hintStyle: AppTextStyle.fontSize13BlackW400,
              // suffixIcon: searchTextController.text.isNotEmpty
              //     ? InkWell(
              //   onTap: () {
              //     controller.searchController.clear();
              //     controller.searchChatDataList.clear();
              //   },
              //   child: Icon(
              //     Icons.close,
              //     color: AppColors.profileDividerColor,
              //     size: 20,
              //   ),
              // )
              //     : Icon(
              //   Icons.search,
              //   color:
              //   const Color(0xFFFFFFFF).withOpacity(0.3),
              //   size: 20,
              // ),
              contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
              focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: const Color(0xFF635976).withOpacity(0.2)),
                borderRadius: BorderRadius.circular(20.0.r),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: const Color(0xFF635976).withOpacity(0.2)),
                borderRadius: BorderRadius.circular(20.0.r),
              ),
            ),
            onChanged: onChange,
            style: AppTextStyle.fontSize13BlackW400,
          ),
        ),
      ],
    );
  }
}
