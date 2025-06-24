import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/app/utilities/extensions/widget.extensions.dart';
import 'package:get/get.dart';

import '../../../../data/constants/app_text_style.dart';
import '../../../../utilities/widgets/button/primary_button.dart';
import '../../../../utilities/widgets/common_widgets/custom_container_widget.dart';

class OtherDownloadsTile extends StatelessWidget {
  final String? contentTitle;
  final String? topic;
  final String? date;
  final String? description;
  final Function()? onTap;

  const OtherDownloadsTile({
    super.key,
    this.contentTitle,
    this.topic,
    this.date,
    this.description,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CustomContainerWidget(
          borderColor: const Color(0xFFEAE7F0),
          color: Colors.white,
          borderWidth: 1,
          requiredWidget: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  contentTitle ?? "",
                  style: AppTextStyle.fontSize16lightBlackW500,
                  overflow: TextOverflow.ellipsis,
                ),
                7.horizontalSpacing,
                5.verticalSpacing,
                Text(
                  topic ?? "",
                  style:
                      TextStyle(fontWeight: FontWeight.w300, fontSize: 11.sp),
                ),
                topic!.isNotEmpty ? 5.h.verticalSpacing : const SizedBox(),
                if (description != null && (description ?? '').isNotEmpty)
                  Text(description ?? ''),
                if (description != null && (description ?? '').isNotEmpty)
                  10.verticalSpacing,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: SecondaryButton(
                        height: 28,
                        onTap: onTap,
                        title: "Download".tr,
                      ),
                    ),
                    10.horizontalSpacing,
                    Flexible(
                      child: Text(
                        "${"Date".tr} : $date",
                        style: AppTextStyle.fontSize14BlackW400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
