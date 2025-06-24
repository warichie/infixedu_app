import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/data/constants/app_text_style.dart';
import 'package:infixedu/app/data/constants/image_path.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:infixedu/app/utilities/widgets/common_widgets/custom_divider.dart';
import 'package:infixedu/app/utilities/widgets/image_view/cache_image_view.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import '../../../../data/constants/app_colors.dart';

class ChatTile extends StatelessWidget {
  final String? profileImageUrl;
  final String? name;
  final String? message;
  final String? messageReceivedTime;
  final String? numberOfUnreadMessage;
  final Color? unreadMessageColor;
  final Function()? onTap;
  final Function()? onTapUnblock;
  final Color? activeStatusColor;
  final bool isBlocked;

  const ChatTile({
    super.key,
    this.profileImageUrl,
    this.name,
    this.message,
    this.messageReceivedTime,
    this.numberOfUnreadMessage,
    this.unreadMessageColor,
    this.onTap,
    this.activeStatusColor,
    this.isBlocked = false,
    this.onTapUnblock,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0.w),
        child: Column(
          children: [
            Row(
              children: [
                Stack(
                  alignment: AlignmentDirectional.center,
                  children: <Widget>[
                    profileImageUrl == ''
                        ? Container(
                            height: (Get.height * 0.1),
                            width: Get.width * 0.15,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 1,
                                color: AppColors.borderColorEAE7F0,
                              ),
                              image: DecorationImage(
                                image: AssetImage(ImagePath.dp),
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        : Container(
                            height: Get.height * 0.1,
                            width: Get.width * 0.15,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 1,
                                color: AppColors.borderColorEAE7F0,
                              ),
                            ),
                            child: CacheImageView(
                              url: profileImageUrl,
                              errorImageLocal: ImagePath.errorImage,
                            ),
                          ),
                    Positioned(
                      right: Get.width * 0.015,
                      top: Get.height * 0.02,
                      child: Container(
                        height: 8.w,
                        width: 8.w,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: activeStatusColor),
                      ), //Icon
                    ),
                  ], //<Widget>[]
                ),
                10.w.horizontalSpacing,
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        name ?? "",
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyle.blackFontSize14W400,
                      ),
                      5.h.verticalSpacing,
                      SizedBox(
                        width: Get.width * 0.48,
                        child: HtmlWidget(
                          message ?? "",
                          textStyle: TextStyle(
                            color: unreadMessageColor,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                isBlocked
                    ? InkWell(
                        onTap: onTapUnblock,
                        child: Container(
                          padding: EdgeInsets.all(7.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: AppColors.activeStatusGreenColor,
                          ),
                          child: Text(
                            "Unblock".tr,
                            style: AppTextStyle.cardTextStyle14WhiteW500,
                          ),
                        ),
                      )
                    : Text(
                        messageReceivedTime ?? "",
                        style: AppTextStyle.fontSize10Color8489ABW400,
                      ),
              ],
            ),

            // 10.verticalSpacing,
            CustomDivider(
              width: Get.width,
              color: AppColors.transportDividerColor,
            ),
          ],
        ),
      ),
    );
  }
}
