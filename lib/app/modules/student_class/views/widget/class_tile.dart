import 'package:flutter/material.dart';
import 'package:infixedu/app/data/constants/app_colors.dart';
import 'package:infixedu/app/data/constants/app_text_style.dart';
import 'package:get/get.dart';

class ClassTile extends StatelessWidget {
  final String? onlineClassTitle;
  final TextStyle? onlineClassTitleTextStyle;
  final String? onlineClassSubTitle;
  final String? onlineClassMeeting;
  final Function()? onTap;
  final Function()? onSubTitleTap;
  final Function()? onMeetingTap;
  final bool isTapped;
  final bool isStudent;
  final bool isParent;

  const ClassTile(
      {super.key,
      this.onlineClassTitle,
      this.onTap,
      this.onlineClassSubTitle,
      this.onlineClassTitleTextStyle,
      this.isTapped = false,
      this.onSubTitleTap,
      this.onlineClassMeeting,
      this.onMeetingTap,
      this.isStudent = false,
      this.isParent = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        child: Column(
          children: [
            InkWell(
              onTap: onTap,
              child: AnimatedContainer(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border:
                      Border.all(width: 1, color: AppColors.borderColorEAE7F0),
                  borderRadius: BorderRadius.only(
                    topRight: const Radius.circular(8),
                    topLeft: const Radius.circular(8),
                    bottomLeft: Radius.circular(isTapped ? 0 : 8),
                    bottomRight: Radius.circular(isTapped ? 0 : 8),
                  ),
                  color: isTapped ? AppColors.primaryColor : Colors.white,
                ),
                duration: const Duration(milliseconds: 500),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        onlineClassTitle ?? "",
                        style: isTapped
                            ? AppTextStyle.cardTextStyle14WhiteW500
                            : AppTextStyle.primaryFont14,
                      ),
                      isTapped
                          ? const SizedBox()
                          : const Icon(
                              Icons.arrow_forward_ios_outlined,
                              color: AppColors.primaryColor,
                            )
                    ],
                  ),
                ),
              ),
            ),
            isTapped && !isParent
                ? InkWell(
                    onTap: onSubTitleTap,
                    child: Container(
                      width: Get.width,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            width: 1, color: AppColors.borderColorEAE7F0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          onlineClassSubTitle ?? "",
                          style: AppTextStyle.primaryFont14,
                        ),
                      ),
                    ),
                  )
                : const SizedBox(),
            isTapped && !isStudent
                ? InkWell(
                    onTap: onMeetingTap,
                    child: Container(
                      width: Get.width,
                      padding: const EdgeInsets.all(8),
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          onlineClassMeeting ?? "",
                          style: AppTextStyle.primaryFont14,
                        ),
                      ),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
